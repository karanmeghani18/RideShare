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
    @State private var tripsSelection : Int? = nil
    @State private var bookingSelection : Int? = nil
    var body: some View {
        VStack{
            VStack{
                NavigationLink(destination: ProfileView()
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper), tag: 3, selection: self.$profileSelection ){}.hidden()
                
                NavigationLink(destination: TripsHistoryListView()
                               .environmentObject(fireDBHelper), tag: 1, selection: self.$tripsSelection){}
                
                NavigationLink(destination: BookingHistoryListView().environmentObject(fireDBHelper), tag: 2, selection:  $bookingSelection){}.hidden()
            }
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
                self.tripsSelection = 1
            })
            
            CustomButton(title: "Booking History", action: {
                self.bookingSelection = 2
            })
            
            CustomButton(title: "Profile", action: {
                self.profileSelection = 3
            })
            
            CustomButton(title: "Sign Out 🛑", action: {
                fireAuthHelper.signOut()
                self.rootScreen = .SignIn
                
            }, color: Color.red)
            
            Spacer()
        }
        
    }
}


