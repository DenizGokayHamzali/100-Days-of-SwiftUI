//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftUI
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
