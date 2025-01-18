//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack(spacing: 16) {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(book.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                    .overlay(book.rating == 1 ? Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundStyle(.red)
                                        .offset(x: 25)
                                        .transition(.scale) : nil,
                                             alignment: .trailing
                                    )
                                
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Bookworm").foregroundColor(.title).font(.title).fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddScreen.toggle()
                    }) {
                        HStack {
                            Image(systemName: "book.pages")
                                .foregroundColor(.button)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .foregroundColor(.button)
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // Find this book in our query.
            let book = books[offset]
            
            // Delete it from the context.
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self)
}
