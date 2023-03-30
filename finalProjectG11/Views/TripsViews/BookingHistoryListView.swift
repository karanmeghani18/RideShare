//
//  BookingHistoryListView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-30.
//

import SwiftUI

struct BookingHistoryListView: View {
    @State private var tripDetailSelection: Int? = nil
    @State private var bookingHistory:[Trip] = []
    @State private var selectedTrip:Trip = Trip()
    
    var body: some View {
        NavigationLink(destination: TripDetailView(trip: selectedTrip), tag: 1, selection: self.$tripDetailSelection ){}.hidden()
        NavigationView{
            VStack{
                List{
                    ForEach(self.$bookingHistory) { trip in
                        TripItemView(trip: trip.wrappedValue,
                                     onTap: {
                            navigateToDetail(trip: trip.wrappedValue)
                        })
                    }
                    
                }
                .padding(.vertical, -16)
                .padding(.horizontal,-10)
                Spacer()
            }
            .onAppear(perform: {
                
                let carForTrip:Car = Car(id: UUID().uuidString, modelName: "Model X", companyName: "Tesla", yearOfManufacture: 2019, totalSeats: 6, maxLuggage: 3)
                
                let user:RideShareUser = RideShareUser(userName: "Om C.", profilePhotoUrl: "ProfilePhoto", email: "omchevli@gmail.com", car: [carForTrip])
                
                self.bookingHistory = [
                   

                    
                ]
            })
        }
        .navigationTitle("Trips")
        .navigationBarTitleDisplayMode(.inline)
    }
    func navigateToDetail(trip: Trip) {
        selectedTrip = trip
        self.tripDetailSelection = 1
    }
}

struct BookingHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        BookingHistoryListView()
    }
}
