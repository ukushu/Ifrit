//  Created by Kirollos Risk on 5/2/17

import Foundation

public class Fuse {
    internal var location: Int
    internal var distance: Int
    internal var threshold: Double
    internal var maxPatternLength: Int
    internal var isCaseSensitive: Bool
    internal var tokenize: Bool
    
    public typealias SearchResult = (index: Int, score: Double, ranges: [CountableClosedRange<Int>])
    
    internal lazy var searchQueue: DispatchQueue = { [unowned self] in
        let label = "fuse.search.queue"
        return DispatchQueue(label: label, attributes: .concurrent)
    }()
    
    /// Creates a new instance of `Fuse`
    ///
    /// - Parameters:
    ///   - location: Approximately where in the text is the pattern expected to be found. Defaults to `0`
    ///   - distance: Determines how close the match must be to the fuzzy `location` (specified above). An exact letter match which is `distance` characters away from the fuzzy location would score as a complete mismatch. A distance of `0` requires the match be at the exact `location` specified, a `distance` of `1000` would require a perfect match to be within `800` characters of the fuzzy location to be found using a 0.8 threshold. Defaults to `100`
    ///   - threshold: At what point does the match algorithm give up. A threshold of `0.0` requires a perfect match (of both letters and location), a threshold of `1.0` would match anything. Defaults to `0.6`
    ///   - maxPatternLength: The maximum valid pattern length. The longer the pattern, the more intensive the search operation will be. If the pattern exceeds the `maxPatternLength`, the `search` operation will return `nil`. Why is this important? [Read this](https://en.wikipedia.org/wiki/Word_(computer_architecture)#Word_size_choice). Defaults to `32`
    ///   - isCaseSensitive: Indicates whether comparisons should be case sensitive. Defaults to `false`
    ///   - tokenize: When true, the search algorithm will search individual words **and** the full string, computing the final score as a function of both. Note that when `tokenize` is `true`, the `threshold`, `distance`, and `location` are inconsequential for individual tokens.
    public init (location: Int = 0, distance: Int = 100, threshold: Double = 0.6, maxPatternLength: Int = 32, isCaseSensitive: Bool = false, tokenize: Bool = false) {
        self.location = location
        self.distance = distance
        self.threshold = threshold
        self.maxPatternLength = maxPatternLength
        self.isCaseSensitive = isCaseSensitive
        self.tokenize = tokenize
    }
    
    /// Creates a pattern tuple.
    ///
    /// - Parameter aString: A string from which to create the pattern tuple
    /// - Returns: A tuple containing pattern metadata
    public func createPattern(from str: String) -> Pattern? {
        guard str.count > 0 else { return nil }
        
        return Pattern(text: self.isCaseSensitive ? str : str.lowercased() )
    }
}

public extension Fuse {
    struct Pattern {
        let text: String
        var len: Int { text.count }
        var mask: Int { 1 << (text.count - 1) }
        let alphabet: [Character : Int]
        
        public init(text: String) {
            self.text = text
            self.alphabet = FuseUtilities.calculatePatternAlphabet(text)
        }
    }
}
