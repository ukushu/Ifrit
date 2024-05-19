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

## Instructions

[How to use Fuse from Ifrit](https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md)

[How to use Levenstain from Ifrit](https://github.com/ukushu/Ifrit/blob/main/Docs/LevenstainInstructions.md)


## Example Project

```diff
- Ifrit repository have no example project. Use instructions instead.
```

But also as example project you can use project from original [Fuse-Swift repository](https://github.com/krisk/fuse-swift)
To run the example project:
* clone the Fuse-Swift( https://github.com/krisk/fuse-swift.git ) repo
* and run `pod install` from the Example directory first.

## Installation

1. XCode -> Menu Line -> Add Package Dependencies -> `https://github.com/ukushu/Ifrit.git`

2. `import Ifrit` to your source files.

  [1]: https://i.sstatic.net/8MwFeAHT.gif
