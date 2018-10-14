//
//  Status.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import Foundation

struct Status {
    
    var id : Int!
    var legacyValue : String!
    var statusValue : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        legacyValue = dictionary["legacyValue"] as? String
        statusValue = dictionary["statusValue"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if legacyValue != nil{
            dictionary["legacyValue"] = legacyValue
        }
        if statusValue != nil{
            dictionary["statusValue"] = statusValue
        }
        return dictionary
    }
    
}
