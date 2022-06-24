//
//  LineView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 10/06/2022.
//

import SwiftUI

struct LineView: View {
    var color: Color = Color.gray
    var body: some View {
        HStack{
            Spacer()
            Text("")
        }
        .frame(maxWidth: .infinity, maxHeight: 1)
        .background(color)
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView()
    }
}
