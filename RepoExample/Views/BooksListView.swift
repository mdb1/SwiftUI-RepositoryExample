//
//  BooksListView.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import SwiftUI

struct BooksListView: View {
    @EnvironmentObject private var repository: BooksRepository

    var body: some View {
        NavigationView {
            VStack {
                // Use the binding reference of the repository
                List($repository.books, id: \.id) { $book in
                    NavigationLink(destination: BookDetailView(book: $book)) {
                        VStack {
                            Text(book.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Pages: \(Text(book.pages.description).bold())")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                Button("Load one more") {
                    Task {
                        await repository.loadOneMoreBook()
                    }
                }
            }
            .task {
                await repository.loadBooks()
            }
            .navigationTitle("Books")
            .toolbar {
                if repository.isLoading {
                    ProgressView()
                }
            }
        }
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
            .environmentObject(BooksRepository())
    }
}

