## Ifrit - Usage of `Fuse`

#### Searching in a `String`

```swift
let fuse = Fuse()

// SYNC search
let result = fuse.searchSync("od mn war", in: "Old Man's War")

print(result?.score)  // 0.44444444444444442 // LOWEST SCORE = BETTER
print(result?.ranges) // [CountableClosedRange(0...0), CountableClosedRange(2...6), CountableClosedRange(9...12)]

// --------------------
// ASYNC search - async/await

// --------------------
// ASYNC search - callbacks

```

#### Search in `[String]`

```swift
let books = ["The Silmarillion", "The Lock Artist", "The Lost Symbol"]
let fuse = Fuse()

// SYNC search
let results = fuse.searchSync("Te silm", in: books)

results.forEach { item in
    print("""
        index: \(item.index)
        score: \(item.score)
        ranges: \(item.ranges)
        ---------------
        """
    )
}

// --------------------
// ASYNC search - async/await
let results = await fuse.search("Te silm", in: books)

results.forEach { item in
    print("""
        index: \(item.index)
        score: \(item.score)
        ranges: \(item.ranges)
        ---------------
        """
    )
}

// --------------------
// ASYNC search - callbacks
fuse.search("Te silm", in: books, completion: { results in
    results.forEach { item in
        print("""
            index: \(item.index)
            score: \(item.score)
            ranges: \(item.ranges)
            ---------------
            """
        )
    }
})
```

#### Search in `[Fuseable]` objects

```swift
struct Book: Fuseable {
    let title: String
    let author: String
    
    var properties: [FuseProp] {
        return [
            FuseProp(title, weight: 0.3),
            FuseProp(author, weight: 0.7)
        ]
    }
    //Or this like:
    //var properties: [FuseProp] {
    //    return [title, author].map{ FuseProp($0) }
    //}
}

let books: [Book] = [
    Book(author: "John X", title: "Old Man's War fiction"),
    Book(author: "P.D. Mans", title: "Right Ho Jeeves")
]
let fuse = Fuse()

// --------------------
// SYNC version
let results = fuse.searchSync("man", in: books)

results.forEach { item in
    print("index: \(item.index); score: \(item.score)")
}

// --------------------
// ASYNC: async/await
let results = await fuse.search("Man", in: books)

results.forEach { item in
    print("index: \(item.index); score: \(item.score)")
}

// ASYNC: callbacks
fuse.search("Man", in: books, completion: { results in
    results.forEach { item in
        print("index: \(item.index); score: \(item.score)")
    }
})
```

### How to use Ifrit with Attributed String (SwiftUI)

( NSAttributed string is similar )

```swift
import SwiftUI

@available(macOS 12, *)
func attributedString(_ fuzz: FusableSearchResult, _ string: String) -> AttributedString {
    var attributedString = AttributedString(string)
    for result in fuzz.results {
        if result.value != string { continue }
        let ranges = result.ranges
        for range in ranges {
            // Convert CountableClosedRange<Int> to Range<AttributedString.Index>
            if let start = attributedString.index(at: range.lowerBound),
               let end = attributedString.index(at: range.upperBound + 1) {
                let attributedRange = start..<end
                
                // Apply attributes using AttributeContainer
                var container = AttributeContainer()
                container.foregroundColor = .red
                attributedString[attributedRange].setAttributes(container)
            }
        }
    }

    return attributedString
}

@available(macOS 12, *)
extension AttributedString {
    func index(at offset: Int) -> AttributedString.Index? {
        return index(startIndex, offsetByCharacters: offset)
    }
}
```

### `Fuse` Options

`Fuse` takes the following options:

- `location`: Approximately where in the text is the pattern expected to be found. Defaults to `0`
- `distance`: Determines how close the match must be to the fuzzy `location` (specified above). An exact letter match which is `distance` characters away from the fuzzy location would score as a complete mismatch. A distance of `0` requires the match be at the exact `location` specified, a `distance` of `1000` would require a perfect match to be within `800` characters of the fuzzy location to be found using a `0.8` threshold. Defaults to `100`
- `threshold`: At what point does the match algorithm give up. A threshold of `0.0` requires a perfect match (of both letters and location), a threshold of `1.0` would match anything. Defaults to `0.6`
- `maxPatternLength`: The maximum valid pattern length. The longer the pattern, the more intensive the search operation will be. If the pattern exceeds the `maxPatternLength`, the `search` operation will return `nil`. Why is this important? [Read this](https://en.wikipedia.org/wiki/Word_(computer_architecture)#Word_size_choice). Defaults to `32`
- `isCaseSensitive`: Indicates whether comparisons should be case sensitive. Defaults to `false`

