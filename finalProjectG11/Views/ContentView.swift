//
//  ContentView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI

struct ContentView: View {
    @Binding  var roorscreen : RootView
    var body: some View {
        VStack{
            TabView{
                CreateTripView()
                    .tabItem{
                        Label("Create",systemImage: "plus.circle")
                    }
                FindRidesView()
                    .tabItem{
                        Label("Find",systemImage: "magnifyingglass")
                    }
                AccountView()
                    .tabItem{
                        Label("Account",systemImage: "person.crop.circle")
                    }
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
