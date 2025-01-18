//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.button)
        }
        .modelContainer(for: Book.self)
    }
}
