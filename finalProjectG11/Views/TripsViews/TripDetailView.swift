//
//  TripDetailView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct TripDetailView: View {
    var trip: Trip
    @EnvironmentObject private var fireDBHelper:FireDBHelper
    
    @State private var luggageSelection: Int = 0
    @State private var luggageRequested: Int = 0
    
    var body: some View {
        let carForTrip = trip.car
        NavigationView{
            VStack(alignment: .leading){
                Text("From")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 2)
                CustomButton(title: trip.origin, action: {})
                Text("To")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 2)
                CustomButton(title: trip.destination, action: {})
               
                Form{
                    Section(header: Text("Driver Profile")){
                        LabeledContent("Name", value: trip.driverName)
                    }.padding(.horizontal,-10)

                    Section(header: Text("Car")){
                        LabeledContent("Model", value: carForTrip.modelName)
                        LabeledContent("Company", value: carForTrip.companyName)
                        LabeledContent("YOM", value: String(carForTrip.yearOfManufacture))
                        LabeledContent("Total Seats", value: String(carForTrip.totalSeats))
                        LabeledContent("Available Seats", value: String(trip.availableSeats))
                        LabeledContent("Luggage Space Available", value: String(trip.availableLuggage))
                        LabeledContent("Total Luggage Space", value: String(carForTrip.maxLuggage))
                    }.padding(.horizontal,-10)
                    

                    Section(header: Text("Trip")){
                        LabeledContent("Fare", value: "$\(trip.fare)")
                        if(trip.driverUserId == fireDBHelper.currentUser.id){
                            LabeledContent("RideShare Commission", value: "$\(trip.fare * 0.2)")
                            LabeledContent("You Receive", value: "$\(trip.fare * 0.8)")
                                .padding(.bottom, 30)
                        }
                    }.padding(.horizontal,-10)
                }
                .padding(.bottom, -40)
                .cornerRadius(10)
                
                if(trip.driver.id != fireDBHelper.currentUser.id){
                    Section{
                        HStack{
                            if(trip.riderIds.contains(fireDBHelper.currentUser.id!)){
                                Text("Ride is Booked!").frame(alignment: .center)
                            } else if(trip.driver.id != fireDBHelper.currentUser.id){
                                Text("Luggage")
                                Picker("Luggage",selection: self.$luggageSelection){
                                    ForEach(0..<trip.availableLuggage+1){ i in
                                        Text(String(0 + i))
                                    }
                                }
                                .pickerStyle(.menu)
                                .onChange(of: luggageSelection, perform: {i in
                                    self.luggageRequested = 0 + i
                                })
                                Button(action: {
                                    if(trip.availableSeats >= 1){
                                        self.fireDBHelper.createBooking(trip: trip, requestedLuggage: luggageRequested)
                                            //show success alert
                                        //send to find booking screen -> 2 screens back
                                        
                                    }else{
                                        //show alert full book
                                    }
                                   
                                }){
                                    Text("Book Ride!")
                                }
                            }
                            
                        }.frame(alignment: .center)
                        
                    }
                }
               
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.trailing, 12)
        }
        
            
    }
}

struct TripDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        TripDetailView(trip: Trip())
    }
}
