import Foundation

struct Stack: CustomDebugStringConvertible {
    private var items: [String] = []

    func count() -> Int {
        return items.count
    }

    func first() -> String {
        return items.first!
    }

    mutating func pop() -> String {
        return items.remove(at: 0)
    }

    mutating func push(_ element: String) {
        items.insert(element, at: 0)
    }

    var debugDescription: String {
        return items.joined()
    }
}

struct CrateMove {
    let move: Int
    let from: Int
    let to: Int

    init(line: String) {
        let parts = line.components(separatedBy: " ")
        self.move = Int(parts[1])!
        self.from = Int(parts[3])!-1
        self.to = Int(parts[5])!-1
    }
}

public struct Day5 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func read() -> ([Stack], [CrateMove]) {
        var moves: [CrateMove] = []
        var reversedStacks: [Stack] = [], stacks: [Stack] = []
        var stacksArray: [[String]] = [[String]]()

        for item in self.input {
            if Array(item).count > 1 && Array(item)[1] == "1" {
                break
            }
            let r = item.map{ _ in item.split(by: 4) }
            stacksArray.append(r.first!)
        }

        for stackArray in stacksArray {
            for (index, element) in stackArray.enumerated() {
                if reversedStacks.count <= index {
                    let stack = Stack()
                    reversedStacks.append(stack)
                }
                let trimmed = element.trim()
                if trimmed.count > 0 {
                    reversedStacks[index].push(trimmed)
                }
            }
        }

        for (index, _) in (0...reversedStacks.count - 1).enumerated() {
            stacks.append(Stack())
            while reversedStacks[index].count() > 0 {
                stacks[index].push(reversedStacks[index].pop())
            }
        }

        self.input.forEach { elem in
            if elem.count != 0 && elem[elem.index(elem.startIndex, offsetBy: 0)] == "m" {
                moves.append(CrateMove.init(line: elem))
            }
        }

        return (stacks, moves)
    }

    public mutating func part1() -> String {
        var (stacks, moves) = self.read()

        for move in moves {
            for _ in 1...move.move {
                stacks[move.to].push(stacks[move.from].pop())
            }
        }

        return String(stacks.map { Array($0.first())[1] }).replacingOccurrences(of: ",", with: "")
    }

    public mutating func part2() -> String {
        var (stacks, moves) = self.read()
        for move in moves {
            var tempStack = Stack()
            for _ in 1...move.move {
                tempStack.push(stacks[move.from].pop())
            }
            while tempStack.count() > 0 {
                stacks[move.to].push(tempStack.pop())
            }
        }
        return String(stacks.map { Array($0.first())[1] }).replacingOccurrences(of: ",", with: "")
    }

    public mutating func result() -> String {
        return "Day5\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
