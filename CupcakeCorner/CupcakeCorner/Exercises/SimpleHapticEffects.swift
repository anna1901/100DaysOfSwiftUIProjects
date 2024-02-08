//
//  SimpleHapticEffects.swift
//  CupcakeCorner
//
//  Created by Anna Olak on 06/02/2024.
//

import SwiftUI

struct SimpleHapticEffects: View {
    @State private var counter = 0
    @State private var counter2 = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Tap Counter: \(counter)") {
                counter += 1
            }
            .sensoryFeedback(.increase, trigger: counter)
            Button("Tap Counter: \(counter)") {
                counter2 += 1
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: counter2)
        }
    }
}

#Preview {
    SimpleHapticEffects()
}
