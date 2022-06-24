//
//  BackNavigationView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct BackNavigationView: View {
    var color : Color = Color.black
    var backgroundColor: Color = Color.white
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .font(.system(size: 20.0))
                .padding()
                .background(backgroundColor)
        }
        .onTapGesture {
            self.mode.wrappedValue.dismiss()
        }
        
    }
}

struct BackNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BackNavigationView()
    }
}
