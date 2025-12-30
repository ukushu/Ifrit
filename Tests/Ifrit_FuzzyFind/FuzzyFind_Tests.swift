
import Foundation
import XCTest
@testable import Ifrit


/////////////////////////
///Functional tests
/////////////////////////
final class FuzzyFind_Tests: XCTestCase {
    func test_BasicSearch2() throws {
        try basicSearch2()
    }
}


/////////////////////////
///Performance tests
/////////////////////////
extension FuzzyFind_Tests {
    func test_BasicSearchPerformance() throws {
        var animes = ["Gekijouban Fairy Tail: Houou no Miko",
                      "Fairy Tail the Movie: The Phoenix Priestess",
                      "Priestess of the Phoenix",
                      "Fairy Tail: The Phoenix Priestess"]
        
        animes.append(contentsOf: stride(from: 4, to: 10_000, by: 1).map{ _ in UUID().uuidString }  )
        
        self.measure {
            let _ = FuzzyFind.searchSync("Fairy Tail the Movie: The Phoenix Priestess", in: animes)
        }
        
        // M1 PC results:
        // Search in 10_000 strings array
        // Average time: 2.243 seconds
    }
    
}


private func basicSearch2() throws {
    let animes = ["Gekijouban Fairy Tail: Houou no Miko",
                  "Fairy Tail the Movie: The Phoenix Priestess",
                  "Priestess of the Phoenix",
                  "Fairy Tail: The Phoenix Priestess"]
    
    let animesSearch = FuzzyFind.searchSync("Fairy Tail: The Phoenix Priestess", in: animes )
    XCTAssertEqual(animesSearch[0].asString, "Fairy Tail: The Phoenix Priestess")
}
