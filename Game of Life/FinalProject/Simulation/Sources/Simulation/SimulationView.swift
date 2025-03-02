//
//  SimulationView.swift
//  SwiftUIGameOfLife
//
import SwiftUI
import ComposableArchitecture
import Grid
import Theming

public struct SimulationView: View {
    let store: StoreOf<SimulationModel>

    public init(store: StoreOf<SimulationModel>) {
        self.store = store
    }

    public var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { store in
                VStack {
                    GeometryReader { g in
                        if g.size.width < g.size.height {
                            self.verticalContent(for: store, geometry: g)
                        } else {
                            self.horizontalContent(for: store, geometry: g)
                        }
                    }
                }
                .navigationBarTitle("Simulation")
                .navigationBarHidden(false)
                // Problem 6A - your answer goes here.
                .onAppear {
                    store.send(.startTimer)
                }
                .onDisappear {
                    store.send(.stopTimer)
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func verticalContent(
        for store: ViewStoreOf<SimulationModel>,
        geometry g: GeometryProxy
    ) -> some View {
        ZStack {
            Color(red: 4.0, green: 0.7, blue: 0.9).ignoresSafeArea()
            VStack {
                
                InstrumentationView(
                    store: self.store,
                    width: g.size.width * 0.82
                )
                .frame(height: g.size.height * 0.35)
                .padding(.bottom, 16.0)
                
                Divider()
                
                GridView(
                    store: self.store.scope(
                        state: \.grid,
                        action: \.grid
                    )
                )
            }
        }
    }

    func horizontalContent(
        for store: ViewStoreOf<SimulationModel>,
        geometry g: GeometryProxy
    ) -> some View {
        HStack {
            Spacer()
            InstrumentationView(store: self.store)
            Spacer()
            Divider()
            GridView(
                store: self.store.scope(
                    state: \.grid,
                    action: \.grid
                )
            )
            .frame(width: g.size.height)
            Spacer()
        }
    }
}

#Preview {
    let previewState = SimulationModel.State()
    SimulationView(
        store: Store(
            initialState: previewState,
            reducer: SimulationModel.init
        )
    )
}
