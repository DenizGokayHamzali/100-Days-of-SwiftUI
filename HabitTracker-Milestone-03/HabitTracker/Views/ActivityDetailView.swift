//  Created by Deniz Gökay Hamzalı on 8.10.2024.
import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var viewModel: ActivityViewModel
    
    var body: some View {
        VStack {
            Text(activity.title)
                .font(.largeTitle)
            Text(activity.description)
                .font(.body)
            Text("Completed \(activity.completionCount) times")
                .font(.headline)
            Button("Complete") {
                viewModel.incrementCompletionCount(for: activity)
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .navigationTitle("Activity Details")
    }
}
