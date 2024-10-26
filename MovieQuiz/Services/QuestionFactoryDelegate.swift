<<<<<<< HEAD
<<<<<<< HEAD
//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
=======
=======
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
<<<<<<< HEAD
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
=======
>>>>>>> c4e6f38595fe571f5900ba578065e5cd2811bab8
}
