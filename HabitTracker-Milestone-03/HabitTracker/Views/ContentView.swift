//  Created by Deniz Gökay Hamzalı on 1.10.2024.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ActivityViewModel()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            ActivityListView(viewModel: viewModel)
                .toolbar {
                    Button(action: { showingAddActivity = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.orange)
                    }
                }
                .fullScreenCover(isPresented: $showingAddActivity) {
                    AddActivityView(viewModel: viewModel)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Habit Tracker")
                            .foregroundStyle(.yellow)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
