//
//  TripItemView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct TripItemView:View {
    var trip: Trip
    var onTap: () -> Void
    
    @State private var detailSelection : Int? = nil
    
    var body: some View{
        let formattedFare = String(format: "%.2f", self.trip.fare)
        Button(action: onTap) {
            HStack{
                
                Image(self.trip.user.profilePhotoUrl)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .leading)
                    .padding(.trailing, 8)
                VStack(alignment: .leading){
                    Text(self.trip.user.userName)
                        .font(.title3)
                        .foregroundColor(Color.black)
                        .frame(alignment: .leading)
                        .padding(.bottom, 2)
                    Text("Availabel Seats: \(self.trip.availableSeats)")
                        .foregroundColor(Color.gray)
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("\(self.trip.user.car[self.trip.selectedCarIndex].totalSeats) Seats")
                        .foregroundColor(Color.black)
                        .frame(alignment: .leading)
                        .padding(.bottom, 2)
                    Text("$\(formattedFare)")
                        .foregroundColor(Color.green)
                        .frame(alignment: .trailing)
                    
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .cornerRadius(20)
        }
        .background(Color(red: 245/255, green: 242/255, blue: 242/255))
        .cornerRadius(12)
        .frame(width: UIScreen.main.bounds.width - 40)
        .buttonStyle(PlainButtonStyle())
    }
}
