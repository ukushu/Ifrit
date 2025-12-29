import Foundation

internal class LevensteinBitap {
    public static func searchSync(_ text: String, in aList: [String]) -> [FuzzySrchResult] {
        var results: [FuzzySrchResult] = []
        
        for (idx, item) in aList.enumerated() {
            guard let pattern = Pattern(pattern: text) else { continue }
            let matchesIter = pattern.lev(text: item, maxDistance: 1)
            let minDistance = matchesIter.min(by: { $0.distance < $1.distance })?.distance ?? text.count
            
            let score = Double(minDistance) / Double(pattern.length)
            
            results.append(FuzzySrchResult(index: idx, diffScore: score, results: []))
        }
        
        return results.sorted(by: { $0.diffScore < $1.diffScore })
    }
    
    public static func searchSync<T>(_ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult] where T: Searchable
    {
        var results: [FuzzySrchResult] = []
        
        for (idx, item) in aList.enumerated() {
            let allValues = item[keyPath: keyPath].map { $0.value }
            
            if let bestScore = searchSync(text, in: allValues).first?.diffScore {
                results.append(FuzzySrchResult(index: idx, diffScore: bestScore, results: []))
            }
        }
        
        return results.sorted(by: { $0.diffScore < $1.diffScore })
    }
    
    public static func searchFuzzy(_ text: String,
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    ) -> [Alignment] {
        fatalError()
        // not implemented yet
        
//        return fuzzyFind(queries: [text], inputs: aList)
    }
    
    public static func searchFuzzy(_ searchQueries: [String],
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    
    ) -> [Alignment] {
        fatalError()
        // not implemented yet
        
//        return fuzzyFind(queries: searchQueries, inputs: aList)
    }
}
