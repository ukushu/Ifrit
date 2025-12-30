import Foundation

public class FuzzyFind {
    @available(*, deprecated, message: "Better do not use right now")
    public static func searchSync(_ text: String,
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    ) -> [Alignment] {
        return fuzzyFind(queries: [text], inputs: aList, match: match, mismatch: mismatch, gapPenalty: gapPenalty, boundaryBonus: boundaryBonus, camelCaseBonus: camelCaseBonus, firstCharBonusMultiplier: firstCharBonusMultiplier, consecutiveBonus: consecutiveBonus)
    }
    
    @available(*, deprecated, message: "Better do not use right now")
    public static func searchSync(_ searchQueries: [String],
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    ) -> [Alignment] {
        return fuzzyFind(queries: searchQueries, inputs: aList, match: match, mismatch: mismatch, gapPenalty: gapPenalty, boundaryBonus: boundaryBonus, camelCaseBonus: camelCaseBonus, firstCharBonusMultiplier: firstCharBonusMultiplier, consecutiveBonus: consecutiveBonus)
    }
    
    @available(*, deprecated, message: "Better do not use right now")
    public static func searchSync<T>(_ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>,
                                     match: Score = .defaultMatch,
                                     mismatch: Score = .defaultMismatch,
                                     gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                     boundaryBonus: Score = .defaultBoundary,
                                     camelCaseBonus: Score = .defaultCamelCase,
                                     firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                     consecutiveBonus: Score = Score.defaultConsecutiveBonus
    
    ) -> [Alignment] where T: Searchable {
        var result: [Alignment] = []
        
        for item in aList {
            let allValues = item[keyPath: keyPath].map { $0.value }
            
            if let tmp = fuzzyFind(queries: [text], inputs: allValues, match: match, mismatch: mismatch, gapPenalty: gapPenalty, boundaryBonus: boundaryBonus, camelCaseBonus: camelCaseBonus, firstCharBonusMultiplier: firstCharBonusMultiplier, consecutiveBonus: consecutiveBonus).first
            {
                result.append(tmp)
            }
        }
        
        return result.sorted { a1, a2 in a1.score > a2.score }
    }
}
