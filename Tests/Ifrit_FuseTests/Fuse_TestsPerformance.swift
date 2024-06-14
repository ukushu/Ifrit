import Foundation
import XCTest
@testable import Ifrit

class Fuse_Performance: XCTestCase {
    /*
     M1 Proccessor
     Books: 50 000
     
     before refactoring:
     -------------
     Average: 7.014
     Time: [7.365528, 7.363086, 6.923763, 6.917535, 6.982419, 6.878643, 6.921786, 6.916958, 6.885111, 6.984302]
     */
    func testPerformanceSync() {
        let books = largeBookTitlesArray()
        let fuse = Fuse()
        
        self.measure {
            _ = fuse.searchSync("Th tinsg", in: books )
        }
    }
    
    /*
     M1 Proccessor
     Books: 50 000
     
     Average: 2.205
     Time: [2.299982, 2.319346, 2.162927, 2.153129, 2.177680, 2.166128, 2.182223, 2.237912, 2.209319, 2.144492]
     */
    func testPerformanceAsync() {
        let books = largeBookTitlesArray()
        let fuse = Fuse()
        
        self.measure {
            let expect = self.expectation(description: "searching")
            
            fuse.search("Th tinsg", in: books, completion: { results in
                expect.fulfill()
            })
            
            self.wait(for: [expect], timeout: 20000000)
        }
    }
}

