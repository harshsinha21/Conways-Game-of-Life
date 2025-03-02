//
//  AddConfigurationView.swift
//  FinalProject
//

import SwiftUI
import ComposableArchitecture
import Combine
import Theming
import GameOfLife

struct AddConfigurationView: View {
    @Bindable var store: StoreOf<AddConfigModel>

    init(store: StoreOf<AddConfigModel>) {
        self.store = store
    }
    var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ZStack {
                Color(red: 1.0, green: 1.0, blue: 0.8).ignoresSafeArea()
                VStack {
                    VStack {
                        //Problem 5C Goes inside the following HStacks...
                        HStack {
                            Spacer()
                            Text("Title:")
                            TextField("Enter Here",  text: store.binding(get: \.title, send: AddConfigModel.Action.updateTitle))
                                .foregroundColor(Color.black)
                                .padding(.trailing, 8.0)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                        }
                        HStack {
                            //Spacer()
                            
                            Text("Size:")
                                .foregroundColor(Color.black)
                                .padding(.leading, 8.0)
                            Spacer()
                            CounterView(store: self.store.scope(
                                   state: \.counter,
                                   action: AddConfigModel.Action.counter
                               ))
                            

                        }
                    }
                    .padding()
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2.0))
                    .padding(.bottom, 24.0)
                    
                    HStack {
                        Spacer()
                        // Problem 5D - your answer goes in the following buttons
                        ThemedButton(text: "Save") {
                            let gridSize = store.counter.count
                            do {
                                let newConfig = try GameOfLife.Grid.Configuration(
                                    title: store.title,
                                    rows: gridSize,
                                    cols: gridSize
                                )
                                store.send(.ok(newConfig))
                                } catch {
                                    print("Failed to create configuration: \(error)")
                                }
                        }
                        ThemedButton(text: "Cancel") {
                            store.send(.cancel)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.top, 36.0)
                .padding(.horizontal, 24.0)
                .font(.title)
            }
        }
    }
}

#Preview {
    AddConfigurationView(
        store: StoreOf<AddConfigModel>(
            initialState: .init(
                title: "",
                counter: .init(count: 10)
            ),
            reducer: AddConfigModel.init
        )
    )
}
