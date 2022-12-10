import Foundation

public struct Day10 {
    enum Command: String {
        case addx
        case noop
    }

    let input: [String]
    var index: Int = 1, x = 1
    var sum = 0
    var row = ""
    var crt: [String] = [String]()

    public init(input: [String]) {
        self.input = input
        self.read()
    }

    mutating func read() {
        for line in self.input {
            let parts = line.components(separatedBy: " ")
            switch parts[0] {
                case Command.addx.rawValue:
                    self.addSum()
                    self.addSum()
                    x += Int(parts[1])!
                case Command.noop.rawValue:
                    self.addSum()
                default:
                    break
            }
        }
    }

    mutating func addSum() {
        if [20, 60, 100, 140, 180, 220].contains(index) {
            sum += (index * x)
        }
        if (index - 1) % 40 == 0 {
            crt.append(row)
            row = ""
        }
        let sprite = (index - 1) % 40
        row.append(sprite >= x - 1 && sprite <= x + 1 ? "█" : ".")
        self.index += 1
    }

    public mutating func part1() -> Int {
        return sum
    }

    public mutating func part2() -> String {
        return crt.joined(separator: "\n")
    }

    public mutating func result() -> String {
        return "Day10\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
