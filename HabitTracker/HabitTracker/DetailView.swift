//
//  DetailView.swift
//  HabitTracker
//
//  Created by Anna Olak on 01/02/2024.
//

import SwiftUI

struct DetailView: View {
    @State var activity: ActivityItem
    @State var activities: Activities
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(activity.description)
                .padding(.top, 10)
            Text("Activity was done ^[\(activity.count) time](inflect: true)")
            Spacer()
            Button(action: {
                activity.count += 1
                let copy = activity
                if let index = activities.items.firstIndex(where:  { $0.id == activity.id}) {
                    activities.items[index] = copy
                }
            }, label: {
                Text("Log activity")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(.capsule)
            })
            Spacer()
        }
        .padding()
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(activity: ActivityItem(title: "Yoga", description: "I want to do 10 mins of yoga every day"), activities: Activities())
    }
}
