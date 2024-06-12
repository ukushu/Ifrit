
public protocol Searchable { }

public typealias FuzzySrchResult = (
    index: Int,
    score: Double,
    results: [(
        value: String,
        score: Double,
        ranges: [CountableClosedRange<Int>]
    )]
)

public typealias SrchDetails = (index: Int, score: Double, ranges: [CountableClosedRange<Int>])
