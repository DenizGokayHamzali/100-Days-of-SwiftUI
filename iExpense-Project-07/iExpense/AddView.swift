//  Created by Deniz Gökay Hamzalı on 27.04.2024.

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismis
    
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var expenseName = "Add New Expense"
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($expenseName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel") {
                        dismis()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        let item = ExpenseItem(name: expenseName, type: type, amount: amount)
                        expenses.items.append(item)
                        dismis()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddView(expenses: Expenses())
}
