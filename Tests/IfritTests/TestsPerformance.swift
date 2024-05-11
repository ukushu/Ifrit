@testable import Ifrit

extension Tests {
    func testPerformanceSync() {
        let fuse = Fuse()
        
        self.measure {
            _ = fuse.search("Th tinsg", in: booksArray)
        }
    }
    
    func testPerformanceAsync() {
        let fuse = Fuse()
        
        self.measure {
            let expect = self.expectation(description: "searching")
            
            fuse.search("Th tinsg", in: booksArray, completion: { results in
                expect.fulfill()
            })
            
            self.wait(for: [expect], timeout: 20000000)
        }
    }
}
