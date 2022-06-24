//
//  CreatepostView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/28/22.
//

import SwiftUI

struct CreatePostView: View {
    @EnvironmentObject var viewModel : PostViewModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack{
                EditTextView(lable: "Tên sản phẩm:", text: $viewModel.post.name)
                EditTextView(lable: "Tình trạng sản phẩm", text: $viewModel.post.status)
                EditTextView(lable: "Gía:", text: $viewModel.post.price)
                EditTextView(lable: "Số Lượng:", text: $viewModel.post.total)
                EditTextView(lable: "Dung lượng ram:", text: $viewModel.post.ram)
                EditTextView(lable: "Kích thước màn hinh:", text: $viewModel.post.screen)
                EditTextView(lable: "Bộ nhớ:", text: $viewModel.post.memory)
                EditTextView(lable: "Màu sắc", text: $viewModel.post.color)
                EditTextView(lable: "Địa chỉ", text: $viewModel.post.address)
            }
            Text("Mô tả sản phẩm:")
            TextEditor(text: $viewModel.post.description)
                .padding(6.0)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.green, lineWidth: 1)
                    )
                .frame(height: 150)
                
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environmentObject(PostViewModel())
    }
}
