
public protocol Searchable { }

public typealias FuzzySrchResult = (
    index: Int,
    diffScore: Double,
    results: [(
        value: String,
        diffScore: Double,
        ranges: [CountableClosedRange<Int>]
    )]
)

public typealias SrchDetails = (index: Int, diffScore: Double, ranges: [CountableClosedRange<Int>])
