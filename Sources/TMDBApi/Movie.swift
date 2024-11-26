import Foundation
import MiscUtils

extension TMDBApi {
    func fetchMovie(id: Int) async throws -> TMDBApi.MovieDetail.Response? {
        try await TMDBApi.Movie.fetch(apiKey: apiKey, movieId: id)
    }
}

// MARK: - TMDBApi.MovieDetail

extension TMDBApi {
    enum MovieDetail {
        struct Collection: Codable {
            let id: Int
            let name: String
            let posterPath: String?
            let backdropPath: String?
        }

        struct ProductionCountry: Codable {
            let iso31661: String?
            let name: String?
        }

        struct SpokenLanguage: Codable {
            let englishName: String?
            let iso6391: String?
            let name: String?
        }

        struct Response: Codable {
            let adult: Bool
            let backdropPath: String?
            let belongsToCollection: Collection?
            let budget: Int
            let genres: [Genre]
            let homepage: String?
            let id: Int
            let imdbId: String?
            let originalLanguage: String?
            let originalTitle: String?
            let overview: String?
            let popularity: Double
            let posterPath: String?
            let productionCompanies: [ProductionCompany]
            let productionCountries: [ProductionCountry]
            let releaseDate: String?
            let revenue: Int
            let runtime: Int
            let spokenLanguages: [SpokenLanguage]
            let status: String?
            let tagline: String?
            let title: String?
            let video: Bool
            let voteAverage: Double
            let voteCount: Int
        }
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
        .MovieDetail.Response? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try await NetUtils.fetchJSON(
            url: "\(TMDBApi.baseAPIUrl)/movie/\(movieId)",
            headers: ["Authorization": "Bearer \(apiKey)"],
            decoder: decoder,
            decodeType: TMDBApi.MovieDetail.Response.self
        )
    }
}
