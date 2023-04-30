//
//  BooksRepository.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import Foundation
import SwiftUI

@MainActor
final class BooksRepository: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    private let dependencies: Dependencies

    init(dependencies: Dependencies = .default) {
        self.dependencies = dependencies
    }

    func loadBooks() async {
        if !books.isEmpty { return }
        isLoading = true
        if let books = try? await dependencies.loadBooks() {
            self.books = books
        }
        isLoading = false
    }

    func loadOneMoreBook() async {
        isLoading = true
        if let book = try? await dependencies.loadOneMoreBook() {
            books.append(book)
        }
        isLoading = false
    }

    func delete(id: UUID) {
        if let index = books.firstIndex(where: { $0.id == id }) {
            books.remove(at: index)
        }
    }
}

extension BooksRepository {
    struct Dependencies {
        var loadBooks: () async throws -> [Book]
        var loadOneMoreBook: () async throws -> Book

        static var `default`: Self {
            let service = BooksService()
            return Dependencies(
                loadBooks: service.loadBooks,
                loadOneMoreBook: service.loadOneMoreBook
            )
        }
    }
}
