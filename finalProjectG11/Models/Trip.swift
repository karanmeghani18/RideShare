//
//  Trip.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct Trip : Codable, Hashable, Equatable, Identifiable{
    var id : String? = UUID().uuidString
    var user : User = User()
    var origin: String = ""
    var destination: String = ""
    var distance: Double = 0.0
    var fare: Double = 0.0
    var travelTime:Double = 0.0
    
    //pre-defined members
    private static var fUser:String = "tUser"
    private static var forigin:String = "torigin"
    private static var fdestination:String = "tdestinatiom"
    private static var fdistance:String = "tdistance"
    private static var ffare:String = "tfare"
    private static var ftravelTime:String = "ttravelTime"
    
    init(){

    }
    
    init(id: String? = nil, user: User, origin: String, destination: String, distance: Double, fare: Double, travelTime: Double) {
        self.id = id
        self.user = user
        self.origin = origin
        self.destination = destination
        self.distance = distance
        self.fare = fare
        self.travelTime = travelTime
    }
   
    
    init?(dictionary : [String : Any]){

        guard let tUser = dictionary[Trip.fUser] as? User else {
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

        self.init(user: tUser, origin: tOrigin, destination: tDestination, distance: tDistance, fare: tFare, travelTime: tTravelTime)
    }

}
