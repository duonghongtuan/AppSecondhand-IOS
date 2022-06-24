//
//  ContentView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tabViewModel = TabViewModel()
    @StateObject var postViewModel = PostViewModel()
    @StateObject var viewModel = ViewModel()

    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $tabViewModel.active){
                HomeView()
                    .environmentObject(viewModel)
                    .tag(Tabs.tab1)
                ManagementView()
                    .tag(Tabs.tab2)
//                PostProductView()
//                    .tag(Tabs.tab3)
                NotificationView()
                    .tag(Tabs.tab4)
                ProfileView()
                    .environment(\.managedObjectContext, viewContext)
                    .tag(Tabs.tab5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
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
                                if item.active == Tabs.tab3{
                                    postViewModel.showPostView.toggle()
                                }else{
                                    tabViewModel.switchTab(tab: item.active)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 4.0)
                            .padding(.bottom)
                            Spacer()
                        }
                }
                
            }
        }
        .sheet(isPresented: $postViewModel.showPostView, content: {
            PostProductView()
                .environmentObject(postViewModel)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
