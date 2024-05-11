import Foundation
import XCTest
@testable import Ifrit

class TestsPerformance: XCTestCase {
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
     
     Average: 2.421
     Time: [2.343995, 2.533559, 2.353903, 2.428667, 2.323356, 2.517610, 2.336135, 2.523576, 2.287798, 2.564045]
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

