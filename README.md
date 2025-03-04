# Ifrit

<img src="https://raw.githubusercontent.com/ukushu/Ifrit/main/Ifrit_Logo_360.png" width="150" height="150">

```
https://github.com/ukushu/Ifrit.git
git@github.com:ukushu/Ifrit.git
```

## What is Ifrit?
Ifrit is fuzzy search library written in pure swift.

### What is fuzzy Search?

A fuzzy search algorithm is designed to find approximate matches for a given search query. 

Let's say you have a list of products, and a user is looking for a "Czy Swetr,". Exact match will return nothing, but the fuzzy search will find "Cozy Sweater.".

If you need exact match - you need to use standard function `.filter { }` instead of this library.

Demo of Fuzzy Search:
<!-- ![Demo](https://s17.postimg.org/47a90nmvj/bitap-search-demo.gif) -->

[![Ifrit demo][1]][1]

### Advanteges / Disadvantages of Ifrit

```diff
Advanteges:
+ Super lightweight
+ No dependencies
+ OS supported: MacOS(>=v10_15), iOS(>=v13), visionOS, watchOS, twOS, Linux
+ Asynchronous search ( async/await + callbacks both )
+ Text highlight support (AttributedString)
+ Covered with automated tests
+ MIT Licensed
+ Ability to link Ifrit as Static and Dynamic package - choose what is better in your case

Disadvantages:
- Wasn't tested in production
- Swift 5.9 and higher, older version of Swift does not supported.
```

This repository is based on archived repository Fuse-Swift by KRisk: https://github.com/krisk/fuse-swift

Swift Package Index information: https://swiftpackageindex.com/ukushu/Ifrit


## Difference: Ifrit VS Fuze-Swift?
```diff
+ Fuze-Swift support Pods and Packages :)
- Ifrit supports only Packages :(

- Fuze-Swift is dead :(
+ Ifrit is a Fuse-Swift reborn from hell and ALIVE as ever :)

- Fuze-Swift supports async functins with callbacks, but does not support async/await
+ Ifrit supports callbacks and async/await both:)

- Fuze-Swift have async/multithreading issues. Crashes is possible :(
+ Ifrit is a Fuze-Swift with fixed multithreading issues - no crashes :)

- Fuze-Swift async functions returns incorrect results (wrong indexes) :((((
+ Ifrit's async functins returns correct indexes and covered with tests :)

- Fuze-Swift written for xcode 11 and have a lot of warnings at now :(
+ Ifrit code is updated to swift's latest standards - Ifrit supports even Swift v6 :) 
- But Ifrit have a few build warnings :(

+ Ifrit - extended coverage with automated tests in general :)
+ Ifrit have additional search system using Levenstain distance algorythm :)
+ Ifrit have ability to search by several templates
+ Ifrit have a little bit changed syntax to be more flexible.
+ Ifrit's sync search faster than Fuse's on 2% (standard settings) using M1 processor.
+         Async search have tha same speed (standard settings).
```

## Installation

1. XCode -> Menu Line -> Add Package Dependencies -> `https://github.com/ukushu/Ifrit.git`

2. `import Ifrit` to your source files.

## Documentation / Instructions / Example Project

Ifrit repository have no example project. Use instructions below:

[How to use Ifrit's Fuse](https://github.com/ukushu/Ifrit/blob/main/Documentation/FuseInstructions.md)

[How to use Ifrit's Levenstain](https://github.com/ukushu/Ifrit/blob/main/Documentation/LevenstainInstructions.md)

[How to display search results in UI](https://github.com/ukushu/Ifrit/blob/main/Documentation/HowToUseSrchResult.md)

## Contributing

Ifrit welcomes contributions in the form of GitHub issues and pull-requests.

  [1]: https://i.sstatic.net/8MwFeAHT.gif
