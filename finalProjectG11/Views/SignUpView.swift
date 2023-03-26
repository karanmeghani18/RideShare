//
//  SignUpView.swift
//  FirestoreDemo
//
//  Created by Tech on 2023-03-15.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    @Binding var rootScreen : RootView
    
    var body: some View {
        
        VStack{
            
            Form{
                
                TextField("Enter Email", text: self.$email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password", text: self.$password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Enter Password Again", text: self.$confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
            }//Form ends
            .disableAutocorrection(true)
            
            Section{
                Button(action: {
                    //Task : validate the data
                    //such as all the inputs are not empty
                    //and check for password rule
                    //and display alert accordingly
                    
                    //if all the data is validated
                    self.fireAuthHelper.signUp(email: self.email, password: self.password)
                    
                    //move to home screen
                    self.rootScreen = .Content
                }){
                    Text("Create Account")
                }//Button ends
                .disabled( self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
                
            }//Section ends
            
        }//VStack ends
        
    }//body ends
}
