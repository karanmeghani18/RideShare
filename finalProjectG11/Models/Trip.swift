//
//  Trip.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct Trip : Codable, Hashable, Equatable, Identifiable{
    @DocumentID var id : String? = UUID().uuidString
    var user : RideShareUser = RideShareUser()
    var selectedCarIndex: Int = 0
    var origin: String = ""
    var destination: String = ""
    var distance: Double = 0.0
    var fare: Double = 0.0
    var travelTime:Double = 0.0
    var availableSeats: Int = 0
    var availableLuggage: Int = 0
    
    //pre-defined members
    private static var fUser:String = "tUser"
    private static var forigin:String = "torigin"
    private static var fdestination:String = "tdestinatiom"
    private static var fdistance:String = "tdistance"
    private static let fAvailableSeats:String = "cAvailableSeats"
    private static var ffare:String = "tfare"
    private static var ftravelTime:String = "ttravelTime"
    private static let fAvailableLuggage:String = "fAvailableLuggage"
    private static let fselectedCarIndex:String = "fselectedCarIndex"
    
    init(){

    }
    
    init(id: String? = nil, user: RideShareUser, origin: String, availableSeats: Int, destination: String, distance: Double, fare: Double, travelTime: Double, availableLuggae: Int, selectedCarIndex:Int) {
        self.id = id
        self.user = user
        self.origin = origin
        self.destination = destination
        self.distance = distance
        self.fare = fare
        self.availableSeats = availableSeats
        self.travelTime = travelTime
        self.availableLuggage = availableLuggae
        self.selectedCarIndex = selectedCarIndex
    }
   
    
    init?(dictionary : [String : Any]){

        guard let tUser = dictionary[Trip.fUser] as? RideShareUser else {
            print(#function, "Unable to read user from the object")
            return nil
        }

        guard let tOrigin = dictionary[Trip.forigin] as? String else {
            print(#function, "Unable to read origin from the object")
            return nil
        }

        guard let tDestination = dictionary[Trip.fdestination] as? String else {
            print(#function, "Unable to read destination from the object")
            return nil
        }
        
        guard let tDistance = dictionary[Trip.fdistance] as? Double else {
            print(#function, "Unable to read destination from the object")
            return nil
        }

        guard let tFare = dictionary[Trip.ffare] as? Double else {
            print(#function, "Unable to read fare from the object")
            return nil
        }

        guard let tTravelTime = dictionary[Trip.ftravelTime] as? Double else {
            print(#function, "Unable to read travel time from the object")
            return nil
        }
        
        guard let cASeats = dictionary[Trip.fAvailableSeats] as? Int else{
            print(#function, "Unable to Available Seats from the object")
            return nil
        }
        guard let cALuggage = dictionary[Trip.fAvailableLuggage] as? Int else{
            print(#function, "Unable to available luggage from the object")
            return nil
        }
        guard let cselectedCarIndex = dictionary[Trip.fselectedCarIndex] as? Int else{
            print(#function, "Unable to selected car index from the object")
            return nil
        }

        self.init(user: tUser, origin: tOrigin, availableSeats: cASeats, destination: tDestination, distance: tDistance, fare: tFare, travelTime: tTravelTime, availableLuggae: cALuggage, selectedCarIndex: cselectedCarIndex )
    }

    func toDict() -> [String : Any] {
        return [Trip.fUser : self.user,
                Trip.forigin : self.origin,
                Trip.fdestination : self.destination,
                Trip.fdistance : self.distance,
                Trip.fAvailableSeats : self.availableSeats,
                Trip.ffare : self.fare,
                Trip.ftravelTime : self.travelTime,
                Trip.fAvailableLuggage : self.availableLuggage,
                Trip.fselectedCarIndex : self.selectedCarIndex]
    }
}
