//
//  Book.swift
//  RepoExample
//
//  Created by Manu on 30/04/2023.
//

import Foundation

struct Book: Equatable {
    let id: UUID = UUID()
    var name: String
    var pages: Int
}
