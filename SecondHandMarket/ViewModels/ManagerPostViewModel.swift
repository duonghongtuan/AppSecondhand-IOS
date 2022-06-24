//
//  ManagerPostViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 10/06/2022.
//

import Foundation

class ManagerPostViewModel: ObservableObject{
    @Published var posts = [Post]()
    @Published var load = true
    init(){
        getPostOfUser()
    }
    
    func getPostOfUser(){
        let coreData = CoreDataManager()
        let users = coreData.getUser()
        if !users.isEmpty {
            let userId = users[0].id
            
            let fsPost = FireStoreService<Post>(collection: .posts)
            fsPost.queryIsEqualTo(id: userId!, field: "userId"){ [self] data in
                posts = data
                load = false
            }
            
        }else{
            print("Dang nhap hoac dang ky")
            load = false
        }
    }
}
