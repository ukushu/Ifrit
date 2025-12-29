import Foundation
import XCTest
@testable import Ifrit

final class IfritDoxCode_Leve_Test: XCTestCase {
    
    //#### Levenstain search in `[String]`
    func test_1() throws {
        let animes = ["Gekijouban Fairy Tail: Houou no Miko",
                    "Fairy Tail the Movie: The Phoenix Priestess",
                    "Priestess of the Phoenix",
                    "Fairy Tail: The Phoenix Priestess"]
        
        let animesSearch = Levenstein.searchSync("Fairy Tail: The Phoenix Priestess", in: animes)
        
        // --------------------
        // ASYNC: async/await
        // DOES NOT SUPPORTED
        
        // --------------------
        // ASYNC: callbacks
        // DOES NOT SUPPORTED
    }
    
    //#### Levenstain search in `[Fuseable]` objects
    func test_2() throws {
        let animes = getAnimeList(count: 10) // Fusable objects
        
        let result = Levenstein.searchSync("Fairy Tail the Movie: The Phoenix Priestess", in: animes, by: \AnimeListInfo.properties )
        
        // --------------------
        // ASYNC: async/await
        // DOES NOT SUPPORTED
        
        // --------------------
        // ASYNC: callbacks
        // DOES NOT SUPPORTED
    }
}
