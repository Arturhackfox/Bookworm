//
//  DetailView.swift
//  Bookworm
//
//  Created by Arthur Sh on 10.12.2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let book: Book
    
    @State var isDeleteAlertShowing = false
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "FANTASY")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                
                
            }
            
            Text(book.author ?? "Unknown")
                .padding()
                .font(.largeTitle.bold())
                .foregroundColor(.secondary)
                .opacity(0.75)
                
            Text(book.review ?? "No review")
                .padding()
                
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $isDeleteAlertShowing) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button{
                isDeleteAlertShowing = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        
    }
    
    func deleteBook(){
        moc.delete(book)
        
        try? moc.save()
        
        dismiss()
    }
}

