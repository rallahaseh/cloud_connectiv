//
//  Model.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import Foundation

struct Model {
    
    var creationDate : AnyObject!
    var expiryDate : AnyObject!
    var id : Int!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        creationDate = dictionary["creationDate"] as? AnyObject
        expiryDate = dictionary["expiryDate"] as? AnyObject
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if creationDate != nil{
            dictionary["creationDate"] = creationDate
        }
        if expiryDate != nil{
            dictionary["expiryDate"] = expiryDate
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
}
