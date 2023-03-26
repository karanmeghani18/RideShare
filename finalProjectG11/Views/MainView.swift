//
//  MainView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI

struct MainView: View {
    @State private var rootView : RootView = .Signup
    
    var body: some View {
        NavigationView{
            switch rootView {
            case .SignIn:
                SignInView(rootScreen: $rootView)
            case .Signup:
                SignUpView(rootScreen: $rootView)
            case .Content:
                ContentView(roorscreen: $rootView)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
