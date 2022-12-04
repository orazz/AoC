import Foundation

public struct Day1 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func calc() -> [Int] {
        var items: [Int] = []
        var sum = 0
        input.forEach {
            if $0 == "" {
                items.append(sum)
                sum = 0
            }
            sum += Int($0) ?? 0
        }
        return items.sorted()
    }

    public mutating func part1() -> Int {
        return calc().last!
    }

    public mutating func part2() -> [Int] {
        let items = calc()
        return [items[items.count - 1], items[items.count - 2], items[items.count - 3]]
    }

    public mutating func result() -> String {
        return "Day1\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
