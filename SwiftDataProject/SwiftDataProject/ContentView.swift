//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Anna on 17/02/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showUpcomingOnly ? .now : .distantPast, sortOder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Add samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        let first = User(name: "Luke Skywalker", city: "Tatooine", joinDate: .now.addingTimeInterval(86400 * 10))
                        let second = User(name: "Anakin Skywalker", city: "Tatooine", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Obi-wan Kenobi", city: "Stewjon", joinDate: .now.addingTimeInterval(86400 * -10))
                        let fourth = User(name: "Princess Leia", city: "Alderaan", joinDate: .now.addingTimeInterval(86400 * 5))
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                    
                    Button(showUpcomingOnly ? "Show everyone" : "Show Upcoming") {
                        showUpcomingOnly.toggle()
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
