//  Created by Deniz Gökay Hamzalı on 18.10.2024.

import SwiftUI

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0 // Default vanilla.
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake.
        var cost = Decimal(quantity) * 2
        
        // Complicated cakes cost more.
        cost += Decimal(type) / 2
        
        // $1 for extra frosting.
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50 for sprinkles.
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
