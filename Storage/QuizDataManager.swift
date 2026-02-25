//
//  QuizDataManager.swift
//  QuizApp
//

import Foundation

class QuizDataManager {
    
    static let shared = QuizDataManager()
    private init() {}
    
    private let fileManager = FileManager.default
    
    private var documentsPath: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var topicsFileURL: URL {
        return documentsPath.appendingPathComponent("topics.json")
    }
    
    private var questionsFileURL: URL {
        return documentsPath.appendingPathComponent("questions.json")
    }
    
    // MARK: - Save Data
    func saveTopics(_ topics: [Topic]) -> Bool {
        do {
            let data = try JSONEncoder().encode(topics)
            try data.write(to: topicsFileURL)
            print("✅ Saved \(topics.count) topics")
            return true
        } catch {
            print("❌ Save failed: \(error)")
            return false
        }
    }
    
    func saveQuestions(_ questions: [Question]) -> Bool {
        do {
            let data = try JSONEncoder().encode(questions)
            try data.write(to: questionsFileURL)
            print("✅ Saved \(questions.count) questions")
            return true
        } catch {
            print("❌ Save failed: \(error)")
            return false
        }
    }
    
    // MARK: - Load Data
    func loadTopics() -> [Topic] {
        guard fileManager.fileExists(atPath: topicsFileURL.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: topicsFileURL)
            return try JSONDecoder().decode([Topic].self, from: data)
        } catch {
            print("❌ Load failed: \(error)")
            return []
        }
    }
    
    func loadQuestions() -> [Question] {
        guard fileManager.fileExists(atPath: questionsFileURL.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: questionsFileURL)
            return try JSONDecoder().decode([Question].self, from: data)
        } catch {
            print("❌ Load failed: \(error)")
            return []
        }
    }
    
    func loadQuestions(forTopicId id: Int) -> [Question] {
        return loadQuestions().filter { $0.topicId == id }
    }
    
    // MARK: - Cache Management
    func clearCache() -> Bool {
        do {
            if fileManager.fileExists(atPath: topicsFileURL.path) {
                try fileManager.removeItem(at: topicsFileURL)
            }
            if fileManager.fileExists(atPath: questionsFileURL.path) {
                try fileManager.removeItem(at: questionsFileURL)
            }
            return true
        } catch {
            print("❌ Clear cache failed: \(error)")
            return false
        }
    }
    
    func hasLocalData() -> Bool {
        return fileManager.fileExists(atPath: topicsFileURL.path)
    }
    
    // MARK: - Mock Data
    func createMockData() {
        let topics = [
            Topic(id: 1, title: "Swift Basics", description: "Learn Swift programming", questionCount: 3),
            Topic(id: 2, title: "iOS Development", description: "Build iOS apps", questionCount: 2)
        ]
        
        let questions = [
            Question(id: 1, topicId: 1, questionText: "What is Swift?",
                    options: ["A. A programming language", "B. A bird", "C. A car", "D. A food"],
                    correctAnswer: "A", difficulty: "Easy", isBookmarked: false),
            Question(id: 2, topicId: 1, questionText: "What is iOS?",
                    options: ["A. An operating system", "B. A phone", "C. An app", "D. A game"],
                    correctAnswer: "A", difficulty: "Easy", isBookmarked: false),
            Question(id: 3, topicId: 1, questionText: "What is Xcode?",
                    options: ["A. An IDE", "B. A game", "C. A website", "D. A phone"],
                    correctAnswer: "A", difficulty: "Medium", isBookmarked: false),
            Question(id: 4, topicId: 2, questionText: "What is UIKit?",
                    options: ["A. UI framework", "B. Database", "C. Network tool", "D. Game engine"],
                    correctAnswer: "A", difficulty: "Medium", isBookmarked: false),
            Question(id: 5, topicId: 2, questionText: "What is SwiftUI?",
                    options: ["A. UI framework", "B. Programming language", "C. Database", "D. Apple device"],
                    correctAnswer: "A", difficulty: "Hard", isBookmarked: false)
        ]
        
        _ = saveTopics(topics)
        _ = saveQuestions(questions)
    }
}
