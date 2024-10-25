//
//  GameResult.swift
//  MovieQuiz
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
<<<<<<< HEAD
func isBetterThan(_ another: GameResult) -> Bool {
=======
    func isBetterThan(_ another: GameResult) -> Bool {
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
        correct > another.correct
    }
}
