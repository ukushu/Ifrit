import XCTest
@testable import Ifrit

class TestsBasic: XCTestCase {
    
    func testBasic() {
        let fuse = Fuse()
        
        var pattern = fuse.createPattern(from: "od mn war")
        var result = fuse.search(pattern, in: "Old Man's War")
        
        XCTAssert(result?.score == 0.44444444444444442, "Score is good")
        XCTAssert(result?.ranges.count == 3, "Found the correct number of ranges")
        
        pattern = fuse.createPattern(from: "uni manheim")
        result = fuse.search(pattern, in: "university manheim")
        XCTAssert(result?.ranges.count == 4, "Found the correct number of ranges")
        
        pattern = fuse.createPattern(from: "unimanheim")
        result = fuse.search(pattern, in: "university manheim")
        XCTAssert(result?.ranges.count == 4, "Found the correct number of ranges")
        
        pattern = fuse.createPattern(from: "xyz")
        result = fuse.search(pattern, in: "abc")
        XCTAssert(result == nil, "No result")
        
        pattern = fuse.createPattern(from: "")
        result = fuse.search(pattern, in: "abc")
        XCTAssert(result == nil, "No result")
    }
    
    func testSequence() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse()
        let results = fuse.search("Te silm", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 2, "The first result is the third book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testRange() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse()
        let results = fuse.search("silm", in: books)
        
        XCTAssert(results[0].ranges.count == 1, "There is a matching range in the first result")
        XCTAssert(results[0].ranges[0] == 4...7, "The range goes over the matched substring")
    }
    
    func testProtocolWeightedSearch1() {
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse()
        let results = fuse.search("man", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 0, "The first result is the first book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testProtocolWeightedSearch2() {
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse()
        let results = fuse.search("man", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 1, "The first result is the second book")
        XCTAssert(results[1].index == 0, "The second result is the first book")
    }
    
    func test_CorrectIdOfObject_ProperiesArraysSearch() {
        let animes: [Anime] = largeAnimeArray()
        
        let correctIdx = animes.firstIndex(where: { $0.ukrainian.contains("Тріган") })
        
        let fuse = Fuse()
        let results = fuse.search("тріган", in: animes)
        
        XCTAssertEqual(results.first!.index, correctIdx)
    }
}
