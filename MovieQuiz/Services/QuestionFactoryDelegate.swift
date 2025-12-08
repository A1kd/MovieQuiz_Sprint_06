//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by I on 18.11.2025.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // успешная загрузка
    func didFailToLoadData(with error: Error) // ошибка загрузки
}
