//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//

import Foundation

protocol StatisticServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
<<<<<<< HEAD

=======
    
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
    func store(correct count: Int, total amount: Int)
}
