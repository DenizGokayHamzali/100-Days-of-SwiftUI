//  Created by Deniz Gökay Hamzalı on 16.11.2024.

import SwiftData
import SwiftUI

struct ExpenseItemsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    var filterType: String
    
    var filteredExpenses: [ExpenseItem] {
        switch filterType {
        case "Personal":
            return expenses.filter { $0.type == "Personal" }
        case "Business":
            return expenses.filter { $0.type == "Business" }
        default:
            return expenses
        }
    }
    
    var body: some View {
        List {
            Section {
                ForEach(filteredExpenses) { item in
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
                .onDelete(perform: removeItems)
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], filterType: String) {
        _expenses = Query(sort: sortOrder)
        self.filterType = filterType
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = filteredExpenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpenseItemsView(sortOrder: [SortDescriptor(\ExpenseItem.name)], filterType: "All")
        .modelContainer(for: ExpenseItem.self)
}
