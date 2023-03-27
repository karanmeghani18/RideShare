//
//  HomeView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-24.
//

import SwiftUI

struct FindRidesView: View {
    @State private var originText:String = ""
    @State private var destinationText:String = ""
    @State private var tripsListSelection : Int? = nil
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: TripsListView(), tag: 1, selection: self.$tripsListSelection){}.hidden()
                TextField("Origin", text: self.$originText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                EmptyView()
                TextField("Destination", text: self.$destinationText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                Spacer()
                Button(action:{
                    self.tripsListSelection = 1
                }){
                    Text("Search")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.gray)
                }
            }.padding()
                .navigationTitle("Find A Ride!")
        }
       
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FindRidesView()
    }
}
