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

internal extension String {
    func levenshteinDistanceScore(to string: String, ignoreCase: Bool = true, trimWhiteSpacesAndNewLines: Bool = true) -> Double {
        var firstString = self
        var secondString = string
        
        if ignoreCase {
            firstString = firstString.lowercased()
            secondString = secondString.lowercased()
        }
        if trimWhiteSpacesAndNewLines {
            firstString = firstString.trimmingCharacters(in: .whitespacesAndNewlines)
            secondString = secondString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        let empty = [Int](repeating:0, count: secondString.count)
        var last = [Int](0...secondString.count)
        
        for (i, tLett) in firstString.enumerated() {
            var cur = [i + 1] + empty
            for (j, sLett) in secondString.enumerated() {
                cur[j + 1] = tLett == sLett ? last[j] : Swift.min(last[j], last[j + 1], cur[j])+1
            }
            last = cur
        }
        
        // maximum string length between the two
        let lowestScore = max(firstString.count, secondString.count)
        
        if let validDistance = last.last {
            return  1 - (Double(validDistance) / Double(lowestScore))
        }
        
        return 0.0
    }
}
