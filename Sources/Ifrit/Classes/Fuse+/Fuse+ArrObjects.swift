//  Created by UKS on 11.05.2024.

import Foundation

extension Fuse {
    /// Searches for a text pattern in an array of `Fuseable` objects.
    ///
    /// Each `FuseSearchable` object contains a `properties` accessor which returns `FuseProperty` array. Each `FuseProperty` is a tuple containing a `value` (the value of the property which should be included in the search), and a `weight` (how much "weight" to assign to the score)
    ///
    /// ## Example
    ///
    /// Ensure the object conforms to `Fuseable`:
    ///
    ///     struct Book: Fuseable {
    ///         let title: String
    ///         let author: String
    ///
    ///         var properties: [FuseProperty] {
    ///             return [
    ///                 FuseProperty(value: title, weight: 0.7),
    ///                 FuseProperty(value: author, weight: 0.3)
    ///             ]
    ///         }
    ///     }
    ///
    /// Searching is straightforward:
    ///
    ///     let books: [Book] = [
    ///         Book(title: "Old Man's War fiction", author: "John X"),
    ///         Book(title: "Right Ho Jeeves", author: "P.D. Mans")
    ///     ]
    ///
    ///     let fuse = Fuse()
    ///     let results = fuse.search("Man", in: books)
    ///
    /// - Parameters:
    ///   - text: The pattern string to search for
    ///   - aList: The list of `Fuseable` objects in which to search
    /// - Returns: A list of `CollectionResult` objects
    public func searchSync(_ text: String, in aList: [Fuseable]) -> [FusableSearchResult] {
        let pattern = self.createPattern(from: text)
        
        var collectionResult = [FusableSearchResult]()
        
        for (index, item) in aList.enumerated() {
            var scores = [Double]()
            var totalScore = 0.0
            
            var propertyResults = [(value: String, score: Double, ranges: [CountableClosedRange<Int>])]()
            
            item.properties.forEach { property in
                
                let value = property.value
                
                if let result = self.search(pattern, in: value) {
                    let weight = property.weight == 1 ? 1 : 1 - property.weight
                    let score = (result.score == 0 && weight == 1 ? 0.001 : result.score) * weight
                    totalScore += score
                    
                    scores.append(score)
                    
                    propertyResults.append((value: property.value, score: score, ranges: result.ranges))
                }
            }
            
            if scores.count == 0 {
                continue
            }
            
            collectionResult.append((
                index: index,
                score: totalScore / Double(scores.count),
                results: propertyResults
            ))
            
        }
        
        return collectionResult.sorted { $0.score < $1.score }
    }
    
    /// Asynchronously searches for a text pattern in an array of `Fuseable` objects.
    ///
    /// Each `FuseSearchable` object contains a `properties` accessor which returns `FuseProperty` array. Each `FuseProperty` is a tuple containing a `value` (the value of the property which should be included in the search), and a `weight` (how much "weight" to assign to the score)
    ///
    /// ## Example
    ///
    /// Ensure the object conforms to `Fuseable`:
    ///
    ///     struct Book: Fuseable {
    ///         let title: String
    ///         let author: String
    ///
    ///         var properties: [FuseProperty] {
    ///             return [
    ///                 FuseProperty(value: title, weight: 0.7),
    ///                 FuseProperty(value: author, weight: 0.3)
    ///             ]
    ///         }
    ///     }
    ///
    /// Searching is straightforward:
    ///
    ///     let books: [Book] = [
    ///         Book(title: "Old Man's War fiction", author: "John X"),
    ///         Book(title: "Right Ho Jeeves", author: "P.D. Mans")
    ///     ]
    ///
    ///     let fuse = Fuse()
    ///     fuse.search("Man", in: books, completion: { results in
    ///         print(results)
    ///     })
    ///
    /// - Parameters:
    ///   - text: The pattern string to search for
    ///   - aList: The list of `Fuseable` objects in which to search
    ///   - chunkSize: The size of a single chunk of the array. For example, if the array has `1000` items, it may be useful to split the work into 10 chunks of 100. This should ideally speed up the search logic. Defaults to `100`.
    ///   - completion: The handler which is executed upon completion
    public func search(_ text: String, in aList: [Fuseable], chunkSize: Int = 100, completion: @escaping ([FusableSearchResult]) -> Void) {
        let pattern = self.createPattern(from: text)
        
        let group = DispatchGroup()
        
        var collectionResult = [FusableSearchResult]()
        let resultLock = NSLock()
        
        aList.splitBy(chunkSize).enumerated()
            .forEach { (chunkIndex, chunk) in
                
                group.enter()
                
                self.searchQueue.async {
                    for (index, item) in chunk.enumerated() {
                        var scores = [Double]()
                        var totalScore = 0.0
                        
                        var propertyResults = [(value: String, score: Double, ranges: [CountableClosedRange<Int>])]()
                        
                        item.properties.forEach { property in
                            
                            let value = property.value
                            
                            if let result = self.search(pattern, in: value) {
                                let weight = property.weight == 1 ? 1 : 1 - property.weight
                                let score = result.score * weight
                                totalScore += score
                                
                                scores.append(score)
                                
                                propertyResults.append((value: property.value, score: score, ranges: result.ranges))
                            }
                        }
                        
                        if scores.count == 0 {
                            continue
                        }
                        
                        resultLock.lock()
                        collectionResult.append((
                            index: chunkIndex * chunkSize + index,
                            score: totalScore / Double(scores.count),
                            results: propertyResults
                        ))
                        resultLock.unlock()
                    }
                    
                    group.leave()
                }
            }
        
        group.notify(queue: self.searchQueue) {
            let sorted = collectionResult.sorted { $0.score < $1.score }
            DispatchQueue.main.async {
                completion(sorted)
            }
        }
    }
    
    /// Asynchronously searches for a text pattern in an array of `Fuseable` objects.
    ///
    /// Each `FuseSearchable` object contains a `properties` accessor which returns `FuseProperty` array. Each `FuseProperty` is a tuple containing a `value` (the value of the property which should be included in the search), and a `weight` (how much "weight" to assign to the score)
    ///
    /// ## Example
    ///
    /// Ensure the object conforms to `Fuseable`:
    ///
    ///     struct Book: Fuseable {
    ///         let title: String
    ///         let author: String
    ///
    ///         var properties: [FuseProperty] {
    ///             return [
    ///                 FuseProperty(value: title, weight: 0.7),
    ///                 FuseProperty(value: author, weight: 0.3)
    ///             ]
    ///         }
    ///     }
    ///
    /// Searching is straightforward:
    ///
    ///     let books: [Book] = [
    ///         Book(title: "Old Man's War fiction", author: "John X"),
    ///         Book(title: "Right Ho Jeeves", author: "P.D. Mans")
    ///     ]
    ///
    ///     let fuse = Fuse()
    ///     fuse.search("Man", in: books, completion: { results in
    ///         print(results)
    ///     })
    ///
    /// - Parameters:
    ///   - text: The pattern string to search for
    ///   - aList: The list of `Fuseable` objects in which to search
    ///   - chunkSize: The size of a single chunk of the array. For example, if the array has `1000` items, it may be useful to split the work into 10 chunks of 100. This should ideally speed up the search logic. Defaults to `100`.
    ///   - completion: The handler which is executed upon completion
    @available(iOS 13, *)
    public func search(_ text: String, in aList: [Fuseable], chunkSize: Int = 100) async -> [FusableSearchResult]  {
        await withCheckedContinuation { continuation in
            search(text, in: aList, chunkSize: 100) { results in
                continuation.resume(returning: results)
            }
        }
    }
}

/////////////////////////
///HELPERS
////////////////////////

extension Array {
    func splitBy(_ chunkSize: Int) -> [ArraySlice<Element>] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            self[$0..<Swift.min($0 + chunkSize, self.count)]
        }
    }
}
