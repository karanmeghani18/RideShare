//
//  RideLocation.swift
//  finalProjectG11
//
//  Created by Om Chevli on 2023-03-27.
//

import Foundation
import FirebaseFirestoreSwift

struct RideLocation: Codable, Hashable, Identifiable {
    var id : String? = UUID().uuidString
    var name:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    //pre-defined
    static private var fCity = "lCity"
    static private var fLat = "lLat"
    static private var fLong = "lLog"
    
    init() {
        
    }
    
    init(id: String? = nil, cityName: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = cityName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(dictionary : [AnyHashable : Any]){

        guard let rCityName = dictionary[RideLocation.fCity] as? String else{
            print(#function, "Unable to read city from the object")
            return nil
        }
        
        
        guard let rLat = dictionary[RideLocation.fLat] as? Double else{
            print(#function, "Unable to read latitude from the object")
            return nil
        }
        
        guard let rLong = dictionary[RideLocation.fLong] as? Double else{
            print(#function, "Unable to read longitude from the object")
            return nil
        }
    

        self.init(cityName: rCityName, latitude: rLat, longitude: rLong)
    }
    
    enum CodingKeys: String, CodingKey {
            case name
            case latitude
            case longitude
            case country
            case population
            case isCapital = "is_capital"
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            latitude = try container.decode(Double.self, forKey: .latitude)
            longitude = try container.decode(Double.self, forKey: .longitude)
        }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
}
