//  Created by Deniz Gökay Hamzalı on 1.10.2024.

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ActivityViewModel()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.activities) { activity in
                NavigationLink(value: activity) {
                    VStack(alignment: .leading) {
                        Text(activity.title)
                            .font(.headline)
                        Text("Completed \(activity.completionCount) times")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
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
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
