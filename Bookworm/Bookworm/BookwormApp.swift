//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Anna on 13/02/2024.
//

import SwiftData
import SwiftUI

// This is called Abstract
@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
