//
//  BookDetailView.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject private var repository: BooksRepository
    @Binding var book: Book
    @State private var editMode: Bool = false

    var body: some View {
        VStack {
            Text(book.name)
                .font(.title)
            Text("Pages: \(Text(book.pages.description).bold())")
                .font(.subheadline)
                .padding(.bottom, 32)

            Button("Delete") {
                repository.delete(id: book.id)
            }
            .tint(.red)
        }
        .toolbar {
            Button {
                editMode = true
            } label: {
                Label("Edit", systemImage: "pencil")
                    .labelStyle(.titleAndIcon)
            }
            .buttonStyle(.borderless)
        }
        .sheet(isPresented: $editMode) {
            BookEditView(book: $book)
        }
    }
}
