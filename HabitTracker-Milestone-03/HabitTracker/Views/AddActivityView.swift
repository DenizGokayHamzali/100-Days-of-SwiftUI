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
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .toolbar {
                Button("Save") {
                    let newActivity = Activity(title: title, description: description)
                    viewModel.addActivity(newActivity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let activities: ActivityViewModel = .init()
    AddActivityView(viewModel: activities)
}
