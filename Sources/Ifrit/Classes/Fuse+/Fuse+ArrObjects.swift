//  Created by UKS on 11.05.2024, based on code of Kirollos Risk

import Foundation

extension Fuse {
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func searchSync<T>(_ text: String, in aList: [T], by propertyExtractor: @escaping (T) -> [FuseProp]) -> [FuzzySrchResult]  where T: Searchable {
        return self.searchSync(text, in: aList.lazy.map(propertyExtractor))
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func searchSync<T>(_ text: String, in aList: [T], by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult]  where T: Searchable {
        return self.searchSync(text, in: aList) { item in item[keyPath: keyPath] }
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    @Sendable
    public func search<T: Sendable>(_ text: String, in aList: [T],
                          by propertyExtractor: @escaping (T) -> [FuseProp],
                          chunkSize: Int = 100,
                          completion: @escaping @Sendable ([FuzzySrchResult]) -> Void) where T: Searchable
    {
        self.search(text, in: aList.lazy.map(propertyExtractor), chunkSize: chunkSize, completion: completion)
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    @Sendable
    public func search<T: Sendable>(_ text: String, in aList: [T],
                          by keyPath: KeyPath<T, [FuseProp]>,
                          chunkSize: Int = 100,
                          completion: @escaping @Sendable ([FuzzySrchResult]) -> Void) where T: Searchable
    {
        self.search(text, in: aList, by: {item in
            item[keyPath: keyPath]
        }, chunkSize: chunkSize, completion: completion)
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func search<T: Sendable>(_ text: String,
                       in aList: [T],
                       chunkSize: Int = 100,
                       by propertyExtractor: @escaping (T) -> [FuseProp]) async -> [FuzzySrchResult] where T: Searchable
    {
        await withCheckedContinuation { continuation in
            search(text, in: aList, by: propertyExtractor, chunkSize: 100) { results in
                continuation.resume(returning: results)
            }
        }
    }
    
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func search<T: Sendable>(_ text: String,
                       in aList: [T],
                       by keyPath: KeyPath<T, [FuseProp]>,
                       chunkSize: Int = 100) async -> [FuzzySrchResult] where T: Searchable
    {
        await withCheckedContinuation { continuation in
            search(text, in: aList, by: {item in item[keyPath: keyPath]}, chunkSize: 100) { results in
                continuation.resume(returning: results)
            }
        }
    }
}
