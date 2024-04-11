//  UnitConverter
//  Created by Deniz Gökay Hamzalı on 21.02.2024.

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue: Double = -273.15
    @State private var inputUnit: String = "Celcius"
    @State private var outputUnit: String = "Kelvin"
    
    let units = ["Celcius", "Fahrenheit", "Kelvin"]
    
    func convert(value: Double, fromUnit: String, toUnit: String) -> String {
        switch (fromUnit, toUnit) {
        case ("Celcius", "Fahrenheit"):
            return String(value * 9 / 5 + 32)
        case ("Celcius", "Kelvin"):
            return String(value + 273.15)
        case ("Fahrenheit", "Celcius"):
            return String((value - 32) * 5 / 9)
        case ("Fahrenheit", "Kelvin"):
            return String((value - 32) * 5 / 9 + 273.15)
        case ("Kelvin", "Celcius"):
            return String(value - 273.15)
        case ("Kelvin", "Fahrenheit"):
            return String((value - 273.15) * 9 / 5 + 32)
        default:
            return String(value)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    TextField("Temperature", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundStyle(inputUnit == "Celcius" ? .orange : inputUnit == "Fahrenheit" ? .blue : .red)
                        .fontWeight(.medium)
                }
                
                Section {
                    Picker("From", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .pickerStyle(.segmented)
                
                Section {
                    Picker("To", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(convert(value: inputValue, fromUnit: inputUnit, toUnit: outputUnit))
                        .foregroundStyle(outputUnit == "Celcius" ? .orange : outputUnit == "Fahrenheit" ? .blue : .red)
                        .fontWeight(.medium)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Text("UnitConverter").foregroundStyle(.teal).font(.title).fontWeight(.medium)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
