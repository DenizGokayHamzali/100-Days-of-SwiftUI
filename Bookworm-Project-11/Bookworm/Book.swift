//  Created by Deniz Gökay Hamzalı on 23.10.2024.

import SwiftData
import SwiftUI

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date
    
    var description: String {
        return "Title: \(title), Author: \(author), Genre: \(genre), Review: \(review), Rating: \(rating), Date: \(date)"
    }
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = .now) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
