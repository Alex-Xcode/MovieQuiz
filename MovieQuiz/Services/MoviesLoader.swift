<<<<<<< HEAD
=======

>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
<<<<<<< HEAD
    private let networkClient = NetworkClient()
    
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
=======
    private let networkClient: NetworkRouting
    private let mostPopularMoviesUrl: URL

    init(networkClient: NetworkRouting = NetworkClient(),
         mostPopularMoviesUrl: URL = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf")!) {
        self.networkClient = networkClient
        self.mostPopularMoviesUrl = mostPopularMoviesUrl
    }

>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let mostPopularMovies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    handler(.success(mostPopularMovies))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
<<<<<<< HEAD
=======

>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
