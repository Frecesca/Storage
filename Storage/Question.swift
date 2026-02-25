//
//  Question.swift
//  QuizApp
//

import Foundation

struct Question: Codable {
    let id: Int
    let topicId: Int
    let questionText: String
    let options: [String]
    let correctAnswer: String
    let difficulty: String
    var isBookmarked: Bool
}
