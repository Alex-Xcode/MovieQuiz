<<<<<<< HEAD
<<<<<<< HEAD
//
//  QuestionFactory.swift
//  MovieQuiz
//
import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    weak var delegate: QuestionFactoryDelegate?

    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]
    
    func setup(delegate: QuestionFactoryDelegate) {
        self.delegate = delegate
    }

    func requestNextQuestion() {
        guard let index = (0..<questions.count).randomElement() else {
            delegate?.didReceiveNextQuestion(question: nil)
            return
        }

        let question = questions[index]
        delegate?.didReceiveNextQuestion(question: question)
=======
=======
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
import Foundation

final class QuestionFactory: QuestionFactoryProtocol {
    private let moviesLoader: MoviesLoading
    private weak var delegate: QuestionFactoryDelegate?
    
<<<<<<< HEAD
=======
    private var movies: [MostPopularMovie] = []
    
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    init(moviesLoader: MoviesLoading, delegate: QuestionFactoryDelegate?) {
        self.moviesLoader = moviesLoader
        self.delegate = delegate
    }
    
<<<<<<< HEAD
    private var movies: [MostPopularMovie] = []
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movie = self.movies[safe: index] else { return }
            var imageData = Data()
            do {
                imageData = try Data(contentsOf: movie.imageURL)
            } catch {
                print("Failed to load image")
            }
            
            let rating = Float(movie.rating) ?? 0
            let questionText = "Рейтинг этого фильма больше чем 6?"
            let correctAnswer = rating > 6
            let question = QuizQuestion(image: imageData, text: questionText, correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
=======
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    func loadData() {
        moviesLoader.loadMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let mostPopularMovies):
                    self?.movies = mostPopularMovies.items
                    self?.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self?.delegate?.didFailToLoadData(with: error)
                }
            }
        }
<<<<<<< HEAD
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
    }
}
=======
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let index = Int.random(in: 0..<self.movies.count)
            
            guard let movie = self.movies[safe: index],
                  let imageData = try? Data(contentsOf: movie.imageURL) else {
                DispatchQueue.main.async {
                    self.delegate?.didFailToLoadData(with: NSError(domain: "Image loading error", code: -1, userInfo: nil))
                }
                return
            }
            
            let rating = Float(movie.rating) ?? 0
            let comparisonType = Bool.random() ? "больше" : "меньше"
            let ratingValue = self.selectRatingValue()
            let correctAnswer: Bool
            
            if comparisonType == "больше" {
                correctAnswer = rating > ratingValue
            } else {
                correctAnswer = rating < ratingValue
            }
            
            let questionText = "Рейтинг этого фильма \(comparisonType) чем \(ratingValue)?"
            let question = QuizQuestion(image: imageData, text: questionText, correctAnswer: correctAnswer)
            
            DispatchQueue.main.async {
                self.delegate?.didReceiveNextQuestion(question: question)
            }
        }
    }
    
    private func selectRatingValue() -> Float {
        let ratings = movies.compactMap { Float($0.rating) }
        guard !ratings.isEmpty else {
            return 7.0
        }
        
        let averageRating = ratings.reduce(0, +) / Float(ratings.count)
        return round(averageRating * 10) / 10
    }
}

>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
