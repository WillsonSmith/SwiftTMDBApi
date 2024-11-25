import Testing
@testable import TMDBApi

@Test
func example() async throws {
    let API =
        TMDBApi(
            apiKey: ""
        )

    do {
        let movies = try await API.findMovies(title: "Star wars")
        print("fetched")
        print(movies)
    } catch {
        print("Error fetching \(error)")
    }

    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}
