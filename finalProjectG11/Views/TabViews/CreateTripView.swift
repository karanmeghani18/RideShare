//
//  CreateTripView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject private var fireDbHelper: FireDBHelper
    @EnvironmentObject private var locationHelper:LocationHelper

    @State private var originText:String = ""
    @State private var destinationText:String = ""

    @State private var fareText:String = ""
    @State private var carSelection:Int = 0
    @State private var carsList:[Car] = []
    @State private var selectedCar:Car = Car()
    
    @State private var alertTitle:String = ""
    @State private var alertComment:String = ""
    @State private var originGeoCords:[Double] = []
    @State private var destinationGeoCords:[Double] = []
    @State private var showAlert:Bool = false

    var body: some View {
        NavigationView{
            VStack{
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


                Section("Select car for trip"){
                    if(carsList.isEmpty){
                        Text("No Cars Found. Please add car from profile.")
                    }else{
                        Picker("Select Car",selection: self.$carSelection){
                            ForEach(0..<carsList.count){ i in
                                let car:Car = carsList[i]
                                Text(car.modelName)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: carSelection, perform: {newValue in
                            self.selectedCar = carsList[newValue]
                        })
                    }

                }




                TextField("Expected Fare", text: self.$fareText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
                    .padding(.bottom, 10)
                Form{
                    Section(header: Text("Fare Details")){
                        LabeledContent("Expected Fare", value: "$\(Double(self.fareText) ?? 0)")
                        LabeledContent("RideShare Commission", value: "$\((Double(self.fareText) ?? 0)*0.2)")
                        LabeledContent("You Receive", value: "$\((Double(self.fareText) ?? 0)*0.8)")
                    }
                }
                
                Spacer()
                Button(action:{
                    print("hii")
                    if validation(){
                    let originLoc = RideLocation(cityName: self.originText, latitude: self.originGeoCords[0], longitude: self.originGeoCords[1])
                                        let destiLoc = RideLocation(cityName: destinationText, latitude: destinationGeoCords[0], longitude: self.destinationGeoCords[1])
                                        let fareOpted = Double(self.fareText) ?? 0.0
                                        let seats = selectedCar.totalSeats
                                        let luggage = selectedCar.maxLuggage

                        let newTrip:Trip = Trip(
                            driver: RideShareUser(),
                            originLocation: originLoc,
                            destLocation: destiLoc,
                            car: selectedCar,
                            fare: fareOpted,
                            availableSeats: seats,
                            availableLuggage: luggage,
                            riderIds: [])

                        fireDbHelper.addTrip(trip: newTrip)
                        self.alertTitle = "Trip Created"
                        self.alertComment = "Your trip has been successfully created."
                        showAlert = true
                        self.originText = ""
                        self.destinationText = ""
                        self.fareText = ""
                        self.destinationGeoCords = []
                        self.originGeoCords = []
                    }

                }){
                    Text("Create")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(self.carsList.isEmpty ? Color.gray : Color.blue)
                }.disabled(self.carsList.isEmpty)
            }
            .padding()
            .navigationTitle("Create A Trip!")
            .alert(isPresented: self.$showAlert){
                Alert(title: Text(self.alertTitle), message: Text(self.alertComment), dismissButton: .default(Text("Okay")))
            }
            .onAppear(perform: {
                self.carsList = self.fireDbHelper.currentUser.car
                if(!carsList.isEmpty){
                    self.selectedCar = carsList[0]
                }
            })
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

        }else if fareText.isEmpty{
            alertTitle = "Expected Fare"
            alertComment = "Expected Fare cannot be empty"
            showAlert = true
            return false

        }
            return true
    }

    func handleLocationAlert(location: LocationType) {
        locationHelper.fetchLocation(locationName: location == LocationType.Destination ? self.destinationText : self.originText){
            foundLocation in
            if(foundLocation?.first != nil){
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
}

struct CreateTripView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTripView()
    }
}
