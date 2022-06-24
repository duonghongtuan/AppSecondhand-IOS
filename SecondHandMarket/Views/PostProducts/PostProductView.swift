//
//  PostpostView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct PostProductView: View {
    @EnvironmentObject var viewModel : PostViewModel
    
    var body: some View {
        VStack {
            ZStack {
                HStack{
                    Text("Tạo bài")
                        .font(.system(size: 18, weight: .semibold))
                }
                HStack{
                    Spacer()
                    Button(action: {
                        viewModel.createPost()
                    }, label: {
                        Text("Đăng")
                            .font(.system(size: 16, weight: .semibold))
                    })
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 2.0)
            .padding(.top, 6.0)
            
            List{
                Button(action: {
                    withAnimation(.easeOut){
                        viewModel.showCategories.toggle()
                    }
                }, label: {
                    HStack {
                        Text("Mặt hàng: ")
                            .foregroundColor(.black)
                        Text(viewModel.category)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray1)
                            .rotationEffect(Angle(degrees: viewModel.showCategories ? 90.0 : 0))
                        
                    }
                })
                if viewModel.showCategories{
                    ForEach(viewModel.categoris){ category in
                        HStack {
                            Spacer()
                            Text(category.name)
                            Spacer()
                        }.onTapGesture {
                            viewModel.category = category.name
                            withAnimation(.easeOut){
                                viewModel.showCategories = false
                                viewModel.selectCategory(category: category)
                                    viewModel.showCompanies = true
                            }
                        }
                    }
                }
                if viewModel.post.categoryId != ""{
                    Button(action: {
                        withAnimation(.easeOut){
                            viewModel.showCompanies.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("Công ty: ")
                                .foregroundColor(.black)
                            Text(viewModel.post.company)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray1)
                                .rotationEffect(Angle(degrees: viewModel.showCompanies ? 90.0 : 0))
                            
                        }
                    })
                }
                
                if viewModel.showCompanies{
                    if let companies = viewModel.companies{
                        ForEach(companies, id : \.self){ company in
                            HStack{
                                Spacer()
                                Text(company)
                                Spacer()
                            }
                            .onTapGesture {
                                withAnimation(.easeOut){
                                    viewModel.showCompanies = false
                                    viewModel.post.company = company
                                }
                            }
                        }
                    }
                }
                if viewModel.post.company != ""{
                    ImagesProductView()
                        .environmentObject(viewModel)
                    CreatePostView()
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
