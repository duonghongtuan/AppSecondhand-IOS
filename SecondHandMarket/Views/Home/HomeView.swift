//
//  HomeView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel : ViewModel
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    @State var isActive : Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HomeHeaderView()
            FreshScrollView{
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.posts){post in
                        
                            ProductHomeView(post: post)
                               
                    }
                }
            }action: {
                viewModel.getAllPost()
            }
            .padding(.horizontal, 8.0)
            .background(Color.background)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
