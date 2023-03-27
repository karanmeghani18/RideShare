//
//  File.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation

import FirebaseFirestoreSwift

struct Car : Codable, Hashable, Identifiable {
    var id : String? = UUID().uuidString
    var modelName:String = ""
    var companyName:String = ""
    var yearOfManufacture: Int = 0
    var availableSeats: Int = 0
    var totalSeats: Int = 0
    var maxLuggage: Int = 0
    var availableLuggage: Int = 0
    
    //pre-defined members
    private static let fModelName:String = "cModelName"
    private static let fCompanyName:String = "cCompanyName"
    private static let fYearOfManufacture:String = "cYearOfManufacture"
    private static let fAvailableSeats:String = "cAvailableSeats"
    private static let fTotalSeats:String = "cTotalSeats"
    private static let fMaxLuggage:String = "cMaxLuggage"
    private static let fAvailableLuggage:String = "fAvailableLuggage"
    
    init(){
        
    }
    
    init(id: String? = nil, modelName: String, companyName: String, yearOfManufacture: Int, availableSeats: Int, totalSeats: Int, maxLuggage: Int, availableLuggae: Int) {
        self.id = id
        self.modelName = modelName
        self.companyName = companyName
        self.yearOfManufacture = yearOfManufacture
        self.availableSeats = availableSeats
        self.totalSeats = totalSeats
        self.maxLuggage = maxLuggage
        self.availableLuggage = availableLuggae
    }
    
    
    
    init?(dictionary : [AnyHashable : Any]){
        
        guard let mName = dictionary[Car.fModelName] as? String else{
            print(#function, "Unable to Model Name from the object")
            return nil
        }
        
        guard let cName = dictionary[Car.fCompanyName] as? String else{
            print(#function, "Unable to Company Name from the object")
            return nil
        }
        
        guard let cyear = dictionary[Car.fYearOfManufacture] as? Int else{
            print(#function, "Unable to YOM from the object")
            return nil
        }
        
        guard let cASeats = dictionary[Car.fAvailableSeats] as? Int else{
            print(#function, "Unable to Available Seats from the object")
            return nil
        }
        
        guard let cTSeats = dictionary[Car.fTotalSeats] as? Int else{
            print(#function, "Unable to Total seats from the object")
            return nil
        }
        
        guard let cLuggage = dictionary[Car.fMaxLuggage] as? Int else{
            print(#function, "Unable to max luggage from the object")
            return nil
        }
        
        guard let cALuggage = dictionary[Car.fAvailableLuggage] as? Int else{
            print(#function, "Unable to available luggage from the object")
            return nil
        }
        
        self.init(modelName: mName, companyName: cName, yearOfManufacture: cyear, availableSeats: cASeats, totalSeats: cTSeats, maxLuggage: cLuggage, availableLuggae: cALuggage)
    }
    
    func toDict() -> [String : Any] {
        return [Car.fModelName : self.modelName,
                Car.fCompanyName : self.companyName,
                Car.fYearOfManufacture : self.yearOfManufacture,
                Car.fTotalSeats : self.totalSeats,
                Car.fAvailableSeats : self.availableSeats,
                Car.fMaxLuggage : self.maxLuggage,
                Car.fAvailableLuggage : self.availableLuggage]
    }
}
