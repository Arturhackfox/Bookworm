//
//  ContentView.swift
//  Bookworm
//
//  Created by Arthur Sh on 08.12.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse)
    ]) var books: FetchedResults<Book>
    
    @State private var showAddBookView = false
    var body: some View {
        NavigationView{
            List{
                ForEach(books) { book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown author")
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showAddBookView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offset: IndexSet) {
        for offset in offset {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
