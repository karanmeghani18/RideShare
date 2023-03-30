//
//  AccountView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-26.
//

import SwiftUI

struct AccountView: View {
    @Binding var rootScreen:RootView
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var profileSelection : Int? = nil
    var body: some View {
        VStack{
            NavigationLink(destination: ProfileView()
                .environmentObject(fireDBHelper)
                .environmentObject(fireAuthHelper), tag: 3, selection: self.$profileSelection ){}.hidden()
            HStack{
                Image("ProfilePhoto")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .leading)
                    .padding(.trailing, 16)
                Text(fireDBHelper.currentUser.userName)
                    .font(.title3)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Section(header: Text("")){
                EmptyView()
            }
            
            CustomButton(title: "Trips History", action: {
                
            })
            
            CustomButton(title: "Booking History", action: {
                
            })
            
            CustomButton(title: "Profile", action: {
                self.profileSelection = 3
            })
            
            CustomButton(title: "Trips Earnings", action: {
                
            })
            
            CustomButton(title: "Sign Out 🛑", action: {
                fireAuthHelper.signOut()
                self.rootScreen = .SignIn
                
            }, color: Color.red)
            
            CustomButton(title: "Delete Profile & Account ❌", action: {
                
            }, color: Color.red)
            
            
            Spacer()
        }
    }
}


