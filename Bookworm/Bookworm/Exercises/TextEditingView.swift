//
//  TextEditingView.swift
//  Bookworm
//
//  Created by Anna on 13/02/2024.
//

import SwiftUI

struct TextEditingView: View {
    // never use for private data
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextField("Enter your note", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
        }
    }
}

#Preview {
    TextEditingView()
}
