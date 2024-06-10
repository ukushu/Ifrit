import Foundation
import XCTest
@testable import Ifrit

final class IfritDoxCode_Fuse_Test: XCTestCase {
    
    //#### Searching in a `String` using `Fuse`
    func test_1() throws {
        let fuse = Fuse()
        
        // SYNC search
        let result = fuse.searchSync("od mn war", in: "Old Man's War")
        
        print(result!.score)  // 0.44444444444444442 // LOWEST SCORE = BETTER
        print(result!.ranges) // [CountableClosedRange(0...0), CountableClosedRange(2...6), CountableClosedRange(9...12)]
        
        // --------------------
        // ASYNC search - async/await
        
        // --------------------
        // ASYNC search - callbacks
    }
    
    // #### Search in `[String]`
    func test_2() async throws {
        let books = ["The Silmarillion", "The Lock Artist", "The Lost Symbol"]
        let fuse = Fuse()
        
        // SYNC search
        let results1 = fuse.searchSync("Te silm", in: books)
        
        results1.forEach { item in
            print("""
                index: \(item.index)
                score: \(item.score)
                ranges: \(item.ranges)
                ---------------
                """
            )
        }
        
        // --------------------
        // ASYNC search - async/await
        let results2 = fuse.searchSync("Te silm", in: books)
        
        results2.forEach { item in
            print("""
                index: \(item.index)
                score: \(item.score)
                ranges: \(item.ranges)
                ---------------
                """
            )
        }
        
        // --------------------
        // ASYNC search - callbacks
        fuse.search("Te silm", in: books, completion: { results in
            results.forEach { item in
                print("""
                    index: \(item.index)
                    score: \(item.score)
                    ranges: \(item.ranges)
                    ---------------
                    """
                )
            }
        })
    }
    
    //#### Search in `[Searchable]` objects - how to use `FuseProp`
    func test_3() async throws {
        //no need
    }
    
    // #### Search in `[Searchable]` objects
    func test_4() async throws {
        struct Book: Searchable {
            let author: String
            let title: String
            
            var properties: [FuseProp] { [title, author].map{ FuseProp($0) } }
        }
        
        let books: [Book] = [
            Book(author: "John X", title: "Old Man's War fiction"),
            Book(author: "P.D. Mans", title: "Right Ho Jeeves")
        ]
        let fuse = Fuse()
        
        // --------------------
        // SYNC version
        let resultsSync = fuse.searchSync("man", in: books, by: \Book.properties)
        
        resultsSync.forEach { item in
            print("index: \(item.index); score: \(item.score)")
        }
        
        // --------------------
        // ASYNC: async/await
        let resultsAsync = await fuse.search("Man", in: books, by: \Book.properties)
        
        resultsAsync.forEach { item in
            print("index: \(item.index); score: \(item.score)")
        }
        
        // ASYNC: callbacks
        fuse.search("Man", in: books, by: \Book.properties, completion: { results in
            results.forEach { item in
                print("index: \(item.index); score: \(item.score)")
            }
        })
    }
}
