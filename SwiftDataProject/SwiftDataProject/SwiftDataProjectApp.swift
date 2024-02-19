//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Anna on 17/02/2024.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
