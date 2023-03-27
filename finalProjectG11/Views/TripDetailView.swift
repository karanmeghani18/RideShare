//
//  TripDetailView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct TripDetailView: View {
    var trip: Trip
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("From")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 2)
                CustomAccountButton(title: trip.origin, action: {})
                Text("To")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 2)
                CustomAccountButton(title: trip.destination, action: {})
               
                Form{
                    Section(header: Text("Driver Profile")){
                        LabeledContent("Name", value: trip.user.userName)
                        LabeledContent("Email", value: trip.user.email)
                    }.padding(.horizontal,-10)
                    
                    Section(header: Text("Car")){
                        LabeledContent("Model", value: trip.user.car!.modelName)
                        LabeledContent("Company", value: trip.user.car!.companyName)
                        LabeledContent("YOM", value: String(trip.user.car!.yearOfManufacture))
                        LabeledContent("Total Seats", value: String(trip.user.car!.totalSeats))
                        LabeledContent("Available Seats", value: String(trip.user.car!.availableSeats))
                        LabeledContent("Luggage Space Available", value: String(trip.user.car!.availableLuggage))
                        LabeledContent("Total Luggage Space", value: String(trip.user.car!.maxLuggage))
                    }.padding(.horizontal,-10)
                    
                    Section(header: Text("Trip")){
                        LabeledContent("Distance", value: String(trip.distance))
                        LabeledContent("Fare", value: "$\(trip.fare)")
                        LabeledContent("Travel Time", value: "\(String(trip.travelTime)) hrs").padding(.bottom, 28)
                    }.padding(.horizontal,-10)
                        
                }
                .padding(.bottom, -40)
                .cornerRadius(10)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.trailing, 12)
        }
        
            
    }
}

struct TripDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        TripDetailView(
            trip: Trip(id: UUID().uuidString,
            user: User(userName: "Om C.", profilePhotoUrl: "ProfilePhoto", email: "omchevli@gmail.com",
                car: Car(id: UUID().uuidString, modelName: "Model X", companyName: "Tesla", yearOfManufacture: 2019, availableSeats: 5, totalSeats: 6, maxLuggage: 3, availableLuggae: 2)),
           origin: "Toronto, ON", destination:"Brampton, ON", distance:0.0, fare: 29.2, travelTime: 2.4))
    }
}
