//
//  viewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/24/22.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var posts = [Post]()
    @Published var user : User?
    @Published var showAddCart: Bool = false
    @Published var carts = [Cart]()
    @Published var listPostInCart = [Post]()
    init(){
        getAllPost()
        getAllCart()
    }
    
    func getAllPost(){
        let fsProduct = FireStoreService<Post>(collection: .posts)
        fsProduct.getAll(){data in
            self.posts = data
        }
    }
    
    func getAllCart(){
        let fsCart = FireStoreService<Cart>(collection: .carts)
        fsCart.getAll(completion: { [self]data in
            carts = data
            getListPostInCart()
        })
    }
    
    func getUser(userId: String){
        let fsUser = FireStoreService<User>(collection: .users)
        fsUser.getDocumentWithId(id: userId){ data in
            self.user = data
        }
    }
    
    func addToCart(post: Post, quantity: Int){
        let coreData = CoreDataManager()
        let users = coreData.getUser()
        
        if !users.isEmpty {
        let fsCart = FireStoreService<Cart>(collection: .carts)
            let cart = Cart(userId: users[0].id!, productId: post.id, quantity: quantity, price: Int(post.price)!)
            fsCart.save(entity: cart, completion: { [self]
                _ in
                carts.append(cart)
                listPostInCart.append(post)
                showAddCart = true
            })
        }else{
            
        }
    }
    
    func getListPostInCart(){
        let fsPost = FireStoreService<Post>(collection: .posts)
        for cart in carts {
            fsPost.getDocumentWithId(id: cart.productId, completion: {value in
                self.listPostInCart.append(value)
                })
        }
    }
    
    func getPost(postId: String)->Post{
        let post = listPostInCart.first(where: {$0.id == postId})
        return post!
    }
    
    func deleteCart(id: String){
        let index = carts.firstIndex(where: {$0.id == id})
        carts.remove(at: index!)
    }
}
