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
    @State private var showAlert = false
    @State private var alertTitle : String = ""
    @State private var alertMessage : String = ""
    
    @EnvironmentObject private var locationHelper:LocationHelper
    
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: TripsListView(), tag: 1, selection: self.$tripsListSelection){}.hidden()
                TextField("Origin", text: self.$originText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .onSubmit {
                        print("User hit return!")
                        locationHelper.fetchLocation(locationName: self.originText){ foundLocation in
                            print("Found Location: \(foundLocation?.first?.name)")
                        }
                    }
                EmptyView()
                TextField("Destination", text: self.$destinationText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                Spacer()
                Button(action:{
                    if validation(){
                        //actions 
                        self.tripsListSelection = 1
                    }
                    
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
        }            .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
       
        
    }
    func validation() -> Bool{
        if self.originText.isEmpty{
            alertTitle = "Origin Location"
            alertMessage = "Origin cannot be empty"
            showAlert = true
            return false
            
        }else if destinationText.isEmpty{
            alertTitle = "Destination Location"
            alertMessage = "Destination cannot be empty"
            showAlert = true
            return false
            
        }
            return true
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FindRidesView()
    }
}
