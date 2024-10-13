//  Created by Deniz Gökay Hamzalı on 6.10.2024.
import SwiftUI

struct AddActivityView: View {
    var viewModel: ActivityViewModel
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Activity Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newActivity = Activity(title: title, description: description)
                        viewModel.addActivity(newActivity)
                        dismiss()
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                    .tint(.orange)
                    .buttonStyle(.borderedProminent)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                    .tint(.orange)
                }
                ToolbarItem(placement: .principal) {
                    Text("Add New Activity")
                        .foregroundStyle(.yellow)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        }
    }
}


#Preview {
    let activities: ActivityViewModel = .init()
    AddActivityView(viewModel: activities)
}
