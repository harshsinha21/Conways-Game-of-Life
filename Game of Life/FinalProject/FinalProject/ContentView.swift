//
//  ContentView.swift
//  SwiftUIGameOfLife
//

import SwiftUI
import ComposableArchitecture
import Simulation
import Configurations
import Statistics
import Theming

struct ContentView: View {
    @Bindable var store: StoreOf<ApplicationModel>

    var body: some View {
        TabView(selection: $store.selectedTab.sending(\.setSelectedTab)) {
            self.simulationView()
                .tag(ApplicationModel.Tab.simulation)
            self.configurationsView()
                .tag(ApplicationModel.Tab.configuration)
            self.statisticsView()
                .tag(ApplicationModel.Tab.statistics)
        }
        .accentColor(Color("accent", bundle: Theming.bundle))
        
    }

    private func simulationView() -> some View {
        SimulationView(
            store: self.store.scope(
                state: \.simulation,
                action: \.simulation
            )
        )
        .tabItem {
            Image(systemName: "play.circle")
            Text("Simulation")
        }
    }

    private func configurationsView() -> some View {
        ConfigurationsView(
            store: self.store.scope(
                state: \.configurations,
                action: \.configurations
            )
        )
        .tabItem {
            Image(systemName: "slider.horizontal.3")
            Text("Configuration")
        }
    }

    private func statisticsView() -> some View {
        StatisticsView(
            store: store.scope(
                state: \.statistics,
                action: \.statistics
            )
        )
        .tabItem {
            Image(systemName: "chart.bar")
            Text("Statistics")
        }
    }
}

#Preview {
    let previewState = ApplicationModel.State()
    ContentView(
        store: Store(
            initialState: previewState,
            reducer: ApplicationModel.init
        )
    )
}
