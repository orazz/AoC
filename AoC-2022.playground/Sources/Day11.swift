import Foundation

struct Monkey {
    enum Operand: String {
        case add = "+"
        case multiply = "*"
    }

    var startingItems: [Int]
    let operation: Operand
    let operandByAmount: Int?
    let divisible: Int
    let trueMoveToMonkey: Int
    let falseMoveToMonkey: Int
    var inspected: Int = 0

    init(text: String) {
        let lines = text.split(separator: "\n")
        // Parse starting items
        let startingItemsString = lines[1].split(separator: ": ")[1]
        self.startingItems = startingItemsString.split(separator: ", ").map { Int($0)! }
        // Parse operation
        let operationParts = lines[2].split(separator: ": ")[1].components(separatedBy: " ")
        self.operation = Operand(rawValue: operationParts[3])!
        self.operandByAmount = Int(operationParts[4])
        // Parse test
        self.divisible = Int(String(lines[3].split(separator: ": ")[1]).components(separatedBy: " ")[2])!
        // Parse true action
        self.trueMoveToMonkey = Int(String(lines[4].split(separator: ": ")[1]).components(separatedBy: " ")[3])!
        // Parse false action
        self.falseMoveToMonkey = Int(String(lines[5].split(separator: ": ")[1]).components(separatedBy: " ")[3])!
    }
}

public struct Day11 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func read() -> [Monkey] {
        var monkeys = [Monkey]()
        var monkeyLines = ""
        for line in self.input {
            if (line != "") {
                monkeyLines += "\(line)\n"
            } else {
                let monkey = Monkey(text: monkeyLines)
                monkeyLines = ""
                monkeys.append(monkey)
            }
        }
        return monkeys
    }

    public mutating func part1() -> Int {
        var monkeys = self.read()
        var roundCount = 0
        while true {
            for (i, monkey) in monkeys.enumerated() {
                for item in monkeys[i].startingItems {
                    var worryLevel = 0
                    switch monkey.operation {
                    case Monkey.Operand.add:
                        worryLevel = (item + (monkey.operandByAmount == nil ? item : monkey.operandByAmount!)) / 3
                    case Monkey.Operand.multiply:
                        worryLevel = (item * (monkey.operandByAmount == nil ? item : monkey.operandByAmount!)) / 3
                    }
                    if worryLevel % monkey.divisible == 0 {
                        monkeys[monkey.trueMoveToMonkey].startingItems.append(worryLevel)
                    } else {
                        monkeys[monkey.falseMoveToMonkey].startingItems.append(worryLevel)
                    }
                    monkeys[i].startingItems.removeFirst()
                    monkeys[i].inspected += 1
                }
            }
            roundCount+=1
            if roundCount == 20 {
                break
            }

        }
        monkeys = monkeys.sorted(by: { $0.inspected > $1.inspected })
        return (monkeys[0].inspected * monkeys[1].inspected)
    }

    public mutating func part2() -> Int {
        var monkeys = self.read()
        let manager = monkeys.map(\.divisible).reduce(1, *)
        var roundCount = 0
        while true {
            for (i, monkey) in monkeys.enumerated() {
                for item in monkeys[i].startingItems {
                    var worryLevel = 0
                    switch monkey.operation {
                    case Monkey.Operand.add:
                        worryLevel = (item + (monkey.operandByAmount == nil ? item : monkey.operandByAmount!)) % manager
                    case Monkey.Operand.multiply:
                        worryLevel = (item * (monkey.operandByAmount == nil ? item : monkey.operandByAmount!)) % manager
                    }
                    if worryLevel % monkey.divisible == 0 {
                        monkeys[monkey.trueMoveToMonkey].startingItems.append(worryLevel)
                    } else {
                        monkeys[monkey.falseMoveToMonkey].startingItems.append(worryLevel)
                    }
                    monkeys[i].startingItems.removeFirst()
                    monkeys[i].inspected += 1
                }
            }
            roundCount+=1
            if roundCount == 10000 {
                break
            }

        }
        monkeys = monkeys.sorted(by: { $0.inspected > $1.inspected })
        return (monkeys[0].inspected * monkeys[1].inspected)
    }

    public mutating func result() -> String {
        return "Day11\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
