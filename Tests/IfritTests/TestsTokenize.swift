import Foundation
import XCTest
@testable import Ifrit

class TestsTokenize: XCTestCase {
    func testBasicTokenized() {
        let fuse = Fuse(tokenize: true)
        
        var pattern = fuse.createPattern(from: "od mn war")
        var result = fuse.search(pattern, in: "Old Man's War")
        
        XCTAssert(result?.score == 0.39611111111111114, "Score is good \(String(describing: result?.score))")
        XCTAssert(result?.ranges.count == 8, "Found the correct number of ranges \(String(describing: result?.ranges))")
        
        pattern = fuse.createPattern(from: "uni manheim")
        result = fuse.search(pattern, in: "university manheim")
        XCTAssert(result?.ranges.count == 6, "Found the correct number of ranges \(String(describing: result?.ranges.count))")
        
        pattern = fuse.createPattern(from: "unimanheim")
        result = fuse.search(pattern, in: "university manheim")
        XCTAssert(result?.ranges.count == 4, "Found the correct number of ranges \(String(describing: result?.ranges.count))")
        
        pattern = fuse.createPattern(from: "tuv xyz")
        result = fuse.search(pattern, in: "abc")
        XCTAssert(result == nil, "No result")
        
        pattern = fuse.createPattern(from: "")
        result = fuse.search(pattern, in: "abc")
        XCTAssert(result == nil, "No result")
    }
    
    func testSequenceTokenized() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse(tokenize: true)
        let results = fuse.searchSync("Te silm", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 2, "The first result is the third book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testSequenceTokenized2() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse(tokenize: true)
        let results = fuse.searchSync("The Loc", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 0, "The first result is the first book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testRangeTokenized() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse(tokenize: true)
        let results = fuse.searchSync("silm", in: books)
        
        XCTAssert(results[0].ranges.count == 1, "There is a matching range in the first result")
        XCTAssert(results[0].ranges[0] == 4...7, "The range goes over the matched substring")
    }
    
    func testProtocolWeightedSearchTokenized() {
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse(tokenize: true)
        let results = fuse.searchSync("man right", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 0, "The first result is the first book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testProtocolWeightedSearchTokenized2() {
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "John X", title: "Man's Old War fiction")
        ]
        
        let fuse = Fuse(tokenize: true)
        let results = fuse.searchSync("john man", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 0, "The first result is the first book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
}
