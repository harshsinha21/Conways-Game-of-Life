//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//
import ComposableArchitecture
import SwiftUI
import GameOfLife

public struct ConfigurationView: View {
    let store: StoreOf<ConfigurationModel>

    public init(store: StoreOf<ConfigurationModel>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            // Your Problem 3c code goes here.
            NavigationLink(destination: GridEditorView(store: self.store)) {
                ZStack {
                    Color(hue: 0.1, saturation: 0.3, brightness: 0.8).ignoresSafeArea()
                    VStack {
                        HStack {
                            Text(store.configuration.title)
                                .font(.system(size: 26.0))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                        }
                        HStack {
                            Text(store.configuration.shape)
                                .font(.system(size: 15.0))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                    }
                    // your Problem 3C code ends here.
                    .padding()
                    .background(Color(red: 9.9, green: 0.7, blue: 0.9))
                    
                }
            }
        }
    }
}

#Preview {
    ConfigurationView(
        store: StoreOf<ConfigurationModel>(
            initialState: try! .init(
                configuration: .init(
                    title: "Demo",
                    contents: [[1,1]]
                )
            ),
            reducer: ConfigurationModel.init
        )
    )
}
