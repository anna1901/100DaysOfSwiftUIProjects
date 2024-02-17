//
//  CreatingDataObjects.swift
//  Bookworm
//
//  Created by Anna on 13/02/2024.
//

import SwiftData
import SwiftUI

struct CreatingDataObjects: View {
    @Environment(\.modelContext) private var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Anna", "Taylor", "Eve", "Lisa"]
                    let lastNames = ["Wintour", "Swift", "Longoria", "Jenkins"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    CreatingDataObjects()
        .modelContainer(for: Student.self)
}
