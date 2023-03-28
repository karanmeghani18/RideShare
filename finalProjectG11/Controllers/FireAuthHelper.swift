import Foundation
import FirebaseAuth

class FireAuthHelper: ObservableObject{
    
    @Published var user : RideShareUser?{
        didSet{
            objectWillChange.send()
        }
    }
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            
            guard let self = self else{
                //no change in auth state
                return
            }
            
            self.user = RideShareUser(
                id: user!.uid, userName: user!.displayName ?? "", profilePhotoUrl: "ProfilePhoto", email: user!.email ?? ""
            )
        }
    }
    
    func signUp(name:String, email : String, password : String, completion: @escaping (RideShareUser?) -> Void){
        
        Auth.auth().createUser(withEmail : email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while signing up the user : \(error.debugDescription)")
                return
            }
            
            print(#function , "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to create the account")
            case .some(_):
                print(#function, "Successfully created user account")
                self.user = RideShareUser(
                    id: result.user.uid, userName: name, profilePhotoUrl: "ProfilePhoto", email: result.user.email ?? "NA"
                )
                completion(self.user)
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
            }
            
        }
    }
    
    func isUserLoggedIn() -> [String]?{
        let email = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
        let password = UserDefaults.standard.string(forKey: "KEY_PASSWORD") ?? ""
        if(email != "" && password != ""){
            return [email,password]
        }
        return nil
    }
    
    func signIn(email : String, password : String, completion: @escaping (Bool) -> Void){
        var isSignedIn = false
        
        Auth.auth().signIn(withEmail : email, password: password){ [self] authResult, error in
            
            guard let result = authResult else{
                print(#function, "Error while signing in the user : \(error)")
                completion(isSignedIn)
                return
            }
            
            print(#function , "AuthResult : \(result)")
            
            switch authResult{
            case .none:
                print(#function, "Unable to find the user account")
            case .some(_):
                print(#function, "Login Successful")
                self.user = RideShareUser(
                    id: result.user.uid, userName: result.user.displayName ?? "", profilePhotoUrl: "ProfilePhoto", email: result.user.email ?? ""
                )
                
                print(#function, "Welcome \(self.user?.userName ?? "NA")")
                
                UserDefaults.standard.set(self.user?.email, forKey: "KEY_EMAIL")
                UserDefaults.standard.set(password, forKey: "KEY_PASSWORD")
                isSignedIn = true
                
            }
            
            completion(isSignedIn)
            
            
        }
        
    }
    
    func signOut(){
        do{
            
            try Auth.auth().signOut()
            
        }catch let signOutError as NSError{
            print(#function, "unable to sign out user : \(signOutError)")
        }
    }
    func changePassword(currentPassword: String, newPassword: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print(#function, "No current user")
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: currentPassword)
        
        currentUser.reauthenticate(with: credential) { [self] authResult, error in
            guard let result = authResult else {
                print(#function, "Error while reauthenticating user : \(error)")
                return
            }
            
            print(#function , "Reauthentication Successful : \(result)")
            
            currentUser.updatePassword(to: newPassword) { error in
                guard error == nil else {
                    print(#function, "Error while changing password : \(error!)")
                    return
                }
                
                print(#function, "Password changed successfully")
            }
        }
    }

    
}
