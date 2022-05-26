//
//  TabRowView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import SwiftUI

struct TabRowView: View {
    var title : String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray1)
        }
        .background(.white)
    }
}

struct TabRowView_Previews: PreviewProvider {
    static var previews: some View {
        TabRowView(title: "okkkkkkk")
    }
}
