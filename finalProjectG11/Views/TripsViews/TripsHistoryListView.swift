//
//  TripsHistoryListView.swift
//  finalProjectG11
//
//  Created by Karan Meghani on 2023-03-30.
//

import SwiftUI

struct TripsHistoryListView: View {
    @State private var tripDetailSelection: Int? = nil
    @State private var tripsHistoryList:[Trip] = []
    @State private var selectedTrip:Trip = Trip()
    @EnvironmentObject private var fireDBHelper: FireDBHelper
    
    var body: some View {
        NavigationLink(destination: TripDetailView(trip: selectedTrip).environmentObject(fireDBHelper), tag: 1, selection: self.$tripDetailSelection ){}.hidden()
        NavigationView{
            VStack{
                List{
                    ForEach(self.$tripsHistoryList) { trip in
                        TripItemView(trip: trip.wrappedValue,
                                     onTap: {
                            navigateToDetail(trip: trip.wrappedValue)
                        }).environmentObject(fireDBHelper)
                    }
                    
                }
                .padding(.vertical, -16)
                .padding(.horizontal,-10)
                Spacer()
            }
            .onAppear(perform: {
                self.fireDBHelper.getUserTrips(completion: { tripsReceived in
                    print("trips r", tripsReceived)
                    self.tripsHistoryList = tripsReceived
                })
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

struct TripsHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        TripsHistoryListView()
    }
}
