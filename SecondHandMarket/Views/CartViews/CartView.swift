//
//  CartView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 23/06/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text("Giỏ hàng")
                        .font(.title2)
                    Spacer()
                    
                }
                BackNavigationView()
            }
            
            ScrollView{
                if viewModel.carts.isEmpty{
                    Text("Bạn chưa thêm sản phẩm vào giỏ hàng")
                        .font(.title2)
                        .padding()
                }else{
                    ForEach(viewModel.carts){ cart in
                        ItemRow(cart: cart)
                            .swipeActions(content: {
                                Button(action: {
                                    viewModel.deleteCart(id: cart.id)
                                }, label: {
                                    Image(systemName: "trash.fill")
                                })
                            })
                    }
                }
            }
            .background(Color.background)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct ItemRow: View{
    @EnvironmentObject var viewModel: ViewModel
    var cart: Cart
    @State var check: Bool = false
    
    var body: some View{
        let post = viewModel.getPost(postId: cart.productId)
        HStack(spacing: 0.0){
            if check{
                Image(systemName: "checkmark.square")
                    .padding(.trailing)
            }else{
                Image(systemName: "square")
                    .padding(.trailing)
            }
            if let post = post {
                Image(uiImage: post.images[0].imageFromBase64!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80, alignment: .center)
                    .clipped()
                VStack(alignment: .leading, spacing: 10.0){
                    Text(post.name)
                        .font(.system(size: 16, weight: .semibold))
                        .multilineTextAlignment(.leading)
                    Text("\(post.price.numberToMoney)đ")
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal)
            }
            Spacer()
            HStack{
                Image(systemName: "minus.square")
                Spacer()
                Text("\(cart.quantity)")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Image(systemName: "plus.app")

            }
            .frame(width: 100)
            
            
            
        }
        .padding()
        .background(.white)
    }
}
