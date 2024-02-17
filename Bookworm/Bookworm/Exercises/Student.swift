//
//  Student.swift
//  Bookworm
//
//  Created by Anna on 13/02/2024.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
