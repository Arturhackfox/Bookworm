//
//   AddBookView.swift
//  Bookworm
//
//  Created by Arthur Sh on 09.12.2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var rating = 3
    @State var author = ""
    @State var review = ""
    @State var genre = "Fantasy"
    @State var date = Date.now
    
    var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var isSaveDisabled: Bool {
        if title.isEmpty || title.hasPrefix(" ") || author.isEmpty || author.hasPrefix(" ") || review.isEmpty || review.hasPrefix(" ") { return true}
        return false
    }
    
    var body: some View {
        Form{
            Section {
                TextField("Name of the book", text: $title)
                TextField("Author's name", text: $author)
                Picker("Genre", selection: $genre){
                    ForEach(genres, id: \.self){
                        Text($0)
                    }
                }
            }
                
                Section("Write a review"){
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Button("Save"){
                    let book = Book(context: moc)
                    book.id = UUID()
                    book.title = title
                    book.author = author
                    book.rating = Int16(rating)
                    book.review = review
                    book.genre = genre
                    book.date = date
                    
                    try? moc.save()
                    dismiss()
                }
                .disabled(isSaveDisabled)
            
        }
        .navigationTitle("Add book")
    }
}

struct _AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
