//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "ScienceFiction", "Thriller"]
    
    @Environment(\.dismiss) var dismiss
    
    private var isFormValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAuthor = author.trimmingCharacters(in: .whitespacesAndNewlines)
        return !(trimmedTitle.isEmpty) && !(trimmedAuthor.isEmpty)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                }
                
                Section {
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        RatingView(rating: $rating)
                        Spacer()
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Add Book").foregroundColor(.title).font(.title).fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                    .foregroundStyle(.button)
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
