//
//  AddCarView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct AddCarView: View {
    @State private var modelName:String = ""
    @State private var companyName:String = ""
    @State private var yomSelection:Int = 0
    @State private var yom:Int = 2008
    @State private var luggageSelection:Int = 0
    @State private var luggage:Int = 2
    @State private var seatsSelection:Int = 0
    @State private var seats:Int = 3
    
    @EnvironmentObject private var fireDBHelper:FireDBHelper
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section("Car Info"){
                        TextField("Model Name", text: self.$modelName)
                        TextField("Company Name", text: self.$companyName)
                        Picker("Year of Manufacture",selection: self.$yomSelection){
                            ForEach(2008..<2024){ year in
                                Text(String(year))
                            }
                        }
                        .pickerStyle(.automatic)
                        .onChange(of: yomSelection, perform: {newValue in
                            self.yom = 2008 + newValue
                            print("yom: \(String(yom))")
                        })
                    }
                    Section(header: Text("Space Indo")){
                        Picker("Total Seats",selection: self.$seatsSelection){
                            ForEach(3..<9){ seat in
                                Text(String(seat))
                            }
                        }
                        .pickerStyle(.automatic)
                        .onChange(of: seatsSelection, perform: {newValue in
                            self.seats = 3 + newValue
                            print("yom: \(String(seats))")
                        })
                        
                        Picker("Luggage Space",selection: self.$luggageSelection){
                            ForEach(2..<6){ lug in
                                Text(String(lug))
                            }
                        }
                        .pickerStyle(.automatic)
                        .onChange(of: luggageSelection, perform: {newValue in
                            self.luggage = 2 + newValue
                            print("lugg: \(String(luggage))")
                        })
                    }
                }
                Section{
                    Button(action: {
                        addCar(car: Car(
                            modelName: self.modelName,
                            companyName: self.companyName,
                            yearOfManufacture: yom,
                            totalSeats: seats,
                            maxLuggage: luggage))
                    }){
                        Text("Add Car")
                    }
                }
            }
            .navigationTitle("Add Car")
        }
        
    }
    
    func addCar(car:Car) {
        fireDBHelper.addCar(car: car)
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
