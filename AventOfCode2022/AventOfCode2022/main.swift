//
// Created by Do Vien on 24/12/2022 at 05:11.
//
// Copyright © 2022 CPea2506. All rights reserved.
//

import ArgumentParser

// MARK: - Avent

protocol Avent {
    var day: UInt8 { get }

    init(data: String)
    func part1() -> UInt
    func part2() -> UInt
}

// MARK: - Solution

struct Solution {
    // MARK: Lifecycle

    init?(for eventType: Avent.Type) {
        self.eventType = eventType
    }

    // MARK: Internal

    func getResult(withData data: String) {
        let (event, time) = getTime { eventType.init(data: data) }
        let (part1, time1) = getTime(for: event.part1)
        let (part2, time2) = getTime(for: event.part2)

        print("""
        Solution for day \(event.day)
        collected data in \(time) ms
        part 1: \(part1) in \(time1) ms
        part 2: \(part2) in \(time2) ms
        """)
    }

    // MARK: Private

    private var eventType: Avent.Type
}

// MARK: - AOC2022

struct AOC2022: ParsableCommand {
    // MARK: Internal

    static let configuration = CommandConfiguration(abstract: "Avent of Code 2022")

    func run() throws {
        let mainFile = example ? "example.txt" : "input.txt"

        do {
            let data = try readFileInDay(day, for: mainFile)
            var solution: Solution?

            switch day {
            case 1:
                solution = Solution(for: Day1.self)
            case 2:
                solution = Solution(for: Day2.self)
            case 3:
                solution = Solution(for: Day3.self)
            default:
                print("Info: not yet implemented")
            }

            if let solution {
                solution.getResult(withData: data)
            }
        } catch {
            print("Error loading file: 🌶️ \(error)")
        }
    }

    // MARK: Private

    @Argument(help: "AOC Day")
    private var day: UInt8

    @Flag(name: .shortAndLong, help: "Uses example file provided by AOC")
    private var example: Bool = false

    @Flag(name: .shortAndLong, help: "Gets all solutions for all AOC days")
    private var all: Bool = false
}

// MARK: - AventOfCode2022

AOC2022.main()
