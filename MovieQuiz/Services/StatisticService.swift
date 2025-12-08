//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by I on 04.12.2025.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case correct
        case total
        case bestGameCorrect
        case bestGameTotal
        case bestGameDate
        case gamesCount
    }
    
    var totalAccuracy: Double {
        let total = storage.integer(forKey: Keys.total.rawValue)
        let correct = storage.integer(forKey: Keys.correct.rawValue)
        
        guard total > 0 else {
            return 0
        }
        
        return Double(correct) / Double(total) * 100
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let currentCorrect = storage.integer(forKey: Keys.correct.rawValue)
        let currentTotal = storage.integer(forKey: Keys.total.rawValue)
        
        storage.set(currentCorrect + count, forKey: Keys.correct.rawValue)
        storage.set(currentTotal + amount, forKey: Keys.total.rawValue)
        
        gamesCount += 1
        
        let newGame = GameResult(correct: count, total: amount, date: Date())
        
        if newGame.isBetterThan(bestGame) {
            bestGame = newGame
        }
    }
}
