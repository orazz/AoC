import Foundation

public struct Day14 {
    private let input: [String]
    private var answer = 0
    private var b = Set<[Int]>()
    private var maxY = 0

    public init(input: [String]) {
        self.input = input
        self.read()
    }

    public mutating func read() {
        var list = [[Int]]()

        for line in self.input {
            let parts = line.components(separatedBy: " -> ")
            list = parts.map { elem in
                elem.components(separatedBy: ",").map { num in
                    return Int(num)!
                }
            }

            for (x, y) in zip(list, list[1...]) {
                var x1 = x.first!, y1 = x.last!, x2 = y.first!, y2 = y.last!
                (x1, x2) = (min(x1, x2), max(x1, x2))
                (y1, y2) = (min(y1, y2), max(y1, y2))
                for x in x1...x2 {
                    for y in y1...y2 {
                        b.insert([x, y])
                    }
                }
            }
        }
        maxY = b.max { l, r in l[1] < r[1] }![1]
    }

    mutating func simulateSand() -> Bool {
        var x = 500, y = 0
        while y <= maxY {
            if !b.contains([x, y + 1]) {
                y += 1
                continue
            }
            if !b.contains([x-1, y+1]) {
                x -= 1
                y += 1
                continue
            }
            if !b.contains([x+1, y+1]) {
                x += 1
                y += 1
                continue
            }
            b.insert([x, y])
            return true
        }
        return false
    }

    mutating func simulateSand2() -> [Int] {
        var x = 500, y = 0
        if b.contains([x, y]) {
            return [x, y]
        }
        while y <= maxY {
            if !b.contains([x, y + 1]) {
                y += 1
                continue
            }
            if !b.contains([x-1, y+1]) {
                x -= 1
                y += 1
                continue
            }
            if !b.contains([x+1, y+1]) {
                x += 1
                y += 1
                continue
            }
            break
        }
        return [x, y]
    }

    public mutating func part1() -> Int {
        answer = 0
        while true {
            let res = simulateSand()

            if !res {
                break
            }
            answer += 1
        }
        return answer
    }

    public mutating func part2() -> Int {
        while true {
            let res: [Int] = simulateSand2()
            b.insert(res)
            answer += 1

            if res == [500, 0] {
                break
            }
        }
        return answer
    }

    public mutating func result() -> String {
        return "Day14\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
