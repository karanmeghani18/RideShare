//
//  User.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable, Hashable {
    @DocumentID var id : String? = UUID().uuidString
    var userName : String = ""
    var profilePhotoUrl : String = ""
    var email : String = ""
    
    //pre-defined members
    private static let fUserName:String = "uUserName"
    private static let fProfilePhotoUrl:String = "uProfilePhotoUrl"
    private static let fEmail:String = "uEmail"
    
    init(){

    }
    
    init(id: String? = nil, userName: String, profilePhotoUrl: String, email: String) {
        self.id = id
        self.userName = userName
        self.profilePhotoUrl = profilePhotoUrl
        self.email = email
    }
    
    init?(dictionary : [AnyHashable : Any]){

        guard let name = dictionary[User.fUserName] as? String else{
            print(#function, "Unable to read Name from the object")
            return nil
        }
        
        guard let photoUrl = dictionary[User.fProfilePhotoUrl] as? String else{
            print(#function, "Unable to read profile photo URL from the object")
            return nil
        }
        

        guard let uemail = dictionary[User.fEmail] as? String else{
            print(#function, "Unable to read Email from the object")
            return nil
        }

        self.init(userName: name, profilePhotoUrl: photoUrl, email: uemail)
    }
    
    func toDict() -> [String : Any] {
        return [User.fUserName : self.userName,
                User.fProfilePhotoUrl: self.profilePhotoUrl,
                User.fEmail : self.email]
    }
}
