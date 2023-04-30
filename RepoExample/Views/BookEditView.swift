//
//  BookEditView.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import SwiftUI

struct BookEditView: View {
    @Binding var book: Book
    @Environment(\.dismiss) private var dismiss

    init(book: Binding<Book>) {
        self._book = book
    }

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Name")
                        .font(.title3)
                    TextField("Name", text: $book.name)
                }
                HStack {
                    Text("Pages")
                        .font(.title3)
                    TextField("Pages", value: $book.pages, formatter: NumberFormatter())
                }
            }
            .navigationTitle("Edit")
            .textFieldStyle(.roundedBorder)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
