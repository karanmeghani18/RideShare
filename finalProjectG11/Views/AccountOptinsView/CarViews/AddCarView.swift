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
    @State private var showAlert = false
    @State private var alertTitle : String = ""
    @State private var alertMessage : String = ""

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
                        if validation(){
                            addCar(car: Car(
                                modelName: self.modelName,
                                companyName: self.companyName,
                                yearOfManufacture: yom,
                                totalSeats: seats,
                                maxLuggage: luggage))
                            alertTitle = "Succesfull!"
                            alertMessage = "Car added succesfully"
                            showAlert = true
                        }
                        
                    }){
                        Text("Add Car")
                    }
                }
            }
            .navigationTitle("Add Car")
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
    func addCar(car:Car) {
        fireDBHelper.addCar(car: car)
    }
    func validation()-> Bool{
        if modelName.isEmpty{
            alertTitle = "Model name"
            alertMessage = "Model name cannot be empty"
            showAlert = true
            return false
        }else if companyName.isEmpty{
            alertTitle = "Company name"
            alertMessage = "Company name cannot be empty"
            showAlert = true
            return false
        }
        return true
    }

}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView()
    }
}
