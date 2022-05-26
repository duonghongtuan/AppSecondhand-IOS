//
//  SecondHandMarketApp.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI
import FirebaseCore

@main
struct SecondHandMarketApp: App {
    let persistenceController = PersistenceController.shared
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .navigationBarHidden(true)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
