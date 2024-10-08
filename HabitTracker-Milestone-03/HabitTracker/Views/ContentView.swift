//  Created by Deniz Gökay Hamzalı on 1.10.2024.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ActivityViewModel()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List(viewModel.activities) { activity in
                VStack(alignment: .leading) {
                    Text(activity.title)
                        .font(.headline)
                    Text("Completed \(activity.completionCount) times")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button(action: { showingAddActivity = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(viewModel: viewModel)
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}


#Preview {
    ContentView()
}
