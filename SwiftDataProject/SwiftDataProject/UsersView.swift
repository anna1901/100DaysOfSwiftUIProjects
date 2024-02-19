//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Anna on 19/02/2024.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    Text(user.name)
                    Spacer()
                    Text(String(user.jobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimumJoinDate: Date, sortOder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOder)
    }
    
    func addSample() {
        let user1 = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)
        let job1 = Job(name: "Singing", priority: 3)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        
        let _ = Job(name: "Dancing", priority: 1, owner: user1)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
