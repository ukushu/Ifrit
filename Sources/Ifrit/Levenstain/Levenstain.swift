import Foundation

public class Levenstain {
    public static func searchSync(_ text: String, in aList: [String]) -> [SrchDetails] {
        let tmp = aList.indices
            .map { idx -> SrchDetails in
                let score = aList[idx].levenshteinDistanceScore(to: text, trimWhiteSpacesAndNewLines: true)
                
                return SrchDetails(Int(idx), 1 - score, [])
            }
        
        return tmp
            .sorted(by: { $0.score < $1.score } )
    }
    
    public static func searchSync<T>(_ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>) -> [SrchDetails] where T: Searchable
    {
        let tmp = aList.enumerated()
            .compactMap { (idx, item) -> SrchDetails?  in
                let allValues = item[keyPath: keyPath].map{ $0.value }
                
                if let score = searchSync(text, in: allValues).first?.score {
                    return SrchDetails(Int(idx), score, [] )
                }
                
                return nil
            }
        
        return tmp.sorted(by: { $0.score < $1.score } )
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
        return fuzzyFind(queries: [text], inputs: aList)
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
        return fuzzyFind(queries: searchQueries, inputs: aList)
    }
}
