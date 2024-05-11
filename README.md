# Ifrit

## What is Ifrit?

Ifrit is a super lightweight library which provides a simple way to do fuzzy searching.

This repository is based on archived repository Fuze-Swift by  ( https://github.com/krisk/fuse-swift)

<!-- ![Demo](https://s17.postimg.org/47a90nmvj/bitap-search-demo.gif) -->

## Difference: Ifrit VS Fuze-Swift?
```diff
- Fuze-Swift is dead
+ Ifrit is live :)
- Fuze-Swift have threading issue - crashes is possible
+ Ifrit is a Fuze-Swift with fixed Threading issues - no crashes :)
- Fuze-Swift written for xcode 11 and have warnings
+ Ifrit have fixes xcode 15 build warnings and code is updated to swift 5 standards
```

## Usage

#### Searching in a string

```swift
let fuse = Fuse()
let result = fuse.search("od mn war", in: "Old Man's War")

print(result?.score)  // 0.44444444444444442
print(result?.ranges) // [CountableClosedRange(0...0), CountableClosedRange(2...6), CountableClosedRange(9...12)]
```

#### Searching in an array of strings

```swift
let books = ["The Silmarillion", "The Lock Artist", "The Lost Symbol"]
let fuse = Fuse()

let results = fuse.search("Te silm", in: books)

results.forEach { item in
    print("index: " + item.index)
    print("score: " + item.score)
    print("ranges: " + item.ranges)
}
```

##### Asynchronous version

```swift
fuse.search("Te silm", in: books, completion: { results in
    results.forEach { item in
        print("index: " + item.index)
        print("score: " + item.score)
        print("ranges: " + item.ranges)
    }
})
```

#### Searching in an array of `Fuseable` objects.

```swift
struct Book: Fuseable {
    let title: String
    let author: String

    var properties: [FuseProperty] {
        return [
            FuseProperty(value: title, weight: 0.3),
            FuseProperty(value: author, weight: 0.7)
        ]
    }
}

let books: [Book] = [
    Book(title: "Old Man's War fiction", author: "John X"),
    Book(title: "Right Ho Jeeves", author: "P.D. Mans")
]
let fuse = Fuse()
let results = fuse.search("man", in: books)

results.forEach { item in
    print("index: " + item.index)
    print("score: " + item.score)
    print("results: " + item.results)
    print("---------------")
}

// Output:
//
// index: 1
// score: 0.015000000000000003
// results: [(value: "P.D. Mans", score: 0.015000000000000003, ranges: [CountableClosedRange(5...7)])]
// ---------------
// index: 0
// score: 0.027999999999999997
// results: [(value: "Old Man\'s War fiction", score: 0.027999999999999997, ranges: [CountableClosedRange(4...6)])]
```

##### Asynchronous version

```swift
fuse.search("Man", in: books, completion: { results in
    results.forEach { item in
        print("index: " + item.index)
        print("score: " + item.score)
        print("results: " + item.results)
        print("---------------")
    }
})
```

### Options

`Fuse` takes the following options:

- `location`: Approximately where in the text is the pattern expected to be found. Defaults to `0`
- `distance`: Determines how close the match must be to the fuzzy `location` (specified above). An exact letter match which is `distance` characters away from the fuzzy location would score as a complete mismatch. A distance of `0` requires the match be at the exact `location` specified, a `distance` of `1000` would require a perfect match to be within `800` characters of the fuzzy location to be found using a `0.8` threshold. Defaults to `100`
- `threshold`: At what point does the match algorithm give up. A threshold of `0.0` requires a perfect match (of both letters and location), a threshold of `1.0` would match anything. Defaults to `0.6`
- `maxPatternLength`: The maximum valid pattern length. The longer the pattern, the more intensive the search operation will be. If the pattern exceeds the `maxPatternLength`, the `search` operation will return `nil`. Why is this important? [Read this](https://en.wikipedia.org/wiki/Word_(computer_architecture)#Word_size_choice). Defaults to `32`
- `isCaseSensitive`: Indicates whether comparisons should be case sensitive. Defaults to `false`

## Example Project

!!!!!!!!!!!
Ifrit repository have no example project.
!!!!!!!!!!!

As example project you can use project from original [Fuse-Swift repository](https://github.com/krisk/fuse-swift)
To run the example project:
* clone the Fuse-Swift( https://github.com/krisk/fuse-swift.git ) repo
* and run `pod install` from the Example directory first.

## Requirements

## Installation

1. Add a dependency on Fuse:
- CocoaPods: add `pod 'Fuse'` to your `Podfile`. 
- Carthage: add `github "krisk/fuse-swift"` to your `Cartfile`.

2. Add `import Fuse` to your source files.
