//  Created by UKS on 11.05.2024, based on code of Kirollos Risk

import Foundation

extension Fuse {
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func searchSync<T>(_ text: String, in aList: [T], by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult]  where T: Searchable {
        let pattern = self.createPattern(from: text)
        
        var collectionResult = [FuzzySrchResult]()
        
        for (index, item) in aList.enumerated() {
            var scores = [Double]()
            var totalScore = 0.0
            
            var propertyResults = [(value: String, diffScore: Double, ranges: [CountableClosedRange<Int>])]()
            
            item[keyPath: keyPath].forEach { property in
                
                let value = property.value
                
                if let result = self.search(pattern, in: value) {
                    let weight = property.weight == 1 ? 1 : 1 - property.weight
                    let score = (result.score == 0 && weight == 1 ? 0.001 : result.score) * weight
                    totalScore += score
                    
                    scores.append(score)
                    
                    propertyResults.append((value: property.value, diffScore: score, ranges: result.ranges))
                }
            }
            
            if scores.count == 0 {
                continue
            }
            
            collectionResult.append((
                index: index,
                diffScore: self.objSortStrategy == .averageScore ? totalScore / Double(scores.count) : scores.min() ?? 1 ,
                results: propertyResults
            ))
        }
        
        return collectionResult.sorted { $0.diffScore < $1.diffScore }
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    @Sendable
    public func search<T>(_ text: String, in aList: [T],
                          by keyPath: KeyPath<T, [FuseProp]>,
                          chunkSize: Int = 100,
                          completion: @escaping @Sendable ([FuzzySrchResult]) -> Void) where T: Searchable
    {
        let pattern = self.createPattern(from: text )
        
        let group = DispatchGroup()
        
        var collectionResult = [FuzzySrchResult]()
        let resultLock = NSLock()
        
        aList.splitBy(chunkSize).enumerated()
            .forEach { (chunkIndex, chunk) in
                
                group.enter()
                
                self.searchQueue.async {
                    for (index, item) in chunk.enumerated() {
                        var scores = [Double]()
                        var totalScore = 0.0
                        
                        var propertyResults = [(value: String, diffScore: Double, ranges: [CountableClosedRange<Int>])]()
                        
                        item[keyPath: keyPath].forEach { property in
                            let value = property.value
                            
                            if let result = self.search(pattern, in: value) {
                                let weight = property.weight == 1 ? 1 : 1 - property.weight
                                let score = result.score * weight
                                totalScore += score
                                
                                scores.append(score)
                                
                                propertyResults.append((value: property.value, diffScore: score, ranges: result.ranges))
                            }
                        }
                        
                        if scores.count == 0 {
                            continue
                        }
                        
                        resultLock.lock()
                        collectionResult.append((
                            index: chunkIndex * chunkSize + index,
                            diffScore: self.objSortStrategy == .averageScore ? totalScore / Double(scores.count) : scores.min() ?? 1,
                            results: propertyResults
                        ))
                        resultLock.unlock()
                    }
                    
                    group.leave()
                }
            }
        
        group.notify(queue: self.searchQueue) {
            let sorted = collectionResult.sorted { $0.diffScore < $1.diffScore }
            DispatchQueue.main.async {
                completion(sorted)
            }
        }
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func search<T>(_ text: String,
                       in aList: [T],
                       by keyPath: KeyPath<T, [FuseProp]>,
                       chunkSize: Int = 100) async -> [FuzzySrchResult] where T: Searchable
    {
        await withCheckedContinuation { continuation in
            search(text, in: aList, by: keyPath, chunkSize: 100) { results in
                continuation.resume(returning: results)
            }
        }
    }
}
