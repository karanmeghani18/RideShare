//
//  SignUpView.swift
//  FirestoreDemo
//
//  Created by Tech on 2023-03-15.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var name : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @State private var signInSelection : Int? = nil
    
    @Binding var rootScreen : RootView
    
    var body: some View {
            VStack{
                Form{
                    TextField("Name", text: self.$name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .keyboardType(.namePhonePad)
                    
                    
                    TextField("Email", text: self.$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Create Password", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: self.$confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }//Form ends
                .disableAutocorrection(true)
                Button(action:{
                    self.rootScreen = .SignIn
                }){
                    Text("Already have a account?")
                }
                Section{
                    Button(action: {
                        self.fireAuthHelper.signUp(name: self.name, email: self.email, password: self.password){user in
                            if(user != nil){
                                self.fireDBHelper.addUser(user: user!)
                                self.rootScreen = .Content
                            }else{
                                //show alet for error
                            }
                            
                        }
                    }){
                        Text("Create Account")
                    }//Button ends
                    .disabled( self.password != self.confirmPassword && self.email.isEmpty && self.password.isEmpty && self.confirmPassword.isEmpty)
                    
                }//Section ends
                Spacer()
                .navigationTitle("Sign Up")
            }//VStack ends
       
        
    }//body ends
}
