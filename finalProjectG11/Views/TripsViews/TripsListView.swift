//
//  TripsListView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-26.
//

import SwiftUI

struct TripsListView: View {
    @State private var tripDetailSelection: Int? = nil
    @State var tripsList:[Trip]
    @State private var selectedTrip:Trip = Trip()
    var body: some View {
        NavigationLink(destination: TripDetailView(trip: selectedTrip), tag: 1, selection: self.$tripDetailSelection ){}.hidden()
        NavigationView{
            VStack{
                List{
                    ForEach(self.$tripsList) { trip in
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
        }
        .navigationTitle("Trips")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func navigateToDetail(trip: Trip) {
        selectedTrip = trip
        self.tripDetailSelection = 1
    }
}
