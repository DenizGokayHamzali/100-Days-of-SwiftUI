//  Created by Deniz Gökay Hamzalı on 24.10.2024.

import SwiftData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: book.date)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 10)
                    
                    Text(book.genre.uppercased())
                        .font(.caption.bold())
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .padding(12)
                }
                
                
                VStack(spacing: 16) {
                    Text(book.author)
                        .font(.title2.bold())
                        .foregroundStyle(.primary)
                    
                    Text("Added on \(formattedDate)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)
                    
                    Text(book.review)
                        .font(.subheadline)
                        .lineSpacing(8)
                        .padding(.horizontal)
                    
                    RatingView(rating: .constant(book.rating))
                        .font(.title)
                        .padding(.top, 8)
                }
                .padding()
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to  create preview: \(error.localizedDescription)")
    }
}
