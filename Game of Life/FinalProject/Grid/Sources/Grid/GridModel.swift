//
//  GridModel.swift
//  Lecture18
//
//  Created by Van Simmons on 11/2/23.
//

import ComposableArchitecture
import GameOfLife

public struct GridModel: Reducer {
    public struct State: Equatable, Codable {
        var lineWidth: Double
        var inset: Double
        public var grid: GameOfLife.Grid
        public var history: GameOfLife.Grid.History
        var fractionComplete: Double = 0.0
        var trigger = false


        public init(
            lineWidth: Double = 2.0,
            inset: Double = 2.0,
            history: Grid.History = Grid.History(),
            grid: GameOfLife.Grid = .init()
        ) {
            self.lineWidth = lineWidth
            self.inset = inset
            self.grid = grid
            self.history = history
            self.history.add(grid)
        }
    }

    public enum Action {
        case step
        case toggle(row: Int, col: Int)
        case changefractionCompleteTo(Double)
        case animate
        case start
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .step:
                    return .none
                case let .toggle(row: row, col: col):
                    state.grid.toggle(row, col)
                    return .none
                case .animate:
                    state.fractionComplete = 1.0
                    state.trigger.toggle()
                    return .run { send in
                        try? await Task.sleep(for: .seconds(20))
                        await send(.changefractionCompleteTo(0.0))
                    }
                case let .changefractionCompleteTo(value):
                    state .fractionComplete = value
                    return .none
                case .start:
                    state.trigger.toggle()
                return .none
            }
        }
    }
}
