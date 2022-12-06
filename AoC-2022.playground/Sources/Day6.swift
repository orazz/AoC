import Foundation

public struct Day6 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func read(length: Int) -> Int {
        var i: Int = 0
        let buffer = Array(self.input[0])
        var message = Set<Character>()
        var length = length
        let messageLength = length + 1
        while true {
            guard i != buffer.count - 1 else { break }
            message = Set(buffer[i...length])
            if message.count == messageLength { break }
            i += 1
            if length < buffer.count { length += 1 }
        }
        return length+1
    }

    public mutating func part1() -> Int {
        return self.read(length: 3)
    }

    public mutating func part2() -> Int {
        return self.read(length: 13)
    }

    public mutating func result() -> String {
        return "Day6\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
