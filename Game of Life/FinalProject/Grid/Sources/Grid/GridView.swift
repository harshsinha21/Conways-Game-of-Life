//
//  GridView.swift
//  Lecture15
//
//  Created by Van Simmons on 10/24/23.
//

import ComposableArchitecture
import GameOfLife
import SwiftUI
import Theming

public struct GridView: View {
    @Bindable var store: StoreOf<GridModel>

    public init(store: StoreOf<GridModel>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            GeometryReader { outer in
                ZStack {
                    GridLines(
                        rows: store.grid.size.rows,
                        cols: store.grid.size.cols,
                        lineWidth: store.lineWidth
                    )
                    GridCells(
                        rows: store.grid.size.rows,
                        cols: store.grid.size.cols,
                        lineWidth: store.lineWidth,
                        inset: store.inset,
                        states: store.grid
                    )
                    .rotationEffect(.degrees(store.trigger ? 180 : 0))
                    .animation(.easeInOut(duration: 2.0), value: store.trigger)
                    Color(store.trigger ? .blue : .clear)
                      .opacity(0.2)
                      .animation(.easeInOut(duration: 2.0), value: store.trigger)
                    GridTouchView(
                        store: store
                    )
                }
            }
            .aspectRatio(1.0, contentMode: .fit)
            .padding(store.lineWidth / 2.0)
            .background(Color("gridBackground", bundle: Theming.bundle))
            .clipped()
            .padding(4.0)
            .padding(20.0)
        }
    }
}

#Preview {
    let rows = 5
    let cols = 5
    let lineWidth = 16.0
    let inset = 8.0

    return GridView(
        store: .init(
            initialState: .init(
                lineWidth: lineWidth,
                inset: inset,
                grid: .init(rows, cols, Grid.Initializers.random)
            ),
            reducer: GridModel.init
        )
    )
}
