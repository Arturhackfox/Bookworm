//
//  ContentView.swift
//  Bookworm
//
//  Created by Arthur Sh on 08.12.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showAddBookView = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(books) { book in
                    NavigationLink{
                        Text(book.title ?? "Unknown")
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
            }
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add book"){
                        showAddBookView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showAddBookView) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
