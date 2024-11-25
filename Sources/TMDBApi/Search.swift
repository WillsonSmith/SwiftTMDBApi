import Foundation
import MiscUtils

// MARK: - TMDBApi.Search

extension TMDBApi {
    func findMovies(title: String, year: Int? = nil) async throws -> Search
        .Response? {
        try await Search.fetch(
            apiKey: apiKey,
            searchType: .movie,
            queryItems: [
                URLQueryItem(name: "query", value: title),
                URLQueryItem(
                    name: "year",
                    value: year != nil ? String(year!) : nil
                ),
            ]
        )
    }
}

extension TMDBApi {
    public enum Search {
        public protocol Response: Codable {
            var page: Int { get }
        }

        public static func fetch(
            apiKey: String,
            searchType: SearchType,
            queryItems: [URLQueryItem]
        ) async throws -> Response? {
            guard let url = URL(string: searchType.endpoint)?
                .appending(queryItems: queryItems)
            else {
                throw URLError(.badURL)
            }

            return try await NetUtils.fetchJSON(
                url: url.absoluteString,
                headers: ["Authorization": "Bearer \(apiKey)"],
                decodeType: searchType.responseType
            )
        }
    }

    public enum SearchType {
        case collection
        case company
        case keyword
        case movie
        case multi
        case person
        case tv

        // MARK: Public

        public var endpoint: String {
            switch self {
            case .movie: return "\(baseAPIUrl)/search/movie"
            case .company: return "\(baseAPIUrl)/search/company"
            case .keyword: return "\(baseAPIUrl)/search/keyword"
            case .collection: return "\(baseAPIUrl)/search/collection"
            case .multi: return "\(baseAPIUrl)/search/multi"
            case .person: return "\(baseAPIUrl)/search/person"
            case .tv: return "\(baseAPIUrl)/search/tv"
            }
        }

        public var responseType: Search.Response.Type {
            switch self {
            case .movie: Search.MovieResponse.self
            case .collection: Search.CollectionResponse.self
            case .company: Search.CompanyResponse.self
            case .keyword: Search.KeywordResponse.self
            case .multi: Search.MultiResponse.self
            case .person: Search.PersonResponse.self
            case .tv: Search.TVResponse.self
            }
        }
    }
}

extension TMDBApi.Search {
    struct MovieResult: Codable {
        let id: Int
        let title: String
        let overview: String
        let backdrop_path: String?
        let poster_path: String?
        let production_companies: [TMDBApi.ProductionCompany]?
        let genres: [TMDBApi.Genre]?
    }

    struct MovieResponse: Codable, Response {
        let page: Int
        let results: [MovieResult]
        // let totalPages: Int
        // let totalResults: Int
    }
}

extension TMDBApi.Search {
    struct CollectionResponse: Response {
        let page: Int
    }

    struct CompanyResponse: Response {
        let page: Int
    }

    struct KeywordResponse: Response {
        let page: Int
    }

    struct MultiResponse: Response {
        let page: Int
    }

    struct PersonResponse: Response {
        let page: Int
    }

    struct TVResponse: Response {
        let page: Int
    }
}
