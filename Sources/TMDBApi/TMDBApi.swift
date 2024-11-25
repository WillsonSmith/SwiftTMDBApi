// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// MARK: - TMDBApi

public struct TMDBApi {
    // MARK: Public

    public static let baseAPIUrl: String = "https://api.themoviedb.org/3"

    public let apiKey: String

    // MARK: Internal

    func encodeQuery(query: String) -> String? {
        query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}

// MARK: TMDBApi.SearchType

extension TMDBApi {}
