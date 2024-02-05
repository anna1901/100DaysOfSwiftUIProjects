//
//  ContentView.swift
//  HabitTracker
//
//  Created by Anna Olak on 01/02/2024.
//

import SwiftUI

struct ActivityItem: Codable, Identifiable, Hashable {
    var id = UUID()
    let title: String
    let description: String
    var count = 0
}

@Observable
class Activities {
    var items: [ActivityItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ActivityItems")
            }
        }
    }
    
    init() {
        if let encoded = UserDefaults.standard.data(forKey: "ActivityItems") {
            if let decoded = try? JSONDecoder().decode([ActivityItem].self, from: encoded) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(activities.items) { item in
                        NavigationLink {
                            DetailView(activity: item, activities: activities)
                        } label: {
                            Text(item.title)
                                .font(.headline)
                        }
                        
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                NavigationLink(destination: {
                    AddView(activities: activities)
                }) {
                    Button("Add Activity", systemImage: "plus") { }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
