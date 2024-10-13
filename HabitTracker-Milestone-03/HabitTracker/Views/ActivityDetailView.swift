//  Created by Deniz Gökay Hamzalı on 8.10.2024.
import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var viewModel: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(activity.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(activity.description)
                .font(.body)
                .foregroundColor(.secondary)
            Text("Completed \(activity.completionCount) times")
                .font(.headline)
            Button(action: {
                viewModel.incrementCompletionCount(for: activity)
            }) {
                Text("Complete")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Activity Details")
                    .foregroundStyle(.yellow)
                    .font(.title)
                    .fontWeight(.bold)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel"){
                    dismiss()
                }
                .tint(.orange)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
