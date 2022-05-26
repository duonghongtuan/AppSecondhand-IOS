//
//  laptop.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation

struct Phone: Product, Codable, Hashable, Identifiable{
    
    var id: String
    
    var categoryId: String
    
    var name: String
    
    var company: String
    
    var status: String
    
    var createDate: Double
    
    var lastUpdate: Double
    
    var image: [String]
    
    var price: Int
    
    var total: Int
    
    var description: String
    
    var ram: String
    var screen: String
    var memory: Int
    var color: String
}
