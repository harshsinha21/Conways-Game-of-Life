//
//  ConfigurationsView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Configuration

public struct ConfigurationsView: View {
    let store: StoreOf<ConfigurationsModel>

    public init(store: StoreOf<ConfigurationsModel>) {
        self.store = store
    }

    public var body: some View {
        // Your problem 3A code starts here.
        NavigationView {
            WithViewStore(store, observe: { $0 }) { store in
                ZStack {
                    Color(red: 1.0, green: 1.0, blue: 0.8).ignoresSafeArea()
                    VStack {
                        List {
                            ForEachStore(
                                self.store.scope(
                                    state: \.configurations,
                                    action: \.configuration
                                ),
                                content: ConfigurationView.init(store:)
                            )
                        }
                        
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                store.send(.fetch)
                            }) {
                                Text("Fetch").font(.system(size: 24.0))
                            }
                            .padding([.top, .bottom], 8.0)
                            
                            Spacer()
                            
                            Button(action: {
                                store.send(.clear)
                            }) {
                                Text("Clear").font(.system(size: 24.0))
                            }
                            .padding([.top, .bottom], 8.0)
                            
                            Spacer()
                        }
                        .padding([.top, .bottom], 8.0)
                    }
                    .navigationBarTitle("Configuration")
                    // Problem 5A goes here
                    .navigationBarItems(trailing: Button("Add") {
                        store.send(.add)
                    })
                    .sheet(isPresented: store.binding(
                        get: \.isAdding,
                        send: ConfigurationsModel.Action.stopAdding(false)
                    )) {
                        // Problem 3B goes here
                        //                .navigationBarTitle("Configuration", displayMode: .inline)
                        // Problem 5B goes here
                        IfLetStore(
                            self.store.scope(
                                state: \.addConfigState,
                                action: ConfigurationsModel.Action.addConfig
                            ),
                            then: AddConfigurationView.init(store:)
                        )
                    }
                }
                // Problem 3A Ends here
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

#Preview {
    let previewState = ConfigurationsModel.State()
    return ConfigurationsView(
        store: Store(
            initialState: previewState,
            reducer: ConfigurationsModel.init
        )
    )
}
