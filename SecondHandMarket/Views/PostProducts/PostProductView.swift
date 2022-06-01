//
//  PostProductView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct PostProductView: View {
    @StateObject var viewModel = PostViewModel()
    @State var category: String = ""
    @State var showCategories : Bool = true
    @State var showCompanies : Bool = true
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    viewModel.createProduct()
                }, label: {
                    Text("Đăng sản phẩm")
                        .font(.system(size: 20, weight: .semibold))
                })
            }
            List{
                Button(action: {
                    withAnimation(.easeOut){
                        showCategories.toggle()
                    }
                }, label: {
                    HStack {
                        Text("Mặt hàng: ")
                            .foregroundColor(.black)
                        Text(category)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray1)
                            .rotationEffect(Angle(degrees: showCategories ? 90.0 : 0))
                        
                    }
                })
                if showCategories{
                    ForEach(viewModel.categoris){ category in
                        HStack {
                            Spacer()
                            Text(category.name)
                            Spacer()
                        }.onTapGesture {
                            self.category = category.name
                            withAnimation(.easeOut){
                                showCategories = false
                                viewModel.selectCategory(category: category)
                                showCompanies = true
                            }
                        }
                    }
                }
                if viewModel.product.categoryId != ""{
                    Button(action: {
                        withAnimation(.easeOut){
                            showCompanies.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("Công ty: ")
                                .foregroundColor(.black)
                            Text(viewModel.product.company)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray1)
                                .rotationEffect(Angle(degrees: showCompanies ? 90.0 : 0))
                            
                        }
                    })
                }
                
                if showCompanies{
                    if let companies = viewModel.companies{
                        ForEach(companies, id : \.self){ company in
                            HStack{
                                Spacer()
                                Text(company)
                                Spacer()
                            }
                            .onTapGesture {
                                withAnimation(.easeOut){
                                    showCompanies = false
                                    viewModel.product.company = company
                                }
                            }
                        }
                    }
                }
                if viewModel.product.company != ""{
                    ImagesProductView()
                        .environmentObject(viewModel)
                    CreateProductView()
                        .environmentObject(viewModel)
                }
            
            }
        }
    }
}

struct PostProductView_Previews: PreviewProvider {
    static var previews: some View {
        PostProductView()
    }
}
