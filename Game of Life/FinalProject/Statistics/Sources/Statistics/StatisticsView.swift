//
//  StatisticsView.swift
//  SwiftUIGameOfLife
//
import SwiftUI
import ComposableArchitecture
import Theming

public struct StatisticsView: View {
    let store: StoreOf<StatisticsModel>

    public init(store: StoreOf<StatisticsModel>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1.0, green: 0.8, blue: 0.5).ignoresSafeArea()
                VStack {
                    VStack {
                        Form {
                            // Your Problem 7A code starts here
                            WithViewStore(store, observe: { $0 }) { store in
                                    FormLine(title: "Steps", value: store.statistics.steps)
                                    FormLine(title: "Alive", value: store.statistics.alive)
                                    FormLine(title: "Born", value: store.statistics.born)
                                    FormLine(title: "Died", value: store.statistics.died)
                                    FormLine(title: "Empty", value: store.statistics.empty)
                                }
                        }
                        ThemedButton(text: "Reset") {
                            self.store.send(.reset)
                        }
                    }
                    .padding(.bottom, 24.0)
                    .scrollContentBackground(.hidden)
                }
                .navigationBarTitle(Text("Statistics"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

#Preview {
    let previewState = StatisticsModel.State()
    return StatisticsView(
        store: Store(
            initialState: previewState,
            reducer: StatisticsModel.init
        )
    )
}
