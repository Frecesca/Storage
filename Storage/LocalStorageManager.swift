import Foundation

class LocalStorageManager {
    static let shared = LocalStorageManager()
    private let fileName = "quiz_data.json"
    
    // Get local file path
    private var localFilePath: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // Save data to local storage
    func saveQuizData(_ quizData: QuizData) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(quizData)
            try data.write(to: localFilePath)
            print("Data saved successfully at: \(localFilePath)")
            return true
        } catch {
            print("Save failed: \(error.localizedDescription)")
            return false
        }
    }
    
    // Load data from local storage
    func loadQuizData() -> QuizData? {
        do {
            let data = try Data(contentsOf: localFilePath)
            let decoder = JSONDecoder()
            let quizData = try decoder.decode(QuizData.self, from: data)
            return quizData
        } catch {
            print("Load failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Check if local data exists
    func hasLocalData() -> Bool {
        return FileManager.default.fileExists(atPath: localFilePath.path)
    }
}
