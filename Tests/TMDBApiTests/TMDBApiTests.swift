import Testing
@testable import TMDBApi

import MiscUtils

@Test
func example() async throws {
    let API =
        TMDBApi(
            apiKey: EnvUtils.env(for: "TMDB_ACCESS_TOKEN") ?? ""
        )

    do {
        let movie = try await API.fetchMovie(id: 11830)
        let movies = try await API.findMovies(title: "Star wars")
        print(movies)
    } catch {
        print("Error fetching \(error)")
    }

    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}
