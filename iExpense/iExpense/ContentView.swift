//
//  ContentView.swift
//  iExpense
//
//  Created on 19/01/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            businessItems = items.filter({$0.type == "Business"})
            personalItems = items.filter({$0.type == "Personal"})
        }
    }
    var personalItems = [ExpenseItem]() {
        didSet {
            let removed = oldValue.filter { item in
                !personalItems.contains(where: { $0.id == item.id })
            }
            removed.forEach({item in items.removeAll(where: {$0.id == item.id})})
        }
    }
    var businessItems = [ExpenseItem]() {
        didSet {
            let removed = oldValue.filter { item in
                !businessItems.contains(where: { $0.id == item.id })
            }
            removed.forEach({item in items.removeAll(where: {$0.id == item.id})})
        }
    }
    
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                businessItems = items.filter({$0.type == "Business"})
                personalItems = items.filter({$0.type == "Personal"})
                return
            }
        }
        
        items = []
    }
}

extension Color {
    static func colorForValue(value: Double) -> Color {
        switch value {
        case 0...10:
            return Color(red: 0, green: 0.1, blue: 1).opacity(0.5)
        case 10...100:
            return Color(red: 0, green: 0.1, blue: 1).opacity(0.7)
        default:
            return Color(red: 0.2, green: 0.2, blue: 1)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .listRowBackground(LinearGradient(stops: [
                            .init(color: .white, location: 0.5),
                            .init(color: Color.colorForValue(value: item.amount).opacity(0.5), location: 1)
                        ], startPoint: .leading, endPoint: .trailing))
                    }
                    .onDelete { indexSets in
                        removeItems(at: indexSets, type: "Business")
                    }
                }
                
                Section("Personal") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .listRowBackground(LinearGradient(stops: [
                            .init(color: .white, location: 0.5),
                            .init(color: Color.colorForValue(value: item.amount).opacity(0.5), location: 1)
                        ], startPoint: .leading, endPoint: .trailing))
                    }
                    .onDelete { indexSets in
                        removeItems(at: indexSets, type: "Personal")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: {
                    AddView(expenses: expenses)
                }) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, type: String = "Personal") {
        if type == "Personal" {
            expenses.personalItems.remove(atOffsets: offsets)
        } else {
            expenses.businessItems.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    ContentView()
}
