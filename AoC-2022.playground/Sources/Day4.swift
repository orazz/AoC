import Foundation

public struct Day4 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func calc() -> [[Int]] {
        var items: [[Int]] = []
        self.input.forEach {
            let parts = $0.components(separatedBy: ",")
            let left = parts[0].components(separatedBy: "-")
            let right = parts[1].components(separatedBy: "-")
            items.append([Int(left[0])!, Int(left[1])!, Int(right[0])!, Int(right[1])!])
        }
        return items
    }

    public mutating func part1() -> Int {
        return self.calc().map {
            if $0[0] >= $0[2] && $0[1] <= $0[3] || $0[0] <= $0[2] && $0[1] >= $0[3]  {
                return 1
            }
            return 0
        }.reduce(0, +)
    }

    public mutating func part2() -> Int {
        let items = self.calc()
        return items.map {
            let (x1, x2) = ($0[0], $0[1])
            let (y1, y2) = ($0[2], $0[3])

            if (x1 <= y2 && x2 >= y1) || (y1 < x2 && y2 >= x1) {
                return 1
            }
            return 0
        }.reduce(0, +)
    }

    public mutating func result() -> String {
        return "Day4\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
