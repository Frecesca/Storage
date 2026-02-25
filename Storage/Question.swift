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
    
    enum CodingKeys: String, CodingKey {
        case id
        case topicId = "topic_id"
        case questionText = "question_text"
        case options
        case correctAnswer = "correct_answer"
        case difficulty
        case isBookmarked = "is_bookmarked"
    }
}

// Extension for dictionary conversion
extension Question {
    var dictionary: [String: Any] {
        return [
            "id": id,
            "topic_id": topicId,
            "question_text": questionText,
            "options": options,
            "correct_answer": correctAnswer,
            "difficulty": difficulty,
            "is_bookmarked": isBookmarked
        ]
    }
}
