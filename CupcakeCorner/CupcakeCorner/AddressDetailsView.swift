//
//  AddressDetails.swift
//  CupcakeCorner
//
//  Created by Anna Olak on 08/02/2024.
//

import SwiftUI

struct AddressDetailsView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(!order.hasValidAddress)
        }
    }
}

#Preview {
    AddressDetailsView(order: Order())
}
