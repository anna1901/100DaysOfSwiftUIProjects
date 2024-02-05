//
//  FlexibleGridView.swift
//  Moonshot
//
//  Created by Anna Olak on 22/01/2024.
//

import SwiftUI

struct FlexibleGridView: View {
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    let adaptiveLayout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveLayout, content: {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            })
        }
    }
}

#Preview {
    FlexibleGridView()
}
