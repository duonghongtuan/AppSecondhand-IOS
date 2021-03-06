//
//  ProfileView.swift
//  SecondHandMarket
//
//  Created by HongTuan on 5/14/22.
//

import SwiftUI


struct ProfileView: View {
    @StateObject var viewModel = AuthViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserCoreData.id, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserCoreData>
    
    
    var body: some View {
        if users.isEmpty == false{
            let _ = viewModel.imageAvatar(url: users[0].avatar!)
            
        }
        VStack(spacing:0){
            if users.isEmpty == false{
                VStack {
                    HStack(alignment: .center) {
                        if let image = viewModel.avatar{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        }else{
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text(users[0].name!)
                                .foregroundColor(.blue)
                            .font(.title3)
                            Text(users[0].phoneNumber!)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(LinearGradient(colors: [Color.white, Color.green], startPoint: .top, endPoint: .bottom))
            }
            
            List(){
                if users.isEmpty{
                    NavigationLink(destination: RegisterView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationTitle("????ng k??")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        , label: {
                            Text("????ng k?? t??i kho???n")
                        })
                    .navigationTitle("T??i kho???n")
                    
                    NavigationLink(destination: LoginView()
                        .environmentObject(viewModel)
                        .environment(\.managedObjectContext, viewContext)
                        .navigationTitle("????ng nh???p")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        , label: {
                            Text("????ng nh???p")
                        })
                    .navigationTitle("T??i kho???n")
                }else{
                    Text("????ng xu???t")
                        .onTapGesture {
                            viewModel.logOut(user: users[0], context: viewContext)
                        }
                }
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
