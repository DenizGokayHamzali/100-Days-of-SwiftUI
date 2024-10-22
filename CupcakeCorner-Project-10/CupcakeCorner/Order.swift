//  Created by Deniz Gökay Hamzalı on 18.10.2024.

import SwiftUI

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
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
        let fields = [name, streetAddress, city, zip]
        return !fields.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.contains { $0.isEmpty }
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
    
    init() {
        loadOrderAddress()
    }
    
    func saveOrderAddress() {
        if let encodedAddress = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encodedAddress, forKey: "orderAddress")
        }
    }
    
    private func loadOrderAddress() {
        if let savedAddress = UserDefaults.standard.data(forKey: "orderAddress"),
           let decodedAddress = try? JSONDecoder().decode(Order.self, from: savedAddress) {
            self.name = decodedAddress.name
            self.streetAddress = decodedAddress.streetAddress
            self.city = decodedAddress.city
            self.zip = decodedAddress.zip
        }
    }
}
