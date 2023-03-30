//
//  ProfileView.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    @State private var user:RideShareUser?
    @State private var userName:String = ""
    @State private var carsList:[Car] = []
    @State private var addCarSelection:Int? = nil
    
    var body: some View {
        NavigationLink(destination: AddCarView().environmentObject(fireDBHelper), tag: 1, selection: self.$addCarSelection ){}.hidden()
        NavigationView(){
            VStack{
                Section(header: Text("Name")){
                    TextField("Name", text:self.$userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                if(carsList.isEmpty){
                    Text("No cars Added Yet!")
                }else{
                    List(carsList){ car in
                        Button(action: {}) {
                            HStack{
                                VStack(alignment: .leading){
                                    Text(car.modelName)
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .frame(alignment: .leading)
                                        .padding(.bottom, 2)
                                    Text("Total Seats: \(car.totalSeats)")
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                VStack(alignment: .leading){
                                    Text("Luggage: \(car.maxLuggage)")
                                        .font(.title3)
                                        .foregroundColor(Color.black)
                                        .frame(alignment: .leading)
                                        .padding(.bottom, 2)
                                    Text("YOM: \(String(car.yearOfManufacture))")
                                        .foregroundColor(Color.gray)
                                }
                                
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .cornerRadius(20)
                        }
                    }
                }
                
                
                CustomButton(title: "Add Car", action: {
                    self.addCarSelection = 1
                })
                
                CustomButton(title: "Update Name", action: {
                    
                })
                
                CustomButton(title: "Update Profile Photo", action: {
                    
                })
                
                Spacer()
            }.onAppear(perform:{
                self.user = fireDBHelper.currentUser
                self.userName = user?.userName ?? ""
                self.fireDBHelper.getUserCars(){ cars in
                    self.carsList = cars
                }
            })
            .padding()
            
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
