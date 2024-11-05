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
+ Ifrit code is updated to swift's latest standards and there are no build warnings :)

+ Ifrit - extended coverage with automated tests in general :)
+ Ifrit have additional search system using Levenstain distance algorythm :)
+ Ifrit have ability to search by several templates
+ Ifrit have a little bit changed syntax to be more flexible.
+ Ifrit's sync search faster than Fuse's on 2% (standard settings) using M1 processor.
+         Async search have tha same speed (standard settings).
```

## Contributing

Ifrit welcomes contributions in the form of GitHub issues and pull-requests.

## Installation

1. XCode -> Menu Line -> Add Package Dependencies -> `https://github.com/ukushu/Ifrit.git`

2. `import Ifrit` to your source files.

  [1]: https://i.sstatic.net/8MwFeAHT.gif

  
## Documentation / Instructions / Example Project

Ifrit repository have no example project. Use instructions below:

[How to use Ifrit's Fuse](https://github.com/ukushu/Ifrit/blob/main/Documentation/FuseInstructions.md)

[How to use Ifrit's Levenstain](https://github.com/ukushu/Ifrit/blob/main/Documentation/LevenstainInstructions.md)

[How to display search results in UI](https://github.com/ukushu/Ifrit/blob/main/Documentation/HowToUseSrchResult.md)


## 🇺🇦🇺🇦🇺🇦 UKRAINE NEEDS YOUR SUPPORT! 🇺🇦🇺🇦🇺🇦

Mariupol city before Russia invasion (2021):
<img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmistomariupol.com.ua%2Fwp-content%2Fuploads%2F2021%2F03%2Fdji_0301.mp4_snapshot_00.00.993-scaled.jpg" width="800" height="500">

Mariupol city after Russia invasion (2022):

( ruined almost all infrastructure )

<img src="https://www.ukrainianworldcongress.org/wp-content/uploads/2024/01/032522mariupol1_1920x1080.jpg" width="800" height="500">

<img src="https://truthout.org/app/uploads/2022/04/2022_0411-mariupol-ukraine-scaled.jpg" width="800" height="500">

Destruction of the Kakhovka Dam
==

Russia destroyed Kakhovka Dam in the early hours of 6 June 2023 in Kherson Oblast. This was the second-largest reservoir in Ukraine by area (2,155 km2 [832 sq mi]) and the largest by water volume (18.19 km3 [4.36 cu mi]).
According to Ukrainian military intelligence, Russian forces carried out "major mining" of the Kakhovka dam shortly after taking control in February 2022, and in April 2022 mined locks and supports and installed "tented trucks with explosives on the dam itself". In October 2022, the Foreign Minister of Moldova, Nicu Popescu, said that Ukraine had intercepted Russian missiles targeting a different dam, on the Dniester river. At the time, Ukrainian president Zelenskyy warned of Russian preparations to destroy the Kakhovka dam and blame Ukraine, and called for an international observation mission at the dam to prevent a potential catastrophe.

<img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftelegraf.com.ua%2Fstatic%2Fstorage%2Foriginals%2F0%2F63%2F007c82db0653baa77e7fb321b7dc0630.jpg" width="800" height="350">


The capacity of the Kakhovka reservoir was 18 million cubic meters of fresh water. 
==
This reservoir could have provided all people on the planet with fresh water for more than 2 years. And this water was lost. 

Not to mention the flooded residential areas and the environmental disaster caused by the washing away of cemeteries and desalination of water in the Black Sea.

<img src="https://upload.wikimedia.org/wikipedia/commons/c/c6/Ukrainereservoir_oli2_2023169.jpg" width="800" height="800">



