//
//  AddBookView.swift
//  Bookworm
//
//  Created by Anna on 13/02/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var alertIsShowing = false
    @State private var alertMessage = ""
    
    var dataIsValid: Bool {
        !title.isEmpty && !author.isEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thirller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        if dataIsValid {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            alertMessage = "Title and author can't be blank"
                            alertIsShowing = true
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Oups!", isPresented: $alertIsShowing, actions: { }) {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    AddBookView()
}
