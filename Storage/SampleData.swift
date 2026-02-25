import Foundation

struct SampleData {
    static func createSampleData() -> QuizData {
        // Create sample topics
        let topics = [
            Topic(id: 1, title: "Swift Programming", description: "Test your Swift knowledge"),
            Topic(id: 2, title: "iOS Development", description: "iOS basics and beyond")
        ]
        
        // Create sample questions
        let questions = [
            Question(
                id: 1,
                topicId: 1,
                questionText: "What is Swift?",
                answerA: "A programming language",
                answerB: "A car",
                answerC: "A bird",
                answerD: "A food",
                correctAnswer: "A"
            ),
            Question(
                id: 2,
                topicId: 1,
                questionText: "Which keyword is used to create a constant?",
                answerA: "var",
                answerB: "let",
                answerC: "const",
                answerD: "static",
                correctAnswer: "B"
            ),
            Question(
                id: 3,
                topicId: 2,
                questionText: "What is Xcode?",
                answerA: "A game",
                answerB: "An IDE for iOS development",
                answerC: "A programming language",
                answerD: "A database",
                correctAnswer: "B"
            )
        ]
        
        return QuizData(topics: topics, questions: questions)
    }
}
