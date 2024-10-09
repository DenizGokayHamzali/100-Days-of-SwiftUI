//  Created by Deniz Gökay Hamzalı on 8.10.2024.
import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var viewModel: ActivityViewModel
    
    var body: some View {
        VStack {
            Text(activity.title)
            Text(activity.description)
            Text("Completed \(activity.completionCount) times")
            Button("Complete") {
                viewModel.incrementCompletionCount(for: activity)
            }
        }
    }
}
