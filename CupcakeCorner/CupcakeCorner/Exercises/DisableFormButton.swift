//
//  DisableFormButton.swift
//  CupcakeCorner
//
//  Created by Anna Olak on 06/02/2024.
//

import SwiftUI

struct DisableFormButton: View {
    @State private var userName = ""
    @State private var email = ""
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account..")
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    DisableFormButton()
}
