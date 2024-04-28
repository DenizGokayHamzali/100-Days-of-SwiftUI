//  Created by Deniz Gökay Hamzalı on 25.04.2024.

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var personalExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Personal"}
    }
    
    var businessExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Business"}
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
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
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
