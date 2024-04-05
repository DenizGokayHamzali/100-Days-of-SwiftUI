//  WeSplit-Project-01
//  Created by Deniz Gökay Hamzalı on 19.02.2024.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .foregroundColor(.purple)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header: Text("How much do you want to tip?").font(.headline).foregroundColor(.purple)) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                .textCase(nil)
                
                Section(header: Text("Amount per person").font(.headline).foregroundColor(.purple)) {
                    Text(totalPerPerson, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                }
                .textCase(nil)
                
                Section(header: Text("Total amount").font(.headline).foregroundColor(.purple)) {
                    Text(totalAmount, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                }
                .textCase(nil)
            } 
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Spacer()
                            Text("WeSplit").foregroundColor(.indigo).font(.title).fontWeight(.medium)
                            Spacer()
                        }
                    }
                }
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
