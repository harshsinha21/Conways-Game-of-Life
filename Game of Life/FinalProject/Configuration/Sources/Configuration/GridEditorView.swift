//
//  GridEditorView.swift
//  GameOfLife
//

import Foundation
import SwiftUI
import ComposableArchitecture
import GameOfLife
import Grid
import Theming


private func shorten(to g: GeometryProxy, by: CGFloat = 0.92) -> CGFloat {
    min(min(g.size.width, g.size.height) * by, g.size.height - 120.0)
}

public struct GridEditorView: View {
    @Bindable var store: StoreOf<ConfigurationModel>

    public init(store: StoreOf<ConfigurationModel>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                Spacer()
                // Problem 4A - your code goes here
                GridView(
                    store: self.store.scope(
                    state: \.grid,
                    action: \.grid
                    ))
//                    configuration: GridView.Configuration.init(
//                        inset: store.grid.current.size.cols > 40 ? 0.0 : 2.0,
//                        lineWidth:
//                            store.grid.current.size.cols > 40 ? 0.0 : 2.0
//                        ))
                self.themedButton
                Spacer()
            }
            .background(Color(red: 1.0, green: 1.0, blue: 0.8))
            .navigationBarTitle(store.configuration.title)
            .navigationBarHidden(false)
            .frame(alignment: .center)
        }
    }
}

// MARK: Subviews
extension GridEditorView {
    var themedButton: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ThemedButton(text: "Simulate") {
                // Problem 4B - your code goes here
                let currentGridConfiguration = self.store.grid.grid
                self.store.send(.simulate(currentGridConfiguration))
            }
        }
    }
}

#Preview {
    let grid = Grid(10, 10, Grid.Initializers.random)
    let previewState = ConfigurationModel.State(
        configuration: try! .init(
            title: "Example",
            contents: grid.contents
        ),
        grid: .init(grid: grid),
        index: 0
    )

    return GridEditorView(
        store: Store(
            initialState: previewState,
            reducer: ConfigurationModel.init
        )
    )
}
