//
//  DataError.swift
//  CloudNotes
//
//  Created by 최정민 on 2021/06/02.
//

import Foundation

enum DataError: Error {
    case loadJSON
    case decodeJSON
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .loadJSON:
            return "Failed to load JSON data."
        case .decodeJSON:
            return "Failed to decode JSON data"
        }
    }
}
