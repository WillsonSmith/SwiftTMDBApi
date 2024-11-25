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
        let id: Int
        let adult: Bool
        let backdropPath: String?
        let genreIds: [Int]?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Double
        let posterPath: String?
        let releaseDate: String?
        let title: String?
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
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
