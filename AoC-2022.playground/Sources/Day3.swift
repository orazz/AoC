import Foundation

struct Compartment {
    var score: Int = 0

    init(line: String, priorities: [Character]) {
        let index = line.index(line.startIndex, offsetBy: line.count/2)
        let left = line[..<index]
        let right = line[index...]

        for item in left {
            if right.contains(item) {
                score = priorities.firstIndex(of: item)!
            }
        }
    }
}

extension Compartment {
    init(input: [String], priorities: [Character]) {
        var grouped: [[String]] = []
        var i = 0

        while true {
            if input.count <= (i * 3) {
                break
            }
            grouped.append([input[i * 3], input[i * 3 + 1], input[i * 3 + 2]])

            i += 1
        }

        self.score = grouped.map {
            let first = $0[0]
            let second = $0[1]
            let third = $0[2]

            let intersection = first.compactMap {
                if second.contains($0) && third.contains($0) {
                    return $0
                }

                return nil
            }

            return priorities.firstIndex(of: intersection.first!)!
        }.reduce(0, +)
    }
}

public struct Day3 {
    let input: [String]
    let priorities = Array(" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

    public init(input: [String]) {
        self.input = input
    }

    public mutating func part1() -> Int {
        let comp = input.map{ Compartment.init(line: $0, priorities: priorities) }
        let total = comp.map(\.score).reduce(0, +)
        return total
    }

    public mutating func part2() -> Int {
        let comp = Compartment(input: input, priorities: priorities)
        return comp.score
    }

    public mutating func result() -> String {
        return "Day3\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
