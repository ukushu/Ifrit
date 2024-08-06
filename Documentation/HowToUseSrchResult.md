# How to display search results in UI

### How to use Ifrit with `AttributedString` (SwiftUI)

```diff
- This samples can be a little bit outdated, but still usefull
```

```swift
import SwiftUI

@available(macOS 12, *)
func attributedString(_ fuzz: FuzzySrchResult, _ string: String) -> AttributedString {
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

### How to use Ifrit with `NSAttributedString`

```diff
- You can improve this code to style of sample with AttributedString,
- this is just code copy from FuseSwift sample project
```

```diff
let results = fuse.search(searchText, in: books)

var filteredBooks = [NSAttributedString]()

filteredBooks = results.map { (index, _, matchedRanges) in
    let book = books[index]
    
    let attributedString = NSMutableAttributedString(string: book)
    matchedRanges
        .map(Range.init)
        .map(NSRange.init)
        .forEach {
            attributedString.addAttributes(boldAttrs, range: $0)
        }
    
    return attributedString
}
```
