//  Created by Deniz Gökay Hamzalı on 25.04.2024.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        return expenses.filter { $0.type == "Personal"}
    }
    
    var businessExpenses: [ExpenseItem] {
        return expenses.filter { $0.type == "Business"}
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(personalExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .orange : .pink)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section {
                    ForEach(businessExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .orange : .pink)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink("Add Expense", destination: AddView(expenses: expenses))
            }
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        expenses.items.removeAll(where: { $0.type == "Personal" && offsets.contains(personalExpenses.firstIndex(of: $0)!) })
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        expenses.items.removeAll(where: { $0.type == "Business" && offsets.contains(businessExpenses.firstIndex(of: $0)!) })
    }
}

#Preview {
    ContentView()
}
