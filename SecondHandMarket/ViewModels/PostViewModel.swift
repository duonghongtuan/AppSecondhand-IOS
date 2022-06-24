//
//  PostViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/26/22.
//

import Foundation
import UIKit

class PostViewModel: ObservableObject{
    private var service: Service
    @Published var categoris = [Category]()
    @Published var companies : [String]?
    @Published var post: Post
    @Published var images = [UIImage]()
    @Published var showPostView = false
    @Published var category: String = ""
    @Published var showCategories : Bool = true
    @Published var showCompanies : Bool = true
    
    init(service: Service = Service()){
        self.service = service
        self.post = Post()
        getCategories()
        
    }
    
    func selectCategory(category: Category){
        post.categoryId = category.id
        companies = category.companies
        post.company = ""
    }
    
    func getCategories(){
        let categoryService = service.categoryService()
        categoryService.getCategories(){ categoris in
            self.categoris = categoris
        }
    }
    
    func createPost(){
        let coreData = CoreDataManager()
        let users = coreData.getUser()
        
        if !users.isEmpty {
            let userId = users[0].id
            
            let fsPost = FireStoreService<Post>(collection: .posts)
            
            post.createDate = Date().millisecondsSince1970
            post.userId = userId!
            
            fsPost.save(entity: post){ result in
                if result{
                    self.reset()
                    print("add product sucsess")
                }else{
                    print("error add product")
                }
            }
            
        }else{
            print("Dang nhap hoac dang ky")
        }
        
    }
    
    func reset(){
        showPostView = false
        self.post = Post()
        images = []
        companies = nil
        category = ""
    }
    
    func addImage(image: UIImage) {
        images.append(image)
        let imageString = image.base64
        post.images.append(imageString!)
        print(imageString?.count as Any)
    }
}
