//
//  SignInView.swift
//  FirestoreDemo
//
//  Created by Tech on 2023-03-15.
//

import SwiftUI
import FirebaseFirestore

struct SignInView: View {
    
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var selection : Int? = nil
    @State private var homeSelection : Int? = nil
    @State private var invalidUserCredAlert:Bool = false
    
    @Binding var rootScreen : RootView
//    
//    private let fireDBHelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    
    private let gridItems : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            VStack{
                NavigationLink(destination: SignUpView(rootScreen: self.$rootScreen).environmentObject(self.fireAuthHelper), tag: 2, selection: self.$selection){}
                
                Form{
                    TextField("Enter Email", text: self.$email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Enter Password", text: self.$password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                }//Form ends
                .disableAutocorrection(true)
                
                LazyVGrid(columns: self.gridItems){
                    Button(action: {
                        //validate the data
                        if (!self.email.isEmpty && !self.password.isEmpty){
                            self.fireAuthHelper.signIn(email: self.email, password: self.password){ isSignedIn in
                                if isSignedIn {
                                    // The sign-in was successful, so handle it here
                                    fireDBHelper.getUserProfile{
                                        profile in self.rootScreen = .Content
                                    }
                                    
                                } else {
                                    // The sign-in was not successful, so handle it here
                                    print("Sign in failed.")
                                    invalidUserCredAlert = true
                                }
                            } 
                        }else{
                            //trigger alert displaying errors
                            print(#function, "email and password cannot be empty")
                        }
                    }){
                        Text("Sign In")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(Color.blue)
                    }
                    
                    Button(action: {
                        //take the user to signup screen
//                        self.selection = 2
                        self.rootScreen = .Signup
                    }){
                        Text("Sign Up")
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .background(Color.blue)
                    }
                }//LazyVGrid ends

                Spacer()
                    .navigationTitle("Sign In")
            }//VStack ends
            .onAppear{
                let credArray:[String]? = self.fireAuthHelper.isUserLoggedIn()
                self.email = credArray?[0] ?? ""
                self.password = credArray?[1] ?? ""
            }
            .alert(isPresented: self.$invalidUserCredAlert){
                Alert(title: Text("Invalid!"), message: Text("Invalid email or password"), dismissButton: .default(Text("Try Again!")))
            }
            
    }//body ends
}
