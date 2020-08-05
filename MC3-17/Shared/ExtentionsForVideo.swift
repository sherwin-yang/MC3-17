


import UIKit

extension UIViewController{
    func fetchURLPath() -> Array<URL>{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let contentPath = documentDirectory?.appendingPathComponent("/Content")
        let directoryContent = try! FileManager.default.contentsOfDirectory(at: contentPath!, includingPropertiesForKeys: nil, options: [])
        return directoryContent
    }

    func createContentFolder() {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        if let documentDirectory = documentDirectories {
            let contentDirectoryPath = documentDirectory.appending("/Content")
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: contentDirectoryPath) {
                do {
                    try fileManager.createDirectory(atPath: contentDirectoryPath,
                                                    withIntermediateDirectories: false,
                                                    attributes: nil)
                } catch {
                    print("Ga bisa create document directory karena \(error)")
                }
            }
        }
    }
    
    func filePath(_ filename: String) -> String {
        createContentFolder()
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as String
        let filePath : String = "\(documentDirectory)/Content/\(filename).mp4"
        return filePath
    }
    
}
