//
//  ContentView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tabViewModel = TabViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack{
            TabView(selection: $tabViewModel.active){
                HomeView()
                    .tag(Tabs.tab1)
                ManagementView()
                    .tag(Tabs.tab2)
                PostProductView()
                    .tag(Tabs.tab3)
                NotificationView()
                    .tag(Tabs.tab4)
                ProfileView()
                    .environment(\.managedObjectContext, viewContext)
                    .tag(Tabs.tab5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.bottom, -8.0)
            
            VStack {
                HStack{
                    Spacer()
                }
                .frame(width: Screen.width, height: 1)
                .background(Color.gray1)
                HStack{
                    Spacer()
                        ForEach(
                            tabViewModel.TabData,
                            id: \.self
                        ) {
                            item in
                            VStack{
                                Image(systemName: item.image)
                                    .font(.system(size: 24))
                                    .foregroundColor(tabViewModel.active == item.active ? .green : .gray)
                            }
                            .onTapGesture {
                                tabViewModel.switchTab(tab: item.active)
                            }
                            .padding(.horizontal)
                            .padding(.top, 4.0)
                            .padding(.bottom)
                            Spacer()
                        }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
