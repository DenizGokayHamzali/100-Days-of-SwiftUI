//  Created by Deniz Gökay Hamzalı on 25.04.2024.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var filterType = "All"
    let filterOptions = ["All", "Personal", "Business"]
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            ExpenseItemsView(sortOrder: sortOrder, filterType: filterType)
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink("Add Expense", destination: AddView())
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.amount, order: .reverse)
                                    ])
                                Text("Sort by Amount")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                        SortDescriptor(\ExpenseItem.name)
                                    ])
                                
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Picker("Filter", selection: $filterType) {
                            ForEach(filterOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                    }
                }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
