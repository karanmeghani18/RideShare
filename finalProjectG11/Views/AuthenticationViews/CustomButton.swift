//
//  CustomAccountButton.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-26.
//

import SwiftUI

struct CustomButton: View{
    var title: String
    var action: () -> Void
    var body: some View{
        Button(action: self.action) {
            Text(self.title)
                .font(.title3)
                .foregroundColor(.black)
                .bold()
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
        }
        .frame(width:UIScreen.main.bounds.width - 40, alignment: .leading)
        .background(Color(red: 245/255, green: 242/255, blue: 242/255))
        .padding(.vertical, 5)
    }
   
}
