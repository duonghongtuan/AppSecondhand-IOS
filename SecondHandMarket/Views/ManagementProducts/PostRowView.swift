//
//  PostRowView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 10/06/2022.
//

import SwiftUI

struct PostRowView: View {
    var post: Post
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: post.images[0].imageFromBase64!)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .center)
                .clipped()
            VStack(alignment: .leading){
                Text(post.name)
                    .font(.system(size: 16, weight: .semibold))
                Text("\(post.price.numberToMoney)đ")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .semibold))
                Text(post.address)
                    
            }
            .padding()
            Spacer()
        }
        .background(.white)
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: Post())
    }
}
