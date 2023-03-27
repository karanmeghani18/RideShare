//
//  CreateTripView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct CreateTripView: View {
    @State private var originText:String = ""
    @State private var destinationText:String = ""
    @State private var fareText:String = ""
    @State private var carSelection:Int = 1
    @State private var carsList:[Car] = [Car(id: UUID().uuidString, modelName: "Model X", companyName: "Tesla", yearOfManufacture: 2019, availableSeats: 5, totalSeats: 6, maxLuggage: 3, availableLuggae: 2)]
    @State private var selectedCar:Car = Car()
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Origin", text: self.$originText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                EmptyView()
                TextField("Destination", text: self.$destinationText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true).padding(.bottom, 10)
                if(carsList.isEmpty){
                    Text("No Cars Found. Please add car from profile.")
                }else{
                    Section("Select car for trip"){
                        Picker("Select Car",selection: self.$carSelection){
                            ForEach(0..<carsList.count){ i in
                                let car:Car = carsList[i]
                                Text(car.modelName)
                            }
                        }
                        .pickerStyle(.wheel)
                        .onChange(of: carSelection, perform: {newValue in
                            self.selectedCar = carsList[newValue]
                        })
                        .padding(.vertical, -70)
                    }
                }
                
                TextField("Expected Fare", text: self.$fareText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
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
                    
                }){
                    Text("Create")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .background(Color.blue)
                }.disabled(self.carsList.isEmpty)
            }.padding()
            .navigationTitle("Create A Trip!")
            .onAppear(perform: {
                
            })
        }
    }
}

struct CreateTripView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTripView()
    }
}
