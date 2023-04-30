//
//  RepoExampleApp.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import SwiftUI

@main
struct RepoExampleApp: App {
    @StateObject private var booksRepository = BooksRepository()
    var body: some Scene {
        WindowGroup {
            BooksListView()
                .environmentObject(booksRepository)
                .buttonStyle(.bordered)
        }
    }
}
