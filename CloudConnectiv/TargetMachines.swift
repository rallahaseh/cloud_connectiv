//
//  TargetMachine.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import Foundation

struct TargetMachines {
    
    var id : Int!
    var sourceMachineId : Int!
    var circuitStatusId : Int!
    var targetMachine : TargetMachine!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        sourceMachineId = dictionary["sourceMachineId"] as? Int
        circuitStatusId = dictionary["circuitStatusId"] as? Int
        if let targetMachineData = dictionary["targetMachine"] as? [String:Any]{
            targetMachine = TargetMachine(fromDictionary: targetMachineData)
        }
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
        if sourceMachineId != nil{
            dictionary["sourceMachineId"] = sourceMachineId
        }
        if circuitStatusId != nil{
            dictionary["circuitStatusId"] = circuitStatusId
        }
        if targetMachine != nil{
            dictionary["targetMachine"] = targetMachine.toDictionary()
        }
        return dictionary
    }
    
}
