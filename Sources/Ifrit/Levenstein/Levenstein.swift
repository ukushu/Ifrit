import Foundation

public enum LeventeinType {
    case bitap
    case text
}

public class Levenstein {
    public static func searchSync(type: LeventeinType = .text, _ text: String, in aList: [String]) -> [FuzzySrchResult] {
        switch type {
        case .bitap:
            LevensteinText.searchSync(text, in: aList)
        case .text:
            LevensteinBitap.searchSync(text, in: aList)
        }
    }
    
    public static func searchSync<T>(type: LeventeinType = .text,
                                     _ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult] where T: Searchable
    {
        switch type {
        case .bitap:
            LevensteinText.searchSync(text, in: aList, by: keyPath)
        case .text:
            LevensteinBitap.searchSync(text, in: aList, by: keyPath)
        }
    }
    
    public static func searchFuzzy(type: LeventeinType = .text,
                                   _ text: String,
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    ) -> [Alignment] {
        switch type {
        case .bitap:
            fatalError()
            // not implemented
            return fuzzyFind(queries: [text], inputs: aList)
        case .text:
            return fuzzyFind(queries: [text], inputs: aList)
        }
    }
    
    public static func searchFuzzy(type: LeventeinType = .text,
                                   _ searchQueries: [String],
                                   in aList: [String],
                                   match: Score = .defaultMatch,
                                   mismatch: Score = .defaultMismatch,
                                   gapPenalty: (Int) -> Score = Score.defaultGapPenalty,
                                   boundaryBonus: Score = .defaultBoundary,
                                   camelCaseBonus: Score = .defaultCamelCase,
                                   firstCharBonusMultiplier: Int = Score.defaultFirstCharBonusMultiplier,
                                   consecutiveBonus: Score = Score.defaultConsecutiveBonus
    
    ) -> [Alignment] {
        switch type {
        case .bitap:
            fatalError()
            // not implemented
            return fuzzyFind(queries: searchQueries, inputs: aList)
        case .text:
            return fuzzyFind(queries: searchQueries, inputs: aList)
        }
    }
}
