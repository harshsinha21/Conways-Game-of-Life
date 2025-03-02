//
//  ThemedButton.swift
//  SwiftUIGameOfLife
//

import SwiftUI

public struct ThemedButton: View {
    public var text: String
    public var action: () -> Void

    public init(
        text: String,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
    }

    public var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(text)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 78.0, height: 40.0)
                    .background(Color("accent", bundle: Theming.bundle))
                    .clipShape(Capsule())
            }
            // Your Problem 2 code goes here.
            .overlay(Capsule().stroke(Color("accent", bundle: Theming.bundle), lineWidth: 0.0))
            .shadow(radius: 2.0)
            Spacer()
        }
    }
}

// MARK: Previews
#Preview {
    ThemedButton(text: "Step") { }
        .background(Color("accent", bundle: Theming.bundle))
}
