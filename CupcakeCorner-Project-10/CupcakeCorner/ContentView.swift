//  Created by Deniz Gökay Hamzalı on 14.10.2024.

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct ContentView: View {
    var body: some View {
        Button("Enode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
        
    
}

#Preview {
    ContentView()
}
