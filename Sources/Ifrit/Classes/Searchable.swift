//  Created by Kirollos Risk on 5/2/17

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
