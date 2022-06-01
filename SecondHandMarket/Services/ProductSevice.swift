//
//  ProductSevice.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation

func convertObjectToArrayStringAny(obj: AnyObject)-> [String: Any]{
    let mirror = Mirror(reflecting: obj)
    var array = [String: Any]()
    
    for child in mirror.children{
        array[child.label!] = child.value
    }
    return array
}

class ProductService{
    
    func createProduct(product: Product){
        
        let array = product.convertObjectToArrayStringAny()
        print(array)
        
    }
}
