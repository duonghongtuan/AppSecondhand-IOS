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
    
    init(service: Service = Service()){
        self.service = service
        getCategories()
    }
    
    func getCategories(){
        let categoryService = service.categoryService()
        categoryService.getCategories(){ categoris in
            self.categoris = categoris
        }
    }
}
