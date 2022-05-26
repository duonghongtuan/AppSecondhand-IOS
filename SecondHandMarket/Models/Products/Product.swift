//
//  product.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation

protocol Product{
    var id: String { get }
    var categoryId: String {get}
    var name: String {get set}
    var company: String {get set}
    var status: String {get set}
    var createDate: Double {get}
    var lastUpdate: Double {get set}
    var image: [String] {get set}
    var price: Int {get set}
    var total: Int {get set}
    var description: String {get set}
}
