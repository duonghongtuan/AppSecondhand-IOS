//
//  Cart.swift
//  SecondHandMarket
//
//  Created by HongTuan on 22/06/2022.
//

import Foundation

struct Cart: Object{
    var id: String = "\(UUID())"
    var userId: String
    var productId: String
    var quantity: Int
    var price: Int
}
