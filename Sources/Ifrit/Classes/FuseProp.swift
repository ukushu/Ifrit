//  Created by Kirollos Risk on 5/2/17

import Foundation

public struct FuseProp {
    public let value: String
    public let weight: Double
    
    public init (_ value: String, weight: Double = 1.0) {
        self.value = value
        
        self.weight = weight
    }
}
