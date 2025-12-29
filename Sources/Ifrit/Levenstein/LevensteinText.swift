import Foundation

internal class LevensteinText {
    public static func searchSync(_ text: String, in aList: [String]) -> [FuzzySrchResult] {
        let tmp = aList.indices
            .map { idx -> FuzzySrchResult in
                let score = aList[idx].levenshteinDistanceScore(to: text, trimWhiteSpacesAndNewLines: true)
                
                return FuzzySrchResult(Int(idx), 1 - score, [])
            }
        
        return tmp
            .sorted(by: { $0.diffScore < $1.diffScore } )
    }
    
    public static func searchSync<T>(_ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult] where T: Searchable
    {
        let tmp = aList.enumerated()
            .compactMap { (idx, item) -> FuzzySrchResult?  in
                let allValues = item[keyPath: keyPath].map{ $0.value }
                
                if let score = searchSync(text, in: allValues).first?.diffScore {
                    return FuzzySrchResult(Int(idx), score, [] )
                }
                
                return nil
            }
        
        return tmp.sorted(by: { $0.diffScore < $1.diffScore } )
    }
}
