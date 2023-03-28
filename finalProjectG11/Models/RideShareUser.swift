//
//  User.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct RideShareUser : Codable, Hashable {
    @DocumentID var id : String? = UUID().uuidString
    var userName : String = ""
    var profilePhotoUrl : String = ""
    var email : String = ""
    var car: [Car] = []
    
    //pre-defined members
    private static let fUserName:String = "uUserName"
    private static let fProfilePhotoUrl:String = "uProfilePhotoUrl"
    private static let fEmail:String = "uEmail"
    private static let fCar:String = "uCar"
    
    init(){

    }
    
    init(id: String? = nil, userName: String, profilePhotoUrl: String, email: String, car: [Car] = []) {
        self.id = id
        self.userName = userName
        self.profilePhotoUrl = profilePhotoUrl
        self.email = email
        self.car = car
    }
    
    init?(dictionary : [AnyHashable : Any]){

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

        self.init(userName: name, profilePhotoUrl: photoUrl, email: uemail)
    }
    
    func toDict() -> [String : Any] {
        return [RideShareUser.fUserName : self.userName,
                RideShareUser.fProfilePhotoUrl: self.profilePhotoUrl,
                RideShareUser.fEmail : self.email
        ]
    }
}
