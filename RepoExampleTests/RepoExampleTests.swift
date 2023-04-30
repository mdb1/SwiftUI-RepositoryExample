//
//  RepoExampleTests.swift
//  RepoExampleTests
//
//  Created by Manu on 30/04/2023.
//

import XCTest
@testable import RepoExample

@MainActor
final class RepoTests: XCTestCase {
    func test_LoadBooks_Success() async {
        // Given
        let expectedBooks = [Book(name: "name", pages: 12)]
        let sut = BooksRepository(
            dependencies: BooksRepository.Dependencies(
                loadBooks: { expectedBooks },
                loadOneMoreBook: { Book(name: "new name", pages: 12) }
            )
        )
        XCTAssertEqual(sut.books.count, 0)

        // When
        await sut.loadBooks()

        // Then
        XCTAssertEqual(sut.books.count, 1)
        XCTAssertEqual(sut.books, expectedBooks)
    }

    func test_LoadBooks_Error() async {
        // Given
        let sut = BooksRepository(
            dependencies: BooksRepository.Dependencies(
                loadBooks: { throw MockError() },
                loadOneMoreBook: { Book(name: "new name", pages: 12) }
            )
        )
        XCTAssertEqual(sut.books.count, 0)

        // When
        await sut.loadBooks()

        // Then
        XCTAssertEqual(sut.books.count, 0)
        XCTAssertEqual(sut.books, [])
    }

    func test_LoadOneMoreBook_Success() async {
        // Given
        let expectedBook = Book(name: "name", pages: 12)
        let sut = BooksRepository(
            dependencies: BooksRepository.Dependencies(
                loadBooks: { [] },
                loadOneMoreBook: { expectedBook }
            )
        )
        XCTAssertEqual(sut.books.count, 0)

        // When
        await sut.loadOneMoreBook()

        // Then
        XCTAssertEqual(sut.books.count, 1)
        XCTAssertEqual(sut.books.first, expectedBook)
    }

    func test_LoadOneMoreBook_Error() async {
        // Given
        let sut = BooksRepository(
            dependencies: BooksRepository.Dependencies(
                loadBooks: { [] },
                loadOneMoreBook: { throw MockError() }
            )
        )
        XCTAssertEqual(sut.books.count, 0)

        // When
        await sut.loadOneMoreBook()

        // Then
        XCTAssertEqual(sut.books.count, 0)
        XCTAssertEqual(sut.books, [])
    }

    func test_Delete() {
        // Given
        let sut = BooksRepository()
        let book = Book(name: "name", pages: 12)
        sut.books = [book]
        XCTAssertEqual(sut.books.count, 1)

        // When
        sut.delete(id: book.id)

        // Then
        XCTAssertEqual(sut.books.count, 0)
    }
}

struct MockError: Error {}
