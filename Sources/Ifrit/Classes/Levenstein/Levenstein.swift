import Foundation

public enum LeventeinType {
    case bitap
    case text
}

public class Levenstein {
    public static func searchSync(type: LeventeinType = .bitap, _ text: String, in aList: [String]) -> [FuzzySrchResult] {
        switch type {
        case .bitap:
            LevensteinBitap.searchSync(text, in: aList)
        case .text:
            LevensteinText.searchSync(text, in: aList)
        }
    }
    
    public static func searchSync<T>(type: LeventeinType = .bitap,
                                     _ text: String,
                                     in aList: [T],
                                     by keyPath: KeyPath<T, [FuseProp]>) -> [FuzzySrchResult] where T: Searchable
    {
        switch type {
        case .bitap:
            LevensteinBitap.searchSync(text, in: aList, by: keyPath)
        case .text:
            LevensteinText.searchSync(text, in: aList, by: keyPath)
        }
    }
}
