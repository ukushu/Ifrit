# Ifrit - Usage of `Fuse`

### `Fuse` instance Options

`Fuse` takes the following options:

- `location`: Approximately where in the text is the pattern expected to be found. Defaults to `0`
- `distance`: Determines how close the match must be to the fuzzy `location` (specified above). An exact letter match which is `distance` characters away from the fuzzy location would score as a complete mismatch. A distance of `0` requires the match be at the exact `location` specified, a `distance` of `1000` would require a perfect match to be within `800` characters of the fuzzy location to be found using a `0.8` threshold. Defaults to `100`
- `threshold`: At what point does the match algorithm give up. A threshold of `0.0` requires a perfect match (of both letters and location), a threshold of `1.0` would match anything. Defaults to `0.6`
- `isCaseSensitive`: Indicates whether comparisons should be case sensitive. Defaults to `false`
- `tokenize`: When `true`, the search algorithm will search individual words **and** the full string, computing the final score as a function of both. Note that when `tokenize` is `true`, the `threshold`, `distance`, and `location` are inconsequential for individual tokens.
- `qos`: quality-of-service, use this to set search task priority. Better never use `user-interactive`. By default is `userInitiated`.

#### Searching in a `String` using `Fuse`

```swift
let fuse = Fuse()

// SYNC search
let result = fuse.searchSync("od mn war", in: "Old Man's War")

print(result!.score)  // 0.44444444444444442 // LOWEST SCORE = BETTER
print(result!.ranges) // [CountableClosedRange(0...0), CountableClosedRange(2...6), CountableClosedRange(9...12)]

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
let results1 = fuse.searchSync("Te silm", in: books)

results1.forEach { item in
    print("""
        index: \(item.index)
        score: \(item.diffScore)
        ranges: \(item.ranges)
        ---------------
        """
    )
}

// --------------------
// ASYNC search - async/await
let results2 = await fuse.search("Te silm", in: books)

results2.forEach { item in
    print("""
        index: \(item.index)
        score: \(item.diffScore)
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
            score: \(item.diffScore)
            ranges: \(item.ranges)
            ---------------
            """
        )
    }
})
```

#### Search in `[[FuseProp]]`

A `FuseProp` is a struct of searchable values and the weights to assign to them.

```swift
public struct FuseProp : Sendable {
    public let value: String
    public let weight: Double
    
    public init (_ value: String, weight: Double = 1.0) {
        self.value = value
        
        self.weight = weight
    }
}
```

So, suppose you have an array of `Book` objects, like this:

```swift
struct Book {
    let author: String
    let title: String
}

let books: [Book] = [
    Book(author: "John X", title: "Old Man's War fiction"),
    Book(author: "P.D. Mans", title: "Right Ho Jeeves")
]
```

You could convert each book to an array of `FuseProp` objects and search them like this:

```swift
class MyModel: @retroactive Searchable {
    var books: [Book] = // books
    
    public var srchUkrBookNames: [FuseProp] {
        namesUkr
            .appending(contentsOf: namesUkrCust)
            .distinct()
            .map { FuseProp($0) }
    }
    
    public var srchEngBookNames: [FuseProp] {
        namesOther
            .appending(contentsOf: namesEngCust)
            .distinct()
            .map { FuseProp($0) }
    }
}
```

```
let fuse = Fuse()

// --------------------
// SYNC version
let resultsSync = fuse.searchSync("man", in: srchEngBookNames)

resultsSync.forEach { item in
    print("index: \(item.index); score: \(item.diffScore)")
}

// --------------------
// ASYNC: async/await
let resultsAsync = await fuse.search("Man", in: srchEngBookNames)

resultsAsync.forEach { item in
    print("index: \(item.index); score: \(item.diffScore)")
}

// ASYNC: callbacks
fuse.search("Man", in: srchEngBookNames, completion: { results in
    results.forEach { item in
        print("index: \(item.index); score: \(item.diffScore)")
    }
})
```

You can also add weights to your `FuseProp` objects. This example would prioritize author matches over title matches:

```swift
let fuseProps = books.map({book in 
    [
        FuseProp(value: book.title, weight: 0.3),
        FuseProp(value: book.author, weight: 0.7),
    ]
})
```

#### Search in `[Searchable]` objects

Declaration of `Searchable` object:

```swift
struct Book: Searchable {
    let title: String
    let author: String
}

extension Book: Searchable {
    
    ///////////////////
    // each FuseProp weight == 1
    var properties: [FuseProp] {
        return [title, author].map{ FuseProp($0) }
    }
    
    ///////////////////
    // each FuseProp have custom weight
    var propertiesCustomWeight: [FuseProp] {
        return [
            FuseProp(title, weight: 0.3),
            FuseProp(author, weight: 0.7)
        ]
    }
}
```

```diff

+ Important thing: note that you're able to have in `Searchable` obj several blocks of "search fields" ( `[FuseProp]` ) 
+ Each block can be used for different situations for single object type. Or with different weights ofc :)
+ 
+ Use case sample:
+ if your user search in ukrainian language - you need to search string in ukrainian language titles.
+ In case of english - only in english titles. Optimization, bro! :D
```


Sample for use with arrays:

```swift
struct Library: Fuseable {
    let titles: [String]
    let authors: [String]
    
    var arrayProperties: [FuseProp] {
        return titles
                 .appending(contentOf: authors)
                 .map{ FuseProp($0) }
    }
}
```


#### Search in `[Searchable]` objects

```swift
// --------------------
// Intro :)
struct Book: Searchable {
    let author: String
    let title: String
    
    var properties: [FuseProp] { [title, author].map{ FuseProp($0) } }
}

let books: [Book] = [
    Book(author: "John X", title: "Old Man's War fiction"),
    Book(author: "P.D. Mans", title: "Right Ho Jeeves")
]

let fuse = Fuse()
//---------------------


// --------------------
// SYNC version
let resultsSync = fuse.searchSync("man", in: books, by: \Book.properties)

resultsSync.forEach { item in
    print("index: \(item.index); score: \(item.diffScore)")
}

// --------------------
// ASYNC: async/await
let resultsAsync = await fuse.search("Man", in: books, by: \Book.properties)

resultsAsync.forEach { item in
    print("index: \(item.index); score: \(item.diffScore)")
}

// ASYNC: callbacks
fuse.search("Man", in: books, by: \Book.properties, completion: { results in
    results.forEach { item in
        print("index: \(item.index); score: \(item.diffScore)")
    }
})
```
