//
//  ManagementView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct ManagementView: View {
    @StateObject var viewModel = ManagerPostViewModel()
    var body: some View {
        VStack(spacing: 0) {
            FreshScrollView{
                if viewModel.posts.isEmpty{
                    ActivityIndicator(isAnimating: $viewModel.load, style: .large)
                        
                }else{
                    ForEach(viewModel.posts){ post in
                        PostRowView(post: post)
                    }
                }
                
            }action: {
                viewModel.getPostOfUser()
            }
        }
        .background(Color.background)
    }
}

struct ManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ManagementView()
    }
}
