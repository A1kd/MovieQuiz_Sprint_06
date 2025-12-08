//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by I on 04.12.2025.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
