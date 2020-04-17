
import Foundation

class KeysService: NSObject {
    
    enum BuildType: String {
        case development
    }
    
    // MARK: - SINGLETON
    static let shared: KeysService = {
        let instance = KeysService()
        return instance
    }()
    
    /// Init key
    /// - returns: object KeysService
    override init() {
        super.init()
        updateEnv()
    }
    
    /// Build type
    static var buildType: BuildType?
    
    /// Directory
    fileprivate var directory: NSMutableDictionary = NSMutableDictionary()
    
    /// Return path to plist
    /// - returns: path
    fileprivate func getPath() -> String {
        let nameFile = "Key-development"
        return Bundle.main.path(forResource: nameFile, ofType: "plist")! as String
    }
    
    /// Update env files
    fileprivate func updateEnv() {
        directory = getDirectory() ?? NSMutableDictionary()
    }
    
    /// Return directory
    /// - returns: directory
    fileprivate func getDirectory() -> NSMutableDictionary? {
        return NSMutableDictionary(contentsOfFile: getPath())
    }
    
    /// Return string value for key
    /// - parameter key: key for get string value
    /// - returns: value
    func string(key: String) -> String? {
        return directory.object(forKey: "\(key)") as? String
    }

}

extension KeysService {
    enum Key {
        static var apiURL: String { return KeysService.shared.string(key: "API_Url")! }
        static var APIVersion: String { return KeysService.shared.string(key: "API_Version")! }
    }
}
