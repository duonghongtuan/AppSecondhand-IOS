//
//  PostViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/26/22.
//

import Foundation

class PostViewModel: ObservableObject{
    var service: Service
    @Published var categoris = [Category]()
    @Published var companies : [String]?
    @Published var product: Product
    init(service: Service = Service()){
        self.service = service
        self.product = Product()
        getCategories()
        
    }
    
    func selectCategory(category: Category){
        product.categoryId = category.id
        companies = category.companies
        product.company = ""
    }
    
    func getCategories(){
        let categoryService = service.categoryService()
        categoryService.getCategories(){ categoris in
            self.categoris = categoris
        }
    }
    
    func createProduct(){
        let productService = service.productService()
        productService.createProduct(product: product)
    }
}
