//  Created by UKS on 11.05.2024, based on code of Kirollos Risk

import Foundation

extension Fuse {
    ///
    /// instructions how to use: https://github.com/ukushu/Ifrit/blob/main/Docs/FuseInstructions.md
    ///
    public func searchSync<T>(_ text: String, in aList: [T], by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult]  where T: Searchable {
        return self.searchSync(text, in: aList.lazy.map({item in
            item[keyPath: keyPath]
        }))
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
        let fuseProps = aList.lazy.map({item in
            item[keyPath: keyPath]
        })
        self.search(text, in: fuseProps, chunkSize: chunkSize, completion: completion)
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
            search(text, in: aList, by: keyPath, chunkSize: 100) { results in
                continuation.resume(returning: results)
            }
        }
    }
}
