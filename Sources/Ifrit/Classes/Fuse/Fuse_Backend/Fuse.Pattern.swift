
public extension Fuse {
    struct Pattern : Sendable {
        let text: String
        var len: Int { text.count }
        var mask: Int { 1 << (text.count - 1) }
        let alphabet: [Character : Int]
        
        public init(text: String) {
            self.text = text
            self.alphabet = calculatePatternAlphabet(text)
        }
    }
}

/// Initializes the alphabet for the Bitap algorithm
///
/// - Parameter pattern: The text to encode.
/// - Returns: Hash of character locations.
fileprivate func calculatePatternAlphabet(_ pattern: String) -> [Character: Int] {
    let len = pattern.count
    var mask = [Character: Int]()
    for (i, c) in pattern.enumerated() {
        mask[c] =  (mask[c] ?? 0) | (1 << (len - i - 1))
    }
    return mask
}
