## Ifrit - Usage of `Levenstain` distance search

Also ifrit contains `Levenstain distance` -- distance between 2 strings algorythm. 

Also is awailable `Levenstain distance search` in collections.

Search using `Fuse` works better in general. But in some cases `Levenstain distance` this also can be useful - it's can be a bit faster in some cases.

```diff
- WARNING: LEVENSTAIN SEARCH ignores weight parameter form `Fusable`'s `FuseProp`.
- WARNING: LEVENSTAIN SEARCH returns the same search result: `[Fuse.SearchResult]`, but this result have EMPTY RANGES PROPERTY.
- WARNING: LEVENSTAIN SEARCH: async functions is not supported at the moment.
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

let result = Levenstain.searchSync("Fairy Tail the Movie: The Phoenix Priestess", in: animes, by: \AnimeListInfo.properties )

// --------------------
// ASYNC: async/await
// DOES NOT SUPPORTED

// --------------------
// ASYNC: callbacks
// DOES NOT SUPPORTED
```
