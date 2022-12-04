import Foundation

enum LastMove: String {
    case lose = "X"
    case draw = "Y"
    case win = "Z"

    var score: Int {
        switch self {
        case .lose:
            return 0
        case .draw:
            return 3
        case .win:
            return 6
        }
    }
}

enum Move: Int {
    case rock = 1
    case paper = 2
    case scissors = 3

    static func move(_ letter: String) -> Move {
        switch letter {
        case "A", "X":
            return .rock
        case "B", "Y":
            return .paper
        case "C", "Z":
            return .scissors
        default:
            fatalError()
        }
    }
}

extension Move {
    func move(result: LastMove) -> Move {
        switch (self, result) {
            case (.rock, .lose): return .scissors
            case (.rock, .draw): return .rock
            case (.rock, .win): return .paper

            case (.paper, .lose): return .rock
            case (.paper, .draw): return .paper
            case (.paper, .win): return .scissors

            case (.scissors, .lose): return .paper
            case (.scissors, .draw): return .scissors
            case (.scissors, .win): return .rock
        }
    }
}

struct Round {
    let player: Move
    let opponent: Move

    var outcomeScore: Int {
        switch (player, opponent) {
        case (.rock, .paper): return 0
        case (.paper, .rock): return 6
        case (.rock, .scissors): return 6
        case (.scissors, .rock): return 0
        case (.paper, .scissors): return 0
        case (.scissors, .paper): return 6
        default:
            return 3
        }
    }

    var score: Int {
        player.rawValue + outcomeScore
    }

    init(player: Move, opponent: Move) {
        self.player = player
        self.opponent = opponent
    }

    init(line: String) {
        let parts = line.components(separatedBy: " ")
        self.opponent = Move.move(parts[0])
        self.player = Move.move(parts[1])
    }
}

extension Round {
    static func part2(line: String) -> Round {
        let parts = line.components(separatedBy: " ")
        let opponent = Move.move(parts[0])
        let result = LastMove(rawValue: parts[1])!
        let player = opponent.move(result: result)
        return Round(player: player, opponent: opponent)
    }
}

public struct Day2 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    public mutating func part1() -> Int {
        let rounds = input.map(Round.init(line:))
        let total = rounds.map(\.score).reduce(0, +)
        return total
    }

    public mutating func part2() -> Int {
        let rounds = input.map(Round.part2(line:))
        let total = rounds.map(\.score).reduce(0, +)
        return total
    }

    public mutating func result() -> String {
        return "Day2\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
