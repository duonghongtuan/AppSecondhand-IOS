//
//  CreateProductView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/28/22.
//

import SwiftUI

struct CreateProductView: View {
    @EnvironmentObject var viewModel : PostViewModel
    var body: some View {
        VStack(alignment: .leading) {
            EditTextView(lable: "Tên sản phẩm:", text: $viewModel.product.name)
            EditTextView(lable: "Tình trạng sản phẩm", text: $viewModel.product.status)
            EditTextView(lable: "Gía:", text: $viewModel.product.price)
            EditTextView(lable: "Số Lượng:", text: $viewModel.product.total)
            EditTextView(lable: "Dung lượng ram:", text: $viewModel.product.ram)
            EditTextView(lable: "Kích thước màn hinh:", text: $viewModel.product.screen)
            EditTextView(lable: "Bộ nhớ:", text: $viewModel.product.memory)
            EditTextView(lable: "Màu sắc", text: $viewModel.product.color)
            Text("Mô tả sản phẩm:")
            TextEditor(text: $viewModel.product.description)
                .padding(6.0)
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.green, lineWidth: 1)
                    )
                .frame(height: 150)
                
        }
    }
}

struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView()
            .environmentObject(PostViewModel())
    }
}
