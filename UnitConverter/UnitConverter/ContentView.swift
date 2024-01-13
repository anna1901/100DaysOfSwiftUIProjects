//
//  ContentView.swift
//  UnitConverter
//
//  Created by Anna Olak on 01/01/2024.
//

import SwiftUI

struct ContentView: View {
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.meters
    @State private var inputNumber: Double = 0
    @FocusState private var inputNumberIsFocused: Bool
    
    private var outputValue: Double {
        let input = Measurement(value: inputNumber, unit: inputUnit)
        return input.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Input", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                    .focused($inputNumberIsFocused)
                }
                Section("Source Unit") {
                    Picker("Source Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output value") {
                    Text("\(outputValue.formatted())")
                }
            }
            .navigationTitle("UnitConverer")
            .toolbar {
                if inputNumberIsFocused {
                    Button("Done") {
                        inputNumberIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
