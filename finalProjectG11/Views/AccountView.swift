//
//  AccountView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-26.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack{
            HStack{
                Image("ProfilePhoto")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .leading)
                    .padding(.trailing, 16)
                Text("Om Chevli")
                    .font(.title3)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Section(header: Text("")){
                EmptyView()
            }
            
            CustomAccountButton(title: "Trips History", action: {
                
            })
            
            CustomAccountButton(title: "Booking History", action: {
                
            })
            
            CustomAccountButton(title: "Profile", action: {
                
            })
            
            CustomAccountButton(title: "Trips Earnings", action: {
                
            })
            
            
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
