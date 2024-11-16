//  Created by Deniz Gökay Hamzalı on 25.04.2024.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ExpenseItem.name) var expenses: [ExpenseItem]
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var showingAddExpense = false
    
    
    var personalExpenses: [ExpenseItem] {
        return expenses.filter { $0.type == "Personal"}
    }
    
    var businessExpenses: [ExpenseItem] {
        return expenses.filter { $0.type == "Business"}
    }
    
    var body: some View {
        NavigationStack {
            ExpenseItemsView(sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink("Add Expense", destination: AddView())
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
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
