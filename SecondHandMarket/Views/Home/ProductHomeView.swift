//
//  ProductHomeView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 07/06/2022.
//

import SwiftUI

struct ProductHomeView: View {
    var post: Post
    @EnvironmentObject var viewModel: ViewModel
    @State var isActive: Bool = false
    var body: some View {
        let length = (Screen.width - 8*3)/2
        NavigationLink(destination:
            ProductDetailView(post: post)
               .environmentObject(viewModel)
               .navigationBarTitleDisplayMode(.inline)
            ,isActive: $isActive
        ){
            VStack(alignment: .leading) {
                Image(uiImage: post.images[0].imageFromBase64!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: length, height: length, alignment: .center)
                    .clipped()

                    VStack(alignment: .leading){
                        Text(post.name)
                            .multilineTextAlignment(.leading)
                            .frame(height: 50,alignment: .top)
                            .lineLimit(2)
                        
                        Text("\(post.price.numberToMoney) đ")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .padding(.horizontal, 4.0)
            }
            .onTapGesture {
                viewModel.getUser(userId: post.userId)
                isActive = true
            }
            .background(.white)
        }
        .navigationTitle("Quay lại")
    }
}

struct ProductHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProductHomeView(post: Post())
    }
}
