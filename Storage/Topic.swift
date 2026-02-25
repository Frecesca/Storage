//
//  Topic.swift
//  QuizApp
//

import Foundation

struct Topic: Codable {
    let id: Int
    let title: String
    let description: String
    let questionCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case questionCount = "question_count"
    }
}
