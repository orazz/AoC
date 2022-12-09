import Foundation

public struct PairKey: Hashable {
    let first: Int
    let second: Int

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.first)
        hasher.combine(self.second)
    }

    public static func ==(lhs: PairKey, rhs: PairKey) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }
}

public struct RopeBridge {

    let dx: Int
    let dy: Int
    let amount: Int
    let directions = [
        "R": [1, 0],
        "U": [0, 1],
        "L": [-1, 0],
        "D": [0, -1]
    ]

    init(line: String) {
        let parts = line.components(separatedBy: " ")
        amount = Int(parts[1])!
        dx = directions[parts[0]]!.first!
        dy = directions[parts[0]]!.last!
    }

    func touching(x1: Int, y1: Int, x2: Int, y2: Int) -> Bool {
        return abs(x1-x2) <= 1 && abs(y1-y2) <= 1
    }

    public func move(hx: Int, hy: Int, tx: inout Int, ty: inout Int) {
        if !self.touching(x1: hx, y1: hy, x2: tx, y2: ty) {
            tx += hx == tx ? 0 : (hx - tx) / abs(hx - tx)
            ty += hy == ty ? 0 : (hy - ty) / abs(hy - ty)
        }
    }
}

public struct Day9 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    public mutating func part1() -> Int {
        var hx = 0, hy = 0
        var tx = 0, ty = 0
        var tailVisited = Set<PairKey>()
        tailVisited.insert(PairKey(first: tx, second: ty))
        for line in self.input {
            let rope = RopeBridge.init(line: line)
            for _ in 0..<rope.amount {
                hx += rope.dx
                hy += rope.dy
                rope.move(hx: hx, hy: hy, tx: &tx, ty: &ty)
                tailVisited.insert(PairKey(first: tx, second: ty))
            }
        }
        return tailVisited.count
    }

    public mutating func part2() -> Int {
        var hx = 0, hy = 0
        var tx = 0, ty = 0
        var tailVisited = Set<PairKey>()
        var knots = Array(repeating: [0, 0], count: 10)
        tailVisited.insert(PairKey(first: knots.last!.first!, second: knots.last!.last!))

        for line in self.input {
            let rope = RopeBridge.init(line: line)
            for _ in 0..<rope.amount {
                knots[0][0] += rope.dx
                knots[0][1] += rope.dy

                for i in 1..<10 {
                    hx = knots[i - 1].first!
                    hy = knots[i - 1].last!
                    tx = knots[i].first!
                    ty = knots[i].last!
                    rope.move(hx: hx, hy: hy, tx: &tx, ty: &ty)
                    knots[i] = [tx, ty]
                }
                tailVisited.insert(PairKey(first: knots.last!.first!, second: knots.last!.last!))
            }
        }
        return tailVisited.count
    }

    public mutating func result() -> String {
        return "Day9\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
