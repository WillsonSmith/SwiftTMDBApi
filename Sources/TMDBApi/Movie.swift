import Foundation
import MiscUtils

extension TMDBApi {
    func fetchMovie(id: Int) async throws -> TMDBApi.Movie? {
        try await TMDBApi.Movie.fetch(apiKey: apiKey, movieId: id)
    }
}

extension TMDBApi {
    public struct ProductionCompany: Codable {
        public let id: Int
        public let name: String
    }

    public struct Genre: Codable {
        public let id: Int
        public let name: String
    }

    public struct Movie: Codable {
        public let id: Int
        public let title: String
        public let overview: String
        public let backdrop_path: String?
        public let poster_path: String?
        public let production_companies: [ProductionCompany]?
        public let genres: [Genre]?
    }
}

extension TMDBApi.Movie {
    static func fetch(apiKey: String, movieId: Int) async throws -> TMDBApi
        .Movie? {
        try await NetUtils.fetchJSON(
            url: "\(TMDBApi.baseAPIUrl)/movie/\(movieId)",
            headers: ["Authorization": "Bearer \(apiKey)"],
            decodeType: TMDBApi.Movie.self
        )
    }
}
