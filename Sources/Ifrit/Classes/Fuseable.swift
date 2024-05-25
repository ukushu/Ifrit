//  Created by Kirollos Risk on 5/2/17

public protocol Fuseable {
    var properties: [FuseProp] { get }
}

public typealias FusableSearchResult = (
    index: Int,
    score: Double,
    results: [(
        value: String,
        score: Double,
        ranges: [CountableClosedRange<Int>]
    )]
)
