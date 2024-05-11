import Foundation
import XCTest
@testable import Ifrit

class TestsPerformance: XCTestCase {
    /*
     M1 Proccessor
     Books: 5 000
     
     before refactoring:
     -------------
     Average: 67.308
     Time: [67.289654, 67.271994, 67.278241, 67.267225, 67.274823, 67.448021, 67.287590, 67.275537, 67.409870, 67.275029]
     */
    func testPerformanceSync() {
        let books = largeBooksArray()
        let fuse = Fuse()
        
        self.measure {
            _ = fuse.search("Th tinsg", in: books )
        }
    }
    
    /*
     M1 Proccessor
     Books: 5 000
     
     Average: 33.330
     Time: [33.203095, 34.274954, 33.228916, 33.556440, 33.284599, 33.358834, 33.404846, 33.336103, 32.846291, 32.806024]
     */
    func testPerformanceAsync() {
        let books = largeBooksArray()
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

