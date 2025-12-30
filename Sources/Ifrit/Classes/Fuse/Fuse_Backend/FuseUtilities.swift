//  Created by Kirollos Risk on 5/2/17

internal class FuseUtilities {
    /// Computes the score for a match with `e` errors and `x` location.
    ///
    /// - Parameter pattern: Pattern being sought.
    /// - Parameter errorsInMatch
    /// - Parameter matchLocation
    /// - Parameter expectedMatchLocation
    /// - Parameter scoreTextLength: Coerced version of text's length. ?????
    /// - Returns: Overall score for match (0.0 = good, 1.0 = bad).
    static func calculateScore(_ pattern: String, errorsInMatch e: Int, matchLocation x: Int, expectedMatchLocation loc: Int, distance: Int) -> Double {
        let len = pattern.count
        let accuracy = Double(e) / Double(len)
        let proximity = abs(x - loc)
        if (distance == 0) {
            return Double(proximity != 0 ? 1 : accuracy)
        }
        return Double(accuracy) + (Double(proximity) / Double(distance))
    }
    
    /// Computes the score for a match with `e` errors and `x` location.
    ///
    /// - Parameter patternLength: Length of pattern being sought.
    /// - Parameter errorsInMatch: --
    /// - Parameter matchLocation:
    /// - Parameter expectedMatchLocation:
    /// - Parameter scoreTextLength: Coerced version of text's length. ??????
    /// - Returns: Overall score for match (0.0 = good, 1.0 = bad).
    static func calculateScore(_ patternLength: Int, errorsInMatch e: Int, matchLocation x: Int, expectedMatchLocation loc: Int, distance: Int) -> Double {
        let accuracy = Double(e) / Double(patternLength)
        let proximity = abs(x - loc)
        if (distance == 0) {
            return Double(proximity != 0 ? 1 : accuracy)
        }
        return Double(accuracy) + (Double(proximity) / Double(distance))
    }
}
