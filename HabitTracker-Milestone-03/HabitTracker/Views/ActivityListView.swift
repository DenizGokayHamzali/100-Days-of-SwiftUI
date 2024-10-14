//  Created by Deniz Gökay Hamzalı on 10.10.2024.

import SwiftUI

struct ActivityListView: View {
    var viewModel: ActivityViewModel
    
    var body: some View {
        List(viewModel.activities) { activity in
            NavigationLink(destination: ActivityDetailView(activity: activity, viewModel: viewModel)) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(activity.title)
                        .font(.headline)
                        .foregroundStyle(Color.title)
                        .padding(3)
                    Text("Completed \(activity.completionCount) times.")
                        .font(.subheadline)
                        .foregroundColor(Color.description)
                }
                .padding(.vertical, 8)
            }
            .swipeActions {
                Button(role: .destructive) {
                    viewModel.deleteActivity(activity)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .background(Color.gray.opacity(0.1))
    }
}
