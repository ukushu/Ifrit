
public struct FuseProp {
    let value: String
    let weight: Double
    
    public init (_ value: String, weight: Double = 1.0) {
        self.value = value
        
        self.weight = weight
    }
}

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
