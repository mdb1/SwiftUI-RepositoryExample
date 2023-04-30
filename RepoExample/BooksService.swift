//
//  BooksService.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import Foundation

struct BooksService {
    func loadBooks() async throws -> [Book] {
        // Simulating a network call
        try await Task.sleep(for: .seconds(1))
        return [
            Book(name: "Atomic Habits", pages: 300),
            Book(name: "Rich Habits", pages: 150),
            Book(name: "Make Time", pages: 320)
        ]
    }

    func loadOneMoreBook() async throws -> Book {
        // Simulating a network call
        try await Task.sleep(for: .seconds(1))
        return Book(name: "A new book", pages: 200)
    }
}
