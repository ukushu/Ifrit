# Ifrit

<img src="https://raw.githubusercontent.com/ukushu/Ifrit/main/Ifrit_Logo_360.png" width="150" height="150">

```
https://github.com/ukushu/Ifrit.git
git@github.com:ukushu/Ifrit.git
```
🇺🇦🇺🇦🇺🇦 PLEASE, SUPPORT UKRAINE! 🇺🇦🇺🇦🇺🇦

## What is Ifrit?
Ifrit is fuzzy search library written in pure swift.

Advanteges:
```diff
+ Super lightweight
+ No dependencies
+ Asynchronous search ( async/await + callbacks both )
+ OS supported: MacOS(>=v10_15), iOS(>=v13), VisionOs, Linux
+ Text highlight support (AttributedString)
+ Covered with automated tests
+ Swift 5.9 and higher
+ MIT Licensed
```

Disadvantages:
```diff
- Wasn't tested in production
```

This repository is based on archived repository Fuze-Swift by KRisk ( https://github.com/krisk/fuse-swift)


## Demo

<!-- ![Demo](https://s17.postimg.org/47a90nmvj/bitap-search-demo.gif) -->

[![Ifrit demo][1]][1]


## Difference: Ifrit VS Fuze-Swift?
```diff
+ Fuze-Swift support Pods and Packages :)
- Ifrit supports only Packages :(

- Fuze-Swift is dead :(
+ Ifrit is a Fuse-Swift reborn from hell and ALIVE as ever :)

- Fuze-Swift async/multithreading issues. Crashes is possible :(
+ Ifrit is a Fuze-Swift with fixed multithreading issues - no crashes :)

- Fuze-Swift written for xcode 11 and have a lot of warnings at now :(
+ Ifrit code is updated to swift's latest standards and there are no build warnings :)

- Fuze-Swift supports async functins with callbacks, but does not support async/await
+ Ifrit supports callbacks and async/await both:)

- Fuze-Swift async functions returns incorrect results (wrong indexes) :((((
+ Ifrit's async functins returns correct indexes and covered with tests :)

+ Ifrit - extended coverage with automated tests in general :)
```

## Usage

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


## Levenstain distance

Also ifrit contains `Levenstain distance` between 2 strings. `Fuse` works better in general. But in some cases this also can be useful. Levenstain search can work a bit faster with long strings, as example. 

LEVENSTAIN SEARCH returns the same search result: `[Fuse.SearchResult]`, but this result have **EMPTY RANGES PROPERTY**.

```diff
- WARNING: LEVENSTAIN SEARCH ignores weight parameter of `FuseProp` of `Fusable` objects
- WARNING: LEVENSTAIN SEARCH returns the same search result: `[Fuse.SearchResult]`, but this result have EMPTY RANGES PROPERTY.
- WARNING: LEVENSTAIN SEARCH supports only Sync search.
```

#### Levenstain search in `[String]`
```swift
let animes = ["Gekijouban Fairy Tail: Houou no Miko",
            "Fairy Tail the Movie: The Phoenix Priestess",
            "Priestess of the Phoenix",
            "Fairy Tail: The Phoenix Priestess"]

let animesSearch = Levenstain.searchSync("Fairy Tail: The Phoenix Priestess", in: animes)

// --------------------
// ASYNC: async/await
// DOES NOT SUPPORTED

// --------------------
// ASYNC: callbacks
// DOES NOT SUPPORTED
```

#### Levenstain search in `[Fuseable]` objects
```swift
let animes = getAnimeList(count: 10) // Fusable objects

let result = Levenstain.searchSync("Fairy Tail the Movie: The Phoenix Priestess", in: animes)

// --------------------
// ASYNC: async/await
// DOES NOT SUPPORTED

// --------------------
// ASYNC: callbacks
// DOES NOT SUPPORTED
```


## Example Project

!!!!!!!!!!!
Ifrit repository have no example project.
!!!!!!!!!!!

As example project you can use project from original [Fuse-Swift repository](https://github.com/krisk/fuse-swift)
To run the example project:
* clone the Fuse-Swift( https://github.com/krisk/fuse-swift.git ) repo
* and run `pod install` from the Example directory first.

## Installation

1. XCode -> Menu Line -> Add Package Dependencies -> `https://github.com/ukushu/Ifrit.git`

2. `import Ifrit` to your source files.

  [1]: https://i.sstatic.net/8MwFeAHT.gif
