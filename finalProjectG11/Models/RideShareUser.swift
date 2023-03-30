//
//  User.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct RideShareUser : Codable, Hashable {
    var id : String? = UUID().uuidString
    var userName : String = ""
    var profilePhotoUrl : String = ""
    var email : String = ""
    var car: [Car] = []
    var trips: [String] = []
    var rides: [String] = []
    
    //pre-defined members
    private static let fUserId:String = "uId"
     static let fUserName:String = "uUserName"
    private static let fProfilePhotoUrl:String = "uProfilePhotoUrl"
    private static let fEmail:String = "uEmail"
    private static let fCar:String = "uCar"
    static let fTrips:String = "uTrips"
    static let fRides:String = "uRides"
    
    init(){

    }
    
    init(id: String? = nil, userName: String, profilePhotoUrl: String, email: String = "", car: [Car] = [], trips: [String] = [], rides: [String] = []) {
        self.id = id
        self.userName = userName
        self.profilePhotoUrl = profilePhotoUrl
        self.email = email
        self.car = car
        self.trips = trips
        self.rides = rides
    }
    
    init?(dictionary : [AnyHashable : Any]){
        
        guard let tid = dictionary[RideShareUser.fUserId] as? String else{
            print(#function, "Unable to get id from the object Rideshare")
            return nil
        }

        guard let name = dictionary[RideShareUser.fUserName] as? String else{
            print(#function, "Unable to read Name from the object")
            return nil
        }
        
        guard let photoUrl = dictionary[RideShareUser.fProfilePhotoUrl] as? String else{
            print(#function, "Unable to read profile photo URL from the object")
            return nil
        }
        

        guard let uemail = dictionary[RideShareUser.fEmail] as? String else{
            print(#function, "Unable to read Email from the object")
            return nil
        }
        
        guard let utrips = dictionary[RideShareUser.fTrips] as? [String] else{
            print(#function, "Unable to read trips id in the object")
            return nil
        }
        
        guard let urides = dictionary[RideShareUser.fRides] as? [String] else{
            print(#function, "Unable to read rides id in the object")
            return nil
        }

        self.init(id: tid, userName: name, profilePhotoUrl: photoUrl, email: uemail, trips: utrips, rides: urides)
    }
    
    func toDict() -> [String : Any] {
        return [
            RideShareUser.fUserId : self.id ?? "",
            RideShareUser.fUserName : self.userName,
            RideShareUser.fProfilePhotoUrl: self.profilePhotoUrl,
            RideShareUser.fEmail : self.email,
            RideShareUser.fTrips : self.trips,
            RideShareUser.fRides : self.rides,
        ]
    }
    
}
