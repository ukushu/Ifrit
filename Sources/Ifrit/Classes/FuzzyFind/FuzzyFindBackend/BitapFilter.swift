import Foundation

public struct BitapFilter {
    @inline(__always)
    private static func patternLengthIsValid(_ m: Int) -> Bool {
        m > 0 && m < MemoryLayout<UInt>.size * 8
    }
    
    public static func matches(
        pattern: String,
        text: String,
        maxDistance k: Int
    ) -> Bool {
        let m = pattern.count
        guard patternLengthIsValid(m) else { return false }
        
        let k = min(k, m)
        
        var masks: [Character: UInt] = [:]
        for (i, c) in pattern.enumerated() {
            let bit = UInt(1) << i
            masks[c] = (masks[c] ?? ~0) & ~bit
        }
        
        let allOnes: UInt = ~0
        var r = (0...k).map { allOnes << $0 }
        
        for c in text {
            let mask = masks[c] ?? ~0
            
            var prev = r[0]
            r[0] = (r[0] | mask) << 1
            
            if k > 0 {
                for d in 1...k {
                    let tmp = r[d]
                    let sub = (r[d] | mask) << 1
                    let ins = prev
                    let del = r[d - 1] << 1
                    let rep = prev << 1
                    r[d] = sub & ins & del & rep
                    prev = tmp
                }
            }
            
            if (r[0...k].contains { ($0 & (UInt(1) << m)) == 0 }) {
                return true
            }
        }
        
        return false
    }
}
