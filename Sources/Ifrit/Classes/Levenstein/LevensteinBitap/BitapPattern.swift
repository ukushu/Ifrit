
import Foundation

public struct Match: Equatable {
    public let distance: Int
    public let end: Int
}

public enum StaticMaxDistance: Int {
    case one = 1
    case two = 2
}

public struct BitapPattern {
    let length: Int
    let masks : [Character: UInt]
    
    public init?(pattern: String) {
        var length = 0
        var masks: [Character: UInt] = [:]
        
        for (i, c) in pattern.enumerated() {
            length += 1
            let bit: UInt = 1 << i
            masks[c] = masks[c].map { $0 & ~bit } ?? ~bit
        }
        
        guard patternLengthIsValid(length) else {
            return nil // ERR_INVALID_PATTERN
        }
        
        self.length = length
        self.masks = masks
    }
    
    private func maskIterator(text: String) -> AnyIterator<UInt> {
        var chars = text.makeIterator()
        return AnyIterator {
            guard let c = chars.next() else { return nil }
            return self.masks[c] ?? ~0
        }
    }
    
    //Levenstein (fuzzy search)
    public func lev(text: String, maxDistance: Int) -> AnyIterator<Match> {
        switch Ifrit.levensteinBitap(maskIter: maskIterator(text: text), patternLength: self.length, maxDistance: maxDistance) {
        case .success(let iter): return iter
        case .failure: return AnyIterator { nil }
        }
    }
    
    // Optimal String Alignment
    public func optStrAlignment(text: String, maxDistance: Int) -> AnyIterator<Match> {
        switch Ifrit.optStrAlignment(maskIter: maskIterator(text: text), patternLength: self.length, maxDistance: maxDistance) {
            case .success(let iter): return iter
            case .failure: return AnyIterator { nil }
        }
    }
}

//
// Errors
//

enum BitapError: Error {
    case invalidPatternLength
}

//
// Helpers
//

private let maxPatternLength = MemoryLayout<UInt>.size * 8

@inline(__always)
private func patternLengthIsValid(_ patternLength: Int) -> Bool {
    patternLength > 0 && patternLength < maxPatternLength
}

private func findBitap<I: IteratorProtocol>(maskIter: I, patternLength: Int) -> Result<AnyIterator<Int>, Error> where I.Element == UInt {
    guard patternLengthIsValid(patternLength) else {
        return .failure(BitapError.invalidPatternLength)
    }
    
    var r: UInt = ~1
    let offset = patternLength - 1
    var iterator = maskIter
    let resultIterator = AnyIterator<Int> {
        while let mask = iterator.next() {
            r |= mask
            r <<= 1
            if r & (1 << patternLength) == 0 {
                return iterator.next().map { _ in 0 } ?? 0 - offset
            }
        }
        
        return nil
    }
    
//    var index = 0
//    let resultIterator = AnyIterator<Int> {
//        while let mask = iterator.next() {
//            r |= mask
//            r <<= 1
//            if r & (1 << patternLength) == 0 {
//                let matchIndex = index - offset
//                index += 1
//                return matchIndex
//            }
//            index += 1
//        }
//        return nil
//    }
    
    return .success(resultIterator)
}

private func levensteinBitap<I: IteratorProtocol>(maskIter: I, patternLength: Int, maxDistance: Int )
    -> Result<AnyIterator<Match>, Error> where I.Element == UInt
{
    guard patternLengthIsValid(patternLength) else {
        return .failure(BitapError.invalidPatternLength)
    }
    
    let max_distance = min(maxDistance, patternLength, maxPatternLength)
    let allOnes: UInt = UInt.max
    var r = (0...max_distance).map { allOnes & ~(1 << $0) }
    var iterator = maskIter
    
    
    
    
    let resultIterator = AnyIterator<Match> {
        while let mask = iterator.next() {
            var prev_parent = r[0]
            r[0] |= mask
            r[0] <<= 1
            for j in 1..<r.count {
                let prev = r[j]
                let current = (prev | mask) << 1
                let replace = prev_parent << 1
                let delete = r[j - 1] << 1
                let insert = prev_parent
                r[j] = current & insert & delete & replace
                prev_parent = prev
            }
            for (k, rv) in r.enumerated() {
                if rv & (1 << patternLength) == 0 {
                    return Match(distance: k, end: 0) // `end` потребує адаптації
                }
            }
        }
        return nil
    }
    
    return .success(resultIterator)
}

//Функція optimal_string_alignment (скорочено osa) реалізує Bitap‑пошук з обмеженою відстанню редагування, який враховує оптимальне вирівнювання рядків.
private func optStrAlignment<I: IteratorProtocol>(
    maskIter: I,
    patternLength: Int,
    maxDistance: Int
) -> Result<AnyIterator<Match>, Error> where I.Element == UInt {
    guard patternLengthIsValid(patternLength) else {
        return .failure(BitapError.invalidPatternLength)
    }
    
    let max_distance = min(maxDistance, patternLength)
    
    let allOnes: UInt = ~UInt(0)
    var r = (0...max_distance).map { allOnes << $0 }
    var t = Array(repeating: allOnes, count: max_distance)
    
    var iterator = maskIter
    
    let resultIterator = AnyIterator<Match> {
        while let mask = iterator.next() {
            var prev_parent = r[0]
            r[0] |= mask
            r[0] <<= 1
            for j in 1..<r.count {
                let prev = r[j]
                let current = (prev | mask) << 1
                let replace = prev_parent << 1
                let delete = r[j - 1] << 1
                let insert = prev_parent
                let transpose = (t[j - 1] | (mask << 1)) << 1
                r[j] = current & insert & delete & replace & transpose
                t[j - 1] = (prev_parent << 1) | mask
                prev_parent = prev
            }
            
            for (k, rv) in r.enumerated() {
                if rv & (1 << patternLength) == 0 {
                    return Match(distance: k, end: 0)
                }
            }
        }
        
        return nil
    }
    
    return .success(resultIterator)
}
