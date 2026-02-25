import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    private let serverURLKey = "serverURL"
    
    // Default server URL
    private let defaultServerURL = "https://example.com/api/questions"
    
    // Save server URL to UserDefaults
    func saveServerURL(_ url: String) {
        UserDefaults.standard.set(url, forKey: serverURLKey)
        UserDefaults.standard.synchronize()
    }
    
    // Get server URL from UserDefaults
    func getServerURL() -> String {
        return UserDefaults.standard.string(forKey: serverURLKey) ?? defaultServerURL
    }
}
