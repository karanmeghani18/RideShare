//
//  MainView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct MainView: View {
    @State private var rootView : RootView
    private let fireAuthHelper = FireAuthHelper()
    private let fireDBHelper = FireDBHelper.getInstance() ?? FireDBHelper(store: Firestore.firestore())
    
    init() {
        let credArray:[String]? = fireAuthHelper.isUserLoggedIn()
        if(credArray != nil){
            self.fireDBHelper.getUserProfile(){profile in}
            self.fireDBHelper.getUserCars(){cars in}
            self.rootView = .Content
        }else{
            self.rootView = .Signup
        }
    }
    
    var body: some View {
        NavigationView{
            switch rootView {
            case .SignIn:
                SignInView(rootScreen: $rootView)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .Signup:
                SignUpView(rootScreen: $rootView)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .Content:
                ContentView(roorscreen: $rootView)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
