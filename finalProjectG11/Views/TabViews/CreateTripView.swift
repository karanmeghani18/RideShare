//
//  CreateTripView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject private var fireDbHelper: FireDBHelper
    
    @State private var originText:String = ""
    @State private var destinationText:String = ""
    @State private var fareText:String = ""
    @State private var carSelection:Int = 0
    @State private var carsList:[Car] = []
    @State private var selectedCar:Car = Car()
    @State private var showAlert = false
    @State private var alertTitle : String = ""
    @State private var alertMessage : String = ""


    
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
                    .keyboardType(.numberPad)
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
                    
                    if validation(){
                        self.alertTitle = "Trip Created"
                        self.alertMessage = "Your trip has been successfully created."
                        showAlert = true
                        self.originText = ""
                        self.destinationText = ""
                        self.fareText = ""
                    }

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
                self.carsList = self.fireDbHelper.currentUser.car
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    func validation() -> Bool{
        if self.originText.isEmpty{
            alertTitle = "Origin Location"
            alertMessage = "Origin cannot be empty"
            showAlert = true
            return false
            
        }else if destinationText.isEmpty{
            alertTitle = "Destination Location"
            alertMessage = "Destination cannot be empty"
            showAlert = true
            return false
            
        }else if fareText.isEmpty{
            alertTitle = "Expected Fare"
            alertMessage = "Expected Fare cannot be empty"
            showAlert = true
            return false
            
        }
            return true
    }
}

struct CreateTripView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTripView()
    }
}
