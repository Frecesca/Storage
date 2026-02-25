import Foundation

struct Question: Codable {
    let id: Int
    let topicId: Int
    let questionText: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let correctAnswer: String
    
    // Get array of answers
    func getAnswers() -> [String] {
        return [answerA, answerB, answerC, answerD]
    }
}

struct Topic: Codable {
    let id: Int
    let title: String
    let description: String
}

struct QuizData: Codable {
    let topics: [Topic]
    let questions: [Question]
}
