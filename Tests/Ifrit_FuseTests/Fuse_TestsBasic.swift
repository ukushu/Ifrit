import XCTest
@testable import Ifrit

class Fuse_TestsBasic: XCTestCase {
    
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
        let results = fuse.searchSync("Te silm", in: books)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 2, "The first result is the third book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testRange() {
        let books = ["The Lock Artist", "The Lost Symbol", "The Silmarillion", "xyz", "fga"]
        
        let fuse = Fuse()
        let results = fuse.searchSync("silm", in: books)
        
        XCTAssert(results[0].ranges.count == 1, "There is a matching range in the first result")
        XCTAssert(results[0].ranges[0] == 4...7, "The range goes over the matched substring")
    }
    
    func testProtocolWeightedSearch1() {
        struct Book: Searchable {
            let author: String
            let title: String
            
            var properties: [FuseProp] {
                return [
                    FuseProp(author, weight: 0.3),
                    FuseProp(title, weight: 0.7)
                ]
            }
        }
        
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse()
        let results = fuse.searchSync("man", in: books, by: \Book.properties)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 0, "The first result is the first book")
        XCTAssert(results[1].index == 1, "The second result is the second book")
    }
    
    func testProtocolWeightedSearch2() {
        struct Book: Searchable {
            let author: String
            let title: String
            
            var properties: [FuseProp] {
                return [
                    FuseProp(author, weight: 0.7),
                    FuseProp(title, weight: 0.3)
                ]
            }
        }
        
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse()
        let results = fuse.searchSync("man", in: books, by: \Book.properties)
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 1, "The first result is the second book")
        XCTAssert(results[1].index == 0, "The second result is the first book")
    }
    
    func testProtocolWeightedSearch3() {
        struct Book: Searchable {
            let author: String
            let title: String
        }
        
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        
        let fuse = Fuse()
        let results = fuse.searchSync("man", in: books) {book in
            return [
                FuseProp(book.author, weight: 0.7),
                FuseProp(book.title, weight: 0.3)
            ]
        }
        
        XCTAssert(results.count > 0, "There are results")
        XCTAssert(results[0].index == 1, "The first result is the second book")
        XCTAssert(results[1].index == 0, "The second result is the first book")
    }
    
    func test_CorrectIdOfObject_ProperiesArraysSearchSync() {
        let animes: [Anime] = largeAnimeArray()
        
        let correctIdx = animes.firstIndex(where: { $0.ukrainian.contains("Тріган") })
        
        let fuse = Fuse()
        let results = fuse.searchSync("тріган", in: animes, by: \Anime.properties)
        
        XCTAssertEqual(results.first!.index, correctIdx)
    }
    
    func test_CorrectIdOfObject_ProperiesArraysSearchAsync() async {
        let animes: [Anime] = largeAnimeArray()
        
        let correctIdx = animes.firstIndex(where: { $0.ukrainian.contains("Тріган") })
        
        let fuse = Fuse()
        let results = await fuse.search("тріган", in: animes, by: \Anime.properties)
        
        XCTAssertEqual(results.first!.index, correctIdx)
    }
    
    func test_CorrectIdOfString_SearchSync() {
        let books = largeBookTitlesArray(len: 1000)
        let bookName = "House of Leaves"
        
        let correctIdx = books.firstIndex(where: { $0 == bookName } )
        
        let fuse = Fuse()
        let results = fuse.searchSync(bookName, in: books)
        
        XCTAssertEqual(results.first!.index, correctIdx)
    }
    
    func test_CorrectIdOfString_SearchAsync() async {
        let books = largeBookTitlesArray(len: 1000)
        let bookName = "The Adventures and Misadventures of Magroll"
        
        let correctIdx = books.firstIndex(where: { $0 == bookName } )
        
        let fuse = Fuse()
        let results = await fuse.search(bookName, in: books)
        
        XCTAssertEqual(results.first!.index, correctIdx)
    }
    
    func test_SyncAndAsyncWorksTheSameWay() async {
        let books = largeBookTitlesArray(len: 1000)
        let bookName = "The Adventures and Misadventures of Magroll"
        
        let fuse = Fuse()
        
        let results1 = fuse.searchSync(bookName, in: books)
        let results2 = await fuse.search(bookName, in: books)
        
        results1.indices.forEach{ idx in
            XCTAssertEqual(results1[idx].index, results2[idx].index)
            XCTAssertEqual(results1[idx].ranges, results2[idx].ranges)
            XCTAssertEqual(results1[idx].diffScore, results2[idx].diffScore)
        }
    }
}
