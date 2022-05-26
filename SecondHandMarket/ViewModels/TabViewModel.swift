//
//  TabViewModel.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/20/22.
//

import Foundation
import SwiftUI

class TabViewModel: ObservableObject{
    
    
    struct TabItemData: Hashable {
        let image: String
        let active: Tabs
        let title: String
    }
    @Published var TabData: [TabItemData]
    
    @Published var active: Tabs = .tab1
    
    init(){
        let tab1 = TabItemData(image: "homekit", active: .tab1, title: "Trang chủ")
        let tab2 = TabItemData(image: "square.grid.3x3.fill", active: .tab2, title: "Quản lý")
        let tab3 = TabItemData(image: "plus.circle", active: .tab3, title: "Đăng tin")
        let tab4 = TabItemData(image: "bell.fill", active: .tab4, title: "Thông báo")
        let tab5 = TabItemData(image: "person.fill", active: .tab5, title: "Trang cá nhân")

        self.TabData = [tab1, tab2, tab3, tab4, tab5]
    }
    
    func switchTab(tab: Tabs){
        self.active = tab
    }
    
    
}
