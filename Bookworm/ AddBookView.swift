//
//   AddBookView.swift
//  Bookworm
//
//  Created by Arthur Sh on 09.12.2022.
//

import SwiftUI

struct _AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var rating = 0
    @State var author = ""
    @State var review = ""
    @State var genre = ""
    
    var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
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
                    Picker("Rating", selection: $rating){
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }
                }
                
                Button("Save"){
                    let book = Book(context: moc)
                    book.id = UUID()
                    book.title = title
                    book.author = author
                    book.rating = Int16(rating)
                    book.review = review
                    book.genre = genre
                    
                    try? moc.save()
                    dismiss()
                }
            
        }
        .navigationTitle("Add book")
    }
}

struct _AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        _AddBookView()
    }
}
