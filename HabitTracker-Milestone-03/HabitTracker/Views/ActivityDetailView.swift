//  Created by Deniz Gökay Hamzalı on 8.10.2024.
import SwiftUI

struct ActivityDetailView: View {
    let activity: Activity
    var viewModel: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text(activity.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .foregroundStyle(.title)
                .multilineTextAlignment(.center)
            
            Text(activity.description)
                .font(.body)
                .foregroundColor(.description)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        
            Text("Completed \(activity.completionCount) times")
                .font(.headline)
                .foregroundColor(.orange)
                .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                viewModel.incrementCompletionCount(for: activity)
            }) {
                Text("Complete")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
        }
        .padding(.top, 20)
        .padding(.horizontal)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Activity Details")
                    .foregroundStyle(.yellow)
                    .font(.title)
                    .fontWeight(.bold)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .tint(.orange)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let sampleActivity = Activity(title: "Morning Yoga", description: "A calming yoga session to start the day.", completionCount: 3)
    let viewModel = ActivityViewModel()
    ActivityDetailView(activity: sampleActivity, viewModel: viewModel)
}
