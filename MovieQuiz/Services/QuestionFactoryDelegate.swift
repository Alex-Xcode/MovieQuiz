<<<<<<< HEAD
//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
=======

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
>>>>>>> 6996d3308e530aff7762777e39587a03be7175bd
}
