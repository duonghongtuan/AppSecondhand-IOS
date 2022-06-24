//
//  Order.swift
//  SecondHandMarket
//
//  Created by HongTuan on 22/06/2022.
//

import Foundation

struct Order: Object{
    var id: String
    var userId: String
    var productIds: [String]
    var createDate: Int64
    var quantity: Int
    var total: Int
    var phoneNumber: Int
    var address: String
    var state: Int
}
