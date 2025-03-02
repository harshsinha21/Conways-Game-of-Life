//
//  FormLine.swift
//
//

import SwiftUI
import Theming

struct FormLine: View {
    var title: String
    var value: Int

    var body: some View {
        Section(
            header: Text("\(title)")
                .font(.title3)
                .bold()
                .foregroundColor(.black)
        ) {
            Text( "\(value)" )
            // Problem 7B code goes here.
                .font(.system(.title, design: .monospaced))
                .foregroundColor(Color("accent", bundle: Theming.bundle))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    Form {
        FormLine(
            title: "A",
            value: 20000
        )
    }
}
