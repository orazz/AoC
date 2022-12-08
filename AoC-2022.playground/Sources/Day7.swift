import Foundation

class Dir {
    var name: String
    weak var parent: Dir?
    var size: Int?
    var dirs: [Dir]

    init(name: String, parent: Dir? = nil, dirs: [Dir] = [], size: Int? = nil) {
        self.name = name
        self.parent = parent
        self.size = size
        self.dirs = dirs
    }

    func push(_ dir: Dir) {
        dir.parent = self
        self.dirs.append(dir)
    }

    lazy var dirSize: Int = {
        size ?? 0 + dirs.map{ $0.dirSize }.reduce(0, +)
    }()

    var directories: [Dir] {
        let dirs = dirs.filter { $0.size == nil }
        return dirs + dirs.flatMap(\.directories)
    }
}

extension Dir {
    func subdirsUnderSize(_ maxSize: Int) -> [Dir] {
        guard self.size == nil else { return [] }
        if dirSize <= maxSize {
            return [self] + dirs.flatMap { $0.subdirsUnderSize(maxSize)}
        } else {
            return dirs.flatMap { $0.subdirsUnderSize(maxSize) }
        }
    }
}

public struct Day7 {
    let input: [String]

    public init(input: [String]) {
        self.input = input
    }

    func read() -> Dir {
        let root: Dir = Dir(name: "/")
        var current: Dir? = root

        for line in self.input.dropFirst() {
            if line.hasPrefix("$") {
                let parts = line.split(separator: " ")
                switch parts[1] {
                case "cd":
                    switch parts[2] {
                    case "/":
                        current = root
                    case "..":
                        current = current?.parent
                    default:
                        guard let nextNode = current?.dirs.first(where: { $0.name == parts[2] }) else { fatalError() }
                        current = nextNode
                    }
                default:
                    continue
                }
            } else {
                let parts = line.components(separatedBy: " ")
                if let size = Int(parts[0]) {
                    let dir = Dir(name: parts[1], size: size)
                    current?.push(dir)
                } else if parts[0] == "dir" {
                    let dir = Dir(name: String(parts[1]))
                    current?.push(dir)
                }
            }
        }
        return root
    }

    public mutating func part1() -> Int {
        return self.read().subdirsUnderSize(100000).map{ $0.dirSize }.reduce(0, +)
    }

    public mutating func part2() -> Int {
        let root = self.read()
        let dirSize = root.dirSize
        let freeSpace = 70000000 - dirSize
        let spaceToDelete = 30000000 - freeSpace
        let dirs = root.directories.sorted(by: { $0.dirSize < $1.dirSize })
        return dirs.first(where: { $0.dirSize > spaceToDelete})!.dirSize
    }

    public mutating func result() -> String {
        return "Day7\npart 1: \(self.part1())\npart 2: \(self.part2())\n"
    }
}
