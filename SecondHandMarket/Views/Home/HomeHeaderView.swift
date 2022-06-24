//
//  HomeHeaderView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 08/06/2022.
//

import SwiftUI

struct HomeHeaderView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var text: String = ""
    var body: some View {
        HStack {
            TextField("Tìm kiếm", text: $text)
                .padding(.vertical, 6)
                .padding(.horizontal, 10.0)
                .background(Color.background)
                .cornerRadius(20)
            Spacer()
            NavigationLink(destination: CartView()
                .environmentObject(viewModel)
                .navigationBarHidden(true)
                , label: {
                Image(systemName: "cart.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 30))
            })
        }
        .padding()
        .background(.white)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
