//  Created by Deniz Gökay Hamzalı on 15.11.2024.

import SwiftData
import SwiftUI

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
