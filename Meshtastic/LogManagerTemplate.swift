import UIKit

func setDebugLevel(level: DebugLevel?, for space: DebugSpace) {
    #if DEBUG
        LogManager.shared.debugLevel[space] = level
    #endif
}

enum DebugLevel: Int {
    case debug = 1
    case info = 2
    case error = 3
}

enum DebugSpace: String {
    case generic = "generic"
    case network = "network"
    case mesh = "mesh"
}

func debugLog(_ debugText: String, level: DebugLevel = .debug, space: DebugSpace = .generic, function: String = #function) {
    #if DEBUG
        LogManager.shared.log("\(function): \n\(debugText)", level: level, space: space)
    #endif
}

private class LogManager: NSObject {
    static let shared = LogManager()
    var fileHandle: FileHandle?
    
    fileprivate var debugLevel = [DebugSpace: DebugLevel]()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    override init() {
        #if DEBUG
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            if let documentsDirectory = paths.first {
                let secsSinceEpoch = String(Int(Date().timeIntervalSince1970))
                let fileName = "\(secsSinceEpoch).log"
                let logFilePath = (documentsDirectory as NSString).appendingPathComponent(fileName)

                FileManager.default.createFile(atPath: logFilePath, contents: nil, attributes: [:])
                fileHandle = FileHandle(forWritingAtPath: logFilePath)
                print("log file path: \(logFilePath)")
            }
        #endif

        super.init()
    }

    func log(_ debugText: String, level: DebugLevel, space: DebugSpace) {
        #if DEBUG
        
        guard isDebugAllowed(level: level, space: space) else {
            return
        }

        let dateString = dateFormatter.string(from:Date())
        let outputTextForLogging = "\(dateString): \(debugText)\n"
        if let data = outputTextForLogging.data(using: .utf8) {
            fileHandle?.write(data)
        }

        var prefix: String = ""
        
        switch level {
        case .error:
            prefix.append("🔥")
        default:
            break
        }
        
        switch space {
        case .mesh:
            prefix.append("🐸🐸🐸")
        default:
            break
        }
        
        print("\(prefix) \(debugText)")
        #endif
    }
    
    private func isDebugAllowed(level requestedLevel: DebugLevel, space: DebugSpace) -> Bool {
        guard let allowedLevel = debugLevel[space] else {
            return false
        }
        return allowedLevel.rawValue <= requestedLevel.rawValue
    }
    
}
