//
//  Service.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/17/22.
//

import Foundation

class Service{
    
    func auth()->Authentication{
        return Authentication()
    }
    
    func imageService()  ->ImageService{
        return ImageService()
    }
    
    func categoryService()  ->CategoryService{
        return CategoryService()
    }
}


