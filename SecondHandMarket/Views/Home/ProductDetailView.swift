//
//  ProductDetailView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 09/06/2022.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel : ViewModel
    var post: Post
    @State var showImages: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false ){
                VStack(spacing: 0) {
                    TabView{
                            ForEach(post.images.indices, id: \.self){ i in
                                let imageString = post.images[i]
                                Image(uiImage: imageString.imageFromBase64!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: Screen.width, height: 300)
                                    .clipped()
                                    .onTapGesture {
                                        showImages.toggle()
                                    }
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(width: Screen.width, height: 300)
                    
                    VStack(alignment: .leading){
                        Text(post.name)
                            .font(.system(size: 16, weight: .semibold))
                        Text("\(post.price.numberToMoney) đ")
                            .foregroundColor(.red)
                            .font(.system(size: 16, weight: .semibold))
                        LineView(color: Color.green)
                        Text(post.description)
                        HStack{
                            Image(systemName: "map.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 20))
                            
                            Text(post.address)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                }
                if let user = viewModel.user{
                    HStack{
                        Image(uiImage: user.avatar.imageFromBase64!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70, alignment: .center)
                            .cornerRadius(35)
                        VStack(alignment: .leading){
                            Text(user.name)
                                .foregroundColor(.green)
                            HStack {
                                ForEach(1..<5){_ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 16))
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                }
                VStack{
                    DetailProductView(lable: "Hãng", text: post.company)
                    DetailProductView(lable: "Tìng trạng", text: post.status)
                    DetailProductView(lable: "Kích thước", text: post.screen)
                    DetailProductView(lable: "Bộ nhớ Ram", text: post.ram)
                    DetailProductView(lable: "Bộ nhớ máy", text: post.memory)
                    DetailProductView(lable: "Màu sắc", text: post.color)
                }
                .padding()
                .background(.white)
                .cornerRadius(16)
                .padding()
                
            }
            .background(Color.background)
            .sheet(isPresented: $showImages){
                ImagesView(imageStrings: post.images)
                    .navigationBarHidden(true)
            }
            BottomProductView( post: post)
        }
        .toast(message: "Bạn đã thêm vào giỏ hàng", isShowing: $viewModel.showAddCart, config: .init(textColor: .white,font: .system(size: 18, weight: .semibold),backgroundColor: Color.green,duration: Toast.long), image: nil)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(post: Post())
        BottomProductView(post: Post())
    }
}

struct BottomProductView: View{
    @EnvironmentObject var viewModel : ViewModel
    
    var post: Post
    var body: some View{
        HStack(spacing: 2){
            HStack {
                Spacer()
                ZStack{
                    Image(systemName: "message")
                        .font(.system(size: 25))
                    Text("...")
                        .padding(.bottom)
                }
                Spacer()
            }
            .frame(height: 60)
            .background(Color.blue3)
            HStack {
                Spacer()
                Image(systemName: "cart.fill.badge.plus")
                    .foregroundColor(.green)
                .font(.system(size: 30))
                Spacer()
            }
            .frame(height: 60)
            .background(Color.blue3)
            .onTapGesture {
                viewModel.addToCart(post: post, quantity: 1)
            }
            
            HStack {
                Spacer()
                Text("Mua Ngay")
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }
            .frame(height: 60)
            .background(Color.green1)
        }
    }
}

struct DetailProductView: View{
    var lable: String
    var text: String
    var body: some View{
        VStack {
            HStack{
                Text("\(lable):")
                    .font(.system(size: 16, weight: .semibold))
                Text(text)
                Spacer()
            }
            LineView(color: Color.gray2!)
        }
    }
}
