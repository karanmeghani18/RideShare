//
//  ContentView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI

struct ContentView: View {
    @Binding  var rootScreen : RootView
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @State private var selection = 1
    
    var body: some View {
        VStack{
            TabView(selection: self.$selection){
                CreateTripView()
                    .tabItem{
                        Label("Create",systemImage: "plus.circle")
                    }
                    .environmentObject(fireDBHelper)
                    .tag(0)
                FindRidesView()
                    .tabItem{
                        Label("Find",systemImage: "magnifyingglass")
                    }
                    .tag(1)
                AccountView(rootScreen: $rootScreen)
                    .tabItem{
                        Label("Account",systemImage: "person.crop.circle").environmentObject(fireAuthHelper)
                    }
                    .tag(2)
            }
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(ro)
//    }
//}
