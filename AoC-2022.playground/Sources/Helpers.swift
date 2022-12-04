import Foundation

public func loadInputAsStrings(fileName: String, debugPrint: Bool = false) -> [String] {
    do {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt")
        guard Bundle.main.url(forResource: fileName, withExtension: "txt") != nil else { fatalError() }
        let data = try String(contentsOf: fileURL!, encoding: .utf8)
        var lines = data.components(separatedBy: .newlines)
        if lines.last == "" {
            lines.removeLast()
        }
        if debugPrint { print(lines) }
        return lines
    } catch {
        print(error)
        return []
    }
}
