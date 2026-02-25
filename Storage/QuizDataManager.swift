//
//  QuizDataManager.swift
//  QuizApp
//

import Foundation
import UIKit

class QuizDataManager {
    
    // MARK: - Singleton
    static let shared = QuizDataManager()
    private init() {}
    
    // MARK: - File Manager
    private let fileManager = FileManager.default
    
    private var documentsDirectory: URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var topicsFileURL: URL {
        return documentsDirectory.appendingPathComponent("topics.json")
    }
    
    private var questionsFileURL: URL {
        return documentsDirectory.appendingPathComponent("questions.json")
    }
    
    // MARK: - Save Data to JSON
    func saveTopics(_ topics: [Topic]) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(topics)
            try data.write(to: topicsFileURL)
            print("✅ Topics saved successfully: \(topics.count) topics")
            return true
        } catch {
            print("❌ Failed to save topics: \(error.localizedDescription)")
            return false
        }
    }
    
    func saveQuestions(_ questions: [Question]) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(questions)
            try data.write(to: questionsFileURL)
            print("✅ Questions saved successfully: \(questions.count) questions")
            return true
        } catch {
            print("❌ Failed to save questions: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Load Data from JSON
    func loadTopics() -> [Topic] {
        guard fileManager.fileExists(atPath: topicsFileURL.path) else {
            print("⚠️ Topics file does not exist")
            return []
        }
        
        do {
            let data = try Data(contentsOf: topicsFileURL)
            let decoder = JSONDecoder()
            let topics = try decoder.decode([Topic].self, from: data)
            print("✅ Topics loaded successfully: \(topics.count) topics")
            return topics
        } catch {
            print("❌ Failed to load topics: \(error.localizedDescription)")
            return []
        }
    }
    
    func loadQuestions() -> [Question] {
        guard fileManager.fileExists(atPath: questionsFileURL.path) else {
            print("⚠️ Questions file does not exist")
            return []
        }
        
        do {
            let data = try Data(contentsOf: questionsFileURL)
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Question].self, from: data)
            print("✅ Questions loaded successfully: \(questions.count) questions")
            return questions
        } catch {
            print("❌ Failed to load questions: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Load Questions by Topic
    func loadQuestions(forTopicId topicId: Int) -> [Question] {
        let allQuestions = loadQuestions()
        return allQuestions.filter { $0.topicId == topicId }
    }
    
    // MARK: - Cache Management
    func getCacheSize() -> String {
        var totalSize: UInt64 = 0
        
        let fileURLs = [topicsFileURL, questionsFileURL]
        
        for url in fileURLs {
            if fileManager.fileExists(atPath: url.path) {
                do {
                    let attributes = try fileManager.attributesOfItem(atPath: url.path)
                    if let size = attributes[.size] as? UInt64 {
                        totalSize += size
                    }
                } catch {
                    print("Failed to get file size: \(error)")
                }
            }
        }
        
        // Format the size
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(totalSize))
    }
    
    func clearCache() -> Bool {
        do {
            let fileURLs = [topicsFileURL, questionsFileURL]
            
            for url in fileURLs {
                if fileManager.fileExists(atPath: url.path) {
                    try fileManager.removeItem(at: url)
                    print("✅ Deleted: \(url.lastPathComponent)")
                }
            }
            
            return true
        } catch {
            print("❌ Failed to clear cache: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Check if data exists
    func hasLocalData() -> Bool {
        return fileManager.fileExists(atPath: topicsFileURL.path) ||
               fileManager.fileExists(atPath: questionsFileURL.path)
    }
    
    // MARK: - Get last sync time
    func getLastSyncTime() -> Date? {
        guard fileManager.fileExists(atPath: topicsFileURL.path) else {
            return nil
        }
        
        do {
            let attributes = try fileManager.attributesOfItem(atPath: topicsFileURL.path)
            return attributes[.modificationDate] as? Date
        } catch {
            print("Failed to get modification date: \(error)")
            return nil
        }
    }
    
    // MARK: - Mock Data for Testing
    func createMockData() {
        let mockTopics = [
            Topic(id: 1, title: "Swift Programming", description: "Learn Swift basics and advanced concepts", questionCount: 10),
            Topic(id: 2, title: "iOS Development", description: "UIKit and SwiftUI frameworks", questionCount: 8),
            Topic(id: 3, title: "Data Structures", description: "Algorithms and data structures", questionCount: 15)
        ]
        
        let mockQuestions = [
            Question(id: 1, topicId: 1, questionText: "What is an Optional in Swift?",
                    options: ["A. A type that can hold a value", "B. A type that can hold nil", "C. A reference type", "D. A value type"],
                    correctAnswer: "B", difficulty: "Easy", isBookmarked: false),
            Question(id: 2, topicId: 1, questionText: "What is a closure in Swift?",
                    options: ["A. A function without name", "B. A class", "C. A struct", "D. A protocol"],
                    correctAnswer: "A", difficulty: "Medium", isBookmarked: false),
            Question(id: 3, topicId: 2, questionText: "What is UIView?",
                    options: ["A. A view controller", "B. A visual element", "C. A data model", "D. A network request"],
                    correctAnswer: "B", difficulty: "Easy", isBookmarked: false)
        ]
        
        _ = saveTopics(mockTopics)
        _ = saveQuestions(mockQuestions)
    }
}
