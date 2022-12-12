import Foundation

struct Point {
    let position: [Int]
    let distance: Int
}

public struct Day12 {
    private let input: [String]
    private var grid: [[Character]] = [[Character]]()
    private var start: Point = Point(position: [0, 0], distance: 0)
    private var start2: [Point] = []
    private var endPoint: Point = Point(position: [0, 0], distance: 0)
    private var visited: Set<[Int]> = []

    public init(input: [String]) {
        self.input = input
        self.read()
    }

    mutating func read() {
        for (i, line) in self.input.enumerated() {
            let line = Array(line)
            grid.append([])
            for j in 0..<self.input[0].count {
                if line[j] == "S" {
                    start = Point(position: [i, j], distance: 0)
                    grid[i].append("a")
                } else if line[j] == "E" {
                    endPoint = Point(position: [i, j], distance: 0)
                    grid[i].append("z")
                } else {
                    grid[i].append(line[j])
                    if grid[i][j] == "a" {
                        start2.append(Point(position: [i, j], distance: 0))
                    }
                }
            }
        }
    }

    mutating func shortestPath(startPoint: Point) -> Int {
        var starts: [Point] = []
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        starts.append(startPoint)

        while !starts.isEmpty {
            let point = starts.removeFirst()
            if point.position == endPoint.position {
                return point.distance
            }
            if visited.contains(point.position) {
                continue
            }
            visited.insert(point.position)

            for direction in directions {
                if (0 <= point.position[0] + direction.0 && point.position[0] + direction.0 < grid.count &&
                    0 <= point.position[1] + direction.1 && point.position[1] + direction.1 < grid[0].count &&
                    (valueForChar(char: grid[point.position[0] + direction.0][point.position[1] + direction.1])
                     - valueForChar(char: grid[point.position[0]][point.position[1]])) <= 1) {
                    starts.append(
                        Point(position: [point.position[0] + direction.0, point.position[1] + direction.1], distance: point.distance + 1)
                    )
                }
            }
        }

        return grid.count * grid.count
    }

    public mutating func part1() -> Int {
        return self.shortestPath(startPoint: start)
    }

    public mutating func part2() -> Int {
        var distances: [Int] = []
        start2.forEach { elem in
            visited = []
            distances.append(shortestPath(startPoint: elem))
        }
        return distances.min()!
    }

    public mutating func result() -> String {
        return "Day12\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
