//
//  FireDBHelper.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    
    private let store : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_USERS : String = "Users"
    private let COLLECTION_CARS : String = "Cars"
    @Published var currentUser:RideShareUser = RideShareUser()
    
    var loggedInUserEmail:String = ""
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
    func addUser(user : RideShareUser){
        print(#function, "Trying to insert user \(user.userName) to firestore")
        currentUser = user
        loggedInUserEmail = currentUser.email
        self.store
            .collection(COLLECTION_USERS)
            .document(loggedInUserEmail)
            .setData(user.toDict()){ updated in
                if(updated == nil){
                    print(#function, "User inserted successfully!")
                }else{
                    print(#function, "Unable to insert user \(updated.debugDescription)")
                }
            }
        
    }
    
    func getUserProfile(completion: @escaping (Bool) -> Void) {
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""

        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            self.store
                .collection(COLLECTION_USERS)
                .document(loggedInUserEmail)
                .addSnapshotListener({ (querySnapshot, error) in
                    guard let snapshot = querySnapshot else{
                        print(#function, "Unable to retrieve data from Firestore : \(error.debugDescription)")
                        completion(false)
                        return
                    }
                    self.currentUser = RideShareUser(dictionary: snapshot.data() ?? [:]) ?? RideShareUser()
                    print("Received User: \(snapshot.data())")
                    print("HELLO \(self.currentUser.userName)")
                    completion(true)
                    
                })}
    }
    
    func addCar(car:Car){
        print(#function, "Trying to insert car \(car.modelName) to firestore")
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            
            do{
                try self.store
                    .collection(COLLECTION_USERS)
                    .document(loggedInUserEmail)
                    .collection(COLLECTION_CARS)
                    .addDocument(from: car)
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error.debugDescription)")
            }
        }
    }
    
    func getUserCars(completion: @escaping (Bool) -> Void){
        self.loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{
            self.store
                .collection(COLLECTION_USERS)
                .document(loggedInUserEmail)
                .collection(COLLECTION_CARS)
                .addSnapshotListener({ (querySnapshot, error) in
                    
                    guard let snapshot = querySnapshot else{
                        print(#function, "Unable to retrieve data from Firestore : \(error.debugDescription)")
                        return
                    }
                    
                    snapshot.documentChanges.forEach{ (docChange) in
                        
                        do{
                            var receivedCar : Car = try docChange.document.data(as: Car.self)
                            
                            let docID = docChange.document.documentID
                            receivedCar.id = docID
                            
                            let matchedIndex = self.currentUser.car.firstIndex(where: { ($0.id?.elementsEqual(docID)) ?? false })
                            
                            if docChange.type == .added{
                                let isMatching = self.currentUser.car.contains { carFound in
                                    carFound == receivedCar
                                }
                                if(!isMatching){
                                    self.currentUser.car.append(receivedCar)
                                    print(#function, "Document added : \(receivedCar)")
                                }
                            }
                            
                            if docChange.type == .removed{
                                if (matchedIndex != nil){
                                    self.currentUser.car.remove(at: matchedIndex!)
                                }
                            }
                            
                            if docChange.type == .modified{
                                if (matchedIndex != nil){
                                    self.currentUser.car[matchedIndex!] = receivedCar
                                }
                            }
                            
                        }catch let err{
                            print(#function, "Unable to convert the document into object : \(err)")
                        }
                    }
                    
                })
        }
    }
    
}
