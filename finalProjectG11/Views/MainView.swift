//
//  MainView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI

struct MainView: View {
    @State private var rootView : RootView
    private let fireAuthHelper = FireAuthHelper()
    
    init() {
        let credArray:[String]? = fireAuthHelper.isUserLoggedIn()
        if(credArray != nil){
            self.rootView = .Content
        }else{
            self.rootView = .Signup
        }
        
    }
    
    var body: some View {
        NavigationView{
            switch rootView {
            case .SignIn:
                SignInView(rootScreen: $rootView).environmentObject(fireAuthHelper)
            case .Signup:
                SignUpView(rootScreen: $rootView).environmentObject(fireAuthHelper)
            case .Content:
                ContentView(roorscreen: $rootView)
            }
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
