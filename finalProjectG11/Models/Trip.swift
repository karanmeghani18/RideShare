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
    var driver = RideShareUser()
    var car : Car = Car()
    var driverUserId: String{
        return driver.id ?? ""
    }
    var driverName: String{
        return driver.userName
    }
    var driverPhoto: String{
        return driver.profilePhotoUrl
    }
    var originLocation: RideLocation = RideLocation()
    var destLocation: RideLocation = RideLocation()
    var riderIds: [String] = []
    var origin: String{
        return originLocation.name
    }
    var destination: String{
        return destLocation.name
    }
    var fare: Double = 0.0
    var availableSeats: Int = 0
    var availableLuggage: Int = 0
    var originGeoCord: [Double]{
        return [originLocation.latitude, originLocation.longitude]
    }
    var destinationGeoCord: [Double]{
        return [destLocation.latitude, destLocation.longitude]
    }
    
    //pre-defined members
    private static var fDriverUserId = "tDriverUserId"
    private static var fDriverName = "tDriverName"
    private static var fDriverPhoto = "tDriverPhoto"
    private static var fRiderIds = "tRiderIds"
    static var forigin:String = "tOriginName"
    static var fdestination:String = "tDestinationName"
    private static let foriginGeoCord:String = "tOriginGeoCord"
    private static let fdestinationGeoCord:String = "tDestGeoCord"
    private static let fCar:String = "fCar"
    private static let fAvailableLuggage:String = "fAvailableLuggage"
    private static let fAvailableSeats:String = "cAvailableSeats"
    private static var ffare:String = "tfare"
    
    init(){}
    
    init(id: String? = nil, driver: RideShareUser, originLocation: RideLocation, destLocation: RideLocation, car:Car, fare: Double, availableSeats: Int, availableLuggage: Int, riderIds: [String]) {
        self.id = id
        self.driver = driver
        self.originLocation = originLocation
        self.destLocation = destLocation
        self.car = car
        self.fare = fare
        self.availableSeats = availableSeats
        self.availableLuggage = availableLuggage
        self.riderIds = riderIds
    }
   
    
    init?(dictionary : [String : Any], receivedId:String? = nil){

        guard let tDriverId = dictionary[Trip.fDriverUserId] as? String else {
            print(#function, "Unable to read driver user id from the object")
            return nil
        }
        
        guard let tDriverPhoto = dictionary[Trip.fDriverPhoto] as? String else{
            print(#function, "Unable to driver photo from the object")
            return nil
        }
        
        guard let tDriverName = dictionary[Trip.fDriverName] as? String else{
            print(#function, "Unable to driver name from the object")
            return nil
        }
        
        let tDriver:RideShareUser = RideShareUser(id: tDriverId, userName: tDriverName, profilePhotoUrl: tDriverPhoto)
        
        guard let tRiderIds = dictionary[Trip.fRiderIds] as? [String] else {
            print(#function, "Unable to read rider ids from the object")
            return nil
        }

        guard let tOriginName = dictionary[Trip.forigin] as? String else {
            print(#function, "Unable to read origin name from the object")
            return nil
        }
        
        guard let tDestName = dictionary[Trip.fdestination] as? String else {
            print(#function, "Unable to read destination name from the object")
            return nil
        }
        
        guard let tOriginCords = dictionary[Trip.foriginGeoCord] as? [Double] else{
            print(#function, "Unable to origin geocords from the object")
            return nil
        }
        
        guard let tDestCords = dictionary[Trip.fdestinationGeoCord] as? [Double] else{
            print(#function, "Unable to desti geocords from the object")
            return nil
        }
        
//        guard let tCar = dictionary[Trip.fdestinationGeoCord] as? [Double] else{
//            print(#function, "Unable to desti geocords from the object")
//            return nil
//        }
        
        guard let tCar:Car = Car(dictionary: dictionary[Trip.fCar] as! [AnyHashable : Any]) else{
            print(#function, "Problem in car retrive")
            return nil
        }
        
        let tOriginLocationObj = RideLocation(cityName: tOriginName, latitude: tOriginCords[0], longitude: tOriginCords[1])
        
        let tDestLocationObj = RideLocation(cityName: tDestName, latitude: tDestCords[0], longitude: tDestCords[1])
        
        
        
        guard let tASeats = dictionary[Trip.fAvailableSeats] as? Int else{
            print(#function, "Unable to Available Seats from the object")
            return nil
        }
        
        guard let tFare = dictionary[Trip.ffare] as? Double else {
            print(#function, "Unable to read fare from the object")
            return nil
        }

       
        guard let tALuggage = dictionary[Trip.fAvailableLuggage] as? Int else{
            print(#function, "Unable to available luggage from the object")
            return nil
        }
        
        
        

        self.init(id: receivedId, driver: tDriver, originLocation: tOriginLocationObj, destLocation: tDestLocationObj, car: tCar, fare: tFare, availableSeats: tASeats, availableLuggage: tALuggage, riderIds: tRiderIds)
    }

    func toDict() -> [String : Any] {
        return [
                Trip.fDriverUserId : self.driverUserId,
                Trip.fDriverName : self.driverName,
                Trip.fDriverPhoto : self.driverPhoto,
                Trip.fRiderIds : self.riderIds,
                Trip.forigin : self.origin,
                Trip.fdestination : self.destination,
                Trip.foriginGeoCord : self.originGeoCord,
                Trip.fdestinationGeoCord : self.destinationGeoCord,
                Trip.fCar : self.car.toDict(),
                Trip.fAvailableLuggage : self.availableLuggage,
                Trip.fAvailableSeats : self.availableSeats,
                Trip.ffare : self.fare,
        ]
    }
    
    public static func copyWith(id: String? = nil, driver: RideShareUser, originLocation: RideLocation, destLocation: RideLocation, car:Car, fare: Double, availableSeats: Int, availableLuggage: Int, riderIds: [String]) -> Trip{
        return Trip(id: id, driver: driver, originLocation: originLocation, destLocation: destLocation, car: car, fare: fare, availableSeats: availableSeats, availableLuggage: availableLuggage, riderIds: riderIds)
    }
}
