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
    @State private var alertTitle:String = ""
    @State private var alertComment:String = ""
    @State private var originGeoCords:[Double] = []
    @State private var destinationGeoCords:[Double] = []
    @State private var tripsResults:[Trip] = []
    @State private var showAlert:Bool = false
    
    @EnvironmentObject private var locationHelper:LocationHelper
    @EnvironmentObject private var fireDBHelper:FireDBHelper

    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: TripsListView(tripsList : tripsResults), tag: 1, selection: self.$tripsListSelection){}.hidden()
                HStack{
                    TextField("Origin", text: self.$originText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .disabled(!self.originGeoCords.isEmpty)
                    Button(action: {
                        if(self.originGeoCords.isEmpty){
                            self.handleLocationAlert(location: LocationType.Origin)
                        }else{
                            self.originGeoCords = []
                        }

                    }){
                        Image(systemName: self.originGeoCords.isEmpty ? "magnifyingglass" : "pencil" )
                    }
                }
                VStack{
                    HStack{
                        TextField("Destination", text: self.$destinationText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .disabled(!self.destinationGeoCords.isEmpty)
                        Button(action: {
                            print("hii")
                            if(self.destinationGeoCords.isEmpty){
                                print("isEMpty")
                                self.handleLocationAlert(location: LocationType.Destination)
                            }else{
                                print("notEmpty")
                                self.destinationGeoCords = []
                            }

                        }){
                            Image(systemName: self.destinationGeoCords.isEmpty ? "magnifyingglass" : "pencil" )
                        }
                    }
                }
                Spacer()
                Button(action:{


                    if validation(){
                        self.fireDBHelper.findTrips(origin: self.originText, destination: self.destinationText, completion: {
                                                foundTripsList in
                                                if(foundTripsList.isEmpty){
                                                    //show alert, no trips found
                                                }else{
                                                    tripsResults = foundTripsList
                                                    self.tripsListSelection = 1
                                                }

                                            })
                    }

                }){
                    Text("Search")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.gray)
                }
            }
                .padding()
                .navigationTitle("Find A Ride!")
                .alert(isPresented: self.$showAlert){
                    Alert(title: Text(self.alertTitle), message: Text(self.alertComment), dismissButton: .default(Text("Okay")))
                }
        }
       
        
    }
    
    func handleLocationAlert(location: LocationType) {
        locationHelper.fetchLocation(locationName: location == LocationType.Destination ? self.destinationText : self.originText){
            foundLocation in
            if(foundLocation != nil){
                let fetchedLocation = foundLocation!.first
                alertTitle = "\(location) Location Found!"
                alertComment = "Selected \(location) Location: \(fetchedLocation!.name)"
                if(location == LocationType.Origin){
                    self.originText = fetchedLocation!.name
                    self.originGeoCords = [fetchedLocation!.latitude, fetchedLocation!.longitude]
                }else{
                    self.destinationText = fetchedLocation!.name
                    self.destinationGeoCords = [fetchedLocation!.latitude, fetchedLocation!.longitude]
                }
            } else {
                alertTitle = "\(location) Location Not Found!"
                alertComment = "Please enter proper \(location) location"
            }
            
            showAlert = true
        }
    }
    
    func validation() -> Bool{
        if self.originText.isEmpty{
            alertTitle = "Origin Location"
            alertComment = "Origin cannot be empty"
            showAlert = true
            return false

        }else if destinationText.isEmpty{
            alertTitle = "Destination Location"
            alertComment = "Destination cannot be empty"
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
