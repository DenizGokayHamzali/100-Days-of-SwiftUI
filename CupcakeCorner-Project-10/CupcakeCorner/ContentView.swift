//  Created by Deniz Gökay Hamzalı on 14.10.2024.

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var collectionPrice: Double
    var currency: String
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                Text("Loading...")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            } else {
                List(results, id: \.trackId) { item in
                    VStack(alignment: .leading) {
                        Text(item.trackName)
                            .font(.headline)
                        
                        Text(item.collectionName)
                        Text("\(String(item.collectionPrice)) \(item.currency)")
                    }
                }
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
            
        } catch {
            print("Invalid Data")
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
}
