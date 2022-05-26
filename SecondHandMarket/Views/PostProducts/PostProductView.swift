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
    var body: some View {
        List{
            Button(action: {
                
            }, label: {
                Text("Mặt hàng")
            })
            
            
                ForEach(viewModel.categoris){
                    Text($0.name)
                }
            
        }
        .navigationTitle("Quay lại")
    }
}

struct PostProductView_Previews: PreviewProvider {
    static var previews: some View {
        PostProductView()
    }
}
