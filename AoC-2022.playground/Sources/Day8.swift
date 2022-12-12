import Foundation

public struct Day8 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func read() -> [[Int]] {
        var grid: [[Int]] = [[Int]]()
        for line in self.input {
            let row = line.map{ Int(String($0))! }
            grid.append(row)
        }

        return grid
    }

    public mutating func part1() -> Int {
        var visible = 0
        let grid = self.read()
        for r in 0...grid.count-1{
            for c in 0...grid[0].count-1 {
                let k = grid[r][c]
                if !stride(from: 0, to: c, by: 1).map({ grid[r][$0] < k }).contains(false) ||
                    !stride(from: c + 1, to: grid[r].count, by: 1).map({ grid[r][$0] < k }).contains(false) ||
                    !stride(from: 0, to: r, by: 1).map({ grid[$0][c] < k }).contains(false) ||
                    !stride(from: r + 1, to: grid.count, by: 1).map({ grid[$0][c] < k }).contains(false) {
                    visible += 1
                }
            }
        }
        return visible
    }

    public mutating func part2() -> Int {
        var visible = 0
        let grid = self.read()
        for r in 0...grid.count-1 {
            for c in 0...grid[0].count-1 {
                let k = grid[r][c]
                var L = 0, R = 0, U = 0, D = 0

                for x in stride(from: c - 1, to: -1, by: -1) {
                    L += 1
                    if grid[r][x] >= k {
                        break
                    }
                }
                for x in stride(from: c + 1, to: grid[r].count, by: 1) {
                    R += 1
                    if grid[r][x] >= k {
                        break
                    }
                }
                for x in stride(from: r - 1, to: -1, by: -1) {
                    U += 1
                    if grid[x][c] >= k {
                        break
                    }
                }
                for x in stride(from: r + 1, to: grid[r].count, by: 1) {
                    D += 1
                    if grid[x][c] >= k {
                        break
                    }
                }
                let cur = U * D * L * R
                if cur > visible {
                    visible = cur
                }
            }
        }
        return visible
    }

    public mutating func result() -> String {
        return "Day8\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
