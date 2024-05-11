import Foundation
import XCTest
@testable import Ifrit

class TestsPerformance: XCTestCase {
    /*
     M1 Proccessor
     Books: 5 000
     
     before refactoring:
     -------------
     Average: 67.023
     Time: [66.998230, 66.862965, 67.164492, 67.061019, 66.998137, 66.947722, 66.947760, 66.848101, 67.513363, 66.885495]
     
     after refactoring:
     -------------
     Average: 67,8013341
     Time: [67.860731, 67.261889, 67.159099, 67.711385, 68.303412, 69.108976, 67.577191, 67.525643, 67.214533, 68.290482]
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
     
     before refactoring:
     -------------
     Average: 33.805
     Time: [33.537225, 33.654939, 33.614897, 33.689968, 33.919938, 33.810688, 33.673248, 34.243528, 33.882224, 34.019087]
     
     after refactoring:
     -------------
     Average: 33.708
     Time: [33.399128, 33.531374, 33.420980, 33.989494, 33.376214, 33.323151, 33.395309, 33.557535, 33.587336, 35.497800]
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

fileprivate func largeBooksArray(len: Int = 5_000) -> [String] {
    var tmp = booksArray
    
    while tmp.count < len {
        tmp.append(contentsOf: booksArray)
    }
    
    return Array( tmp.dropLast(tmp.count - len) )
}
