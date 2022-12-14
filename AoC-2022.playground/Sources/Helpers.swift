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

public func loadInputAsSubStrings(fileName: String, debugPrint: Bool = false) -> [String] {
    do {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt")
        guard Bundle.main.url(forResource: fileName, withExtension: "txt") != nil else { fatalError() }
        let data = try String(contentsOf: fileURL!, encoding: .utf8)
        var lines = data.split(separator: "\n\n").map { String($0) }
        if debugPrint { print(lines) }
        return lines
    } catch {
        print(error)
        return []
    }
}

public func valueForChar(char: Character) -> Int {
    if char.isLowercase {
        return Int(char.asciiValue!) - 96
    }
    return Int(char.asciiValue!) - 38
}

public extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }

    func lastIndexOfCharacter(_ c: Character) -> Int? {
        guard let index = range(of: String(c), options: .backwards)?.lowerBound else
        { return nil }
        return distance(from: startIndex, to: index)
    }

    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }

    func splitList(separator: String = " ", shouldTrimWhitespacesAndNewlines: Bool) -> [String] {
        let copySelf = shouldTrimWhitespacesAndNewlines
        ? trimmingCharacters(in: .whitespacesAndNewlines)
        : self
        return copySelf
            .components(separatedBy: separator)
            .map {
                $0.trimmingCharacters(in: .whitespaces)
            }
    }
    
    @discardableResult
    mutating func consumeFirst(_ charactersCount: Int = 1) -> String? {
        guard count >= charactersCount else { return nil }
        let array = Array(self)
        let temp = String(array[0 ..< charactersCount])
        removeFirst(charactersCount)
        return temp
    }

    func splitParagraphs(shouldTrimWhitespacesAndNewlines: Bool) -> [String] {
        let copySelf = shouldTrimWhitespacesAndNewlines
            ? trimmingCharacters(in: .whitespacesAndNewlines)
            : self
        return copySelf.components(separatedBy: "\n\n")
    }
}

extension Array where Element == String {
    mutating func popFirst() -> Element? {
        guard !isEmpty else { return nil }
        return removeFirst()
    }
}

extension Array where Element: Collection {
    func dropEmpty() -> [Element] {
        filter { !$0.isEmpty }
    }
}
