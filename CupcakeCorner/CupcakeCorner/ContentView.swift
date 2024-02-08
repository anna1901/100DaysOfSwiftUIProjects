//
//  ContentView.swift
//  CupcakeCorner
//
//  Created on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type:", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                
                if order.specialRequestEnabled {
                    Toggle("Extra sprincles", isOn: $order.addSprincles)
                    Toggle("Extra frosting", isOn: $order.extraFrosting)
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressDetailsView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
