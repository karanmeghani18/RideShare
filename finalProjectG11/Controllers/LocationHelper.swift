//
//  LocationHelper.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
class LocationHelper : ObservableObject{
    
    @Published var location = [RideLocation()]
    let baseurl = URL(string: "https://api.api-ninjas.com/v1/city")!
    private let key = "BbfskFNz4B3FGLiLGRBDyA==PXYbEvJ9LmMIHIqt"
    
    
    func fetchLocation(locationName: String, withCompletion completion: @escaping ([RideLocation]?) -> Void){
        
        let apiURL = "\(baseurl)?name=\(locationName)&country=CA"
        
        guard let api = URL(string: apiURL) else{
            print(#function, "Unable to convert string to URL")
            return
        }
        
        var request = URLRequest(url: api)
        request.setValue(key, forHTTPHeaderField: "X-Api-Key")
        
        //create a task to connect to network and extract the data
        let task = URLSession.shared.dataTask(with: request){ (data : Data?, response : URLResponse?, error : Error?) in
            
            if let error = error{
                print(#function, "Error while connecting to network \(error)")
            }else{
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if (httpResponse.statusCode == 200){
                        
                        //execute background asynchronous task to decode the response
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    if let jsonData = data{
                                        
                                        let jsonDecoder = JSONDecoder()
                                        var locationn = try jsonDecoder.decode([RideLocation].self, from: jsonData)
                                        
                                        //return to main thread to access UI
                                        DispatchQueue.main.async {
                                            self.location = locationn
                                            completion(locationn)
                                        }
                                    }else{
                                        print(#function, "Unable to get the JSON data")
                                    }
                                }else{
                                    print(#function, "Response received without data")
                                }
                            }catch let error{
                                print(#function, "Error while extracting data : \(error)")
                            }
                        }
                    }else{
                        print(#function, "Unsuccessful response. Response Code : \(httpResponse.statusCode)")
                        print(httpResponse.debugDescription)
                        print(httpResponse)
                    }
                }else{
                    print(#function, "Unable to get HTTP Response")
                }
            }
        }
        
        //execute the task
        task.resume()
    }
}
