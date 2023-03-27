//
//  TripsListView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-26.
//

import SwiftUI

struct TripsListView: View {
    @State private var tripDetailSelection: Int? = nil
    @State private var tripsList:[Trip] = []
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: TripDetailView(), tag: 1, selection: self.$tripDetailSelection ){}.hidden()
                List{
                    ForEach(self.$tripsList) { trip1 in
                       
                        TripItemView(trip: trip1.wrappedValue,
                                     onTap: navigateToDetail)
                    }
                    
                }
                .padding(.vertical, -16)
                .padding(.horizontal,-10)
                Spacer()
                    
            }
            .onAppear(perform: {
                let user:User = User(userName: "Om C.", profilePhotoUrl: "ProfilePhoto", email: "omchevli@gmail.com")
                let carForTrip:Car = Car(id: UUID().uuidString, modelName: "Model X", companyName: "Tesla", yearOfManufacture: 2019, availableSeats: 5, totalSeats: 6, maxLuggage: 3, availableLuggae: 2)
                
                self.tripsList = [
                    Trip(id: UUID().uuidString, user: user, car: carForTrip, origin: "", destination:"", distance:0.0, fare: 29.2, travelTime: 2.4),
                    Trip(id: UUID().uuidString, user: user, car:carForTrip, origin: "", destination:"", distance:0.0, fare: 19.92, travelTime: 2.4),
                    Trip(id: UUID().uuidString, user: user, car: carForTrip, origin: "", destination:"", distance:0.0, fare: 40.7, travelTime: 2.4),
                    Trip(id: UUID().uuidString, user: user, car: carForTrip, origin: "", destination:"", distance:0.0, fare: 29.2, travelTime: 2.4),
                    Trip(id: UUID().uuidString,user: user, car: carForTrip, origin: "", destination:"", distance:0.0, fare: 29.2, travelTime: 2.4),
                    
                ]
                print("hrrh \(carForTrip.availableSeats)")
                print("hh \(tripsList[0].car.availableSeats)")
            })
        }
        .navigationTitle("Trips")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func navigateToDetail() {
        self.tripDetailSelection = 1
    }
}

struct TripsListView_Previews: PreviewProvider {
    static var previews: some View {
        TripsListView()
    }
}
