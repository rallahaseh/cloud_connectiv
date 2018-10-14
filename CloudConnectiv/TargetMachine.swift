//
//  TargetMachine.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import Foundation

struct TargetMachine {
    
    var communicationProtocols : [CommunicationProtocols]!
    var id : Int!
    var ipAddress : String!
    var ipSubnetMask : String!
    var location : Int!
    var locationId : Int!
    var model : Model!
    var name : String!
    var serialNum : String!
    var serialNumber : String!
    var status : Status!
    var targetMachines : [TargetMachines]!
    var type : Type!
    var version : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        communicationProtocols = [CommunicationProtocols]()
        if let communicationProtocolsArray = dictionary["communicationProtocols"] as? [[String:Any]]{
            for dic in communicationProtocolsArray{
                let value = CommunicationProtocols(fromDictionary: dic)
                communicationProtocols.append(value)
            }
        }
        id = dictionary["id"] as? Int
        ipAddress = dictionary["ipAddress"] as? String
        ipSubnetMask = dictionary["ipSubnetMask"] as? String
        location = dictionary["location"] as? Int
        locationId = dictionary["locationId"] as? Int
        if let modelData = dictionary["model"] as? [String:Any]{
            model = Model(fromDictionary: modelData)
        }
        name = dictionary["name"] as? String
        serialNum = dictionary["serialNum"] as? String
        serialNumber = dictionary["serialNumber"] as? String
        if let statusData = dictionary["status"] as? [String:Any]{
            status = Status(fromDictionary: statusData)
        }
        targetMachines = [TargetMachines]()
        if let targetMachinesArray = dictionary["targetMachines"] as? [[String:Any]]{
            for dic in targetMachinesArray{
                let value = TargetMachines(fromDictionary: dic)
                targetMachines.append(value)
            }
        }
        if let typeData = dictionary["type"] as? [String:Any]{
            type = Type(fromDictionary: typeData)
        }
        version = dictionary["version"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if communicationProtocols != nil {
            var dictionaryElements = [[String:Any]]()
            for communicationProtocolsElement in communicationProtocols {
                dictionaryElements.append(communicationProtocolsElement.toDictionary())
            }
            dictionary["communicationProtocols"] = dictionaryElements
        }
        if id != nil{
            dictionary["id"] = id
        }
        if ipAddress != nil{
            dictionary["ipAddress"] = ipAddress
        }
        if ipSubnetMask != nil{
            dictionary["ipSubnetMask"] = ipSubnetMask
        }
        if location != nil{
            dictionary["location"] = location
        }
        if locationId != nil{
            dictionary["locationId"] = locationId
        }
        if model != nil{
            dictionary["model"] = model.toDictionary()
        }
        if name != nil{
            dictionary["name"] = name
        }
        if serialNum != nil{
            dictionary["serialNum"] = serialNum
        }
        if serialNumber != nil{
            dictionary["serialNumber"] = serialNumber
        }
        if status != nil{
            dictionary["status"] = status.toDictionary()
        }
        if targetMachines != nil{
            var dictionaryElements = [[String:Any]]()
            for targetMachinesElement in targetMachines {
                dictionaryElements.append(targetMachinesElement.toDictionary())
            }
            dictionary["targetMachines"] = dictionaryElements
        }
        if type != nil{
            dictionary["type"] = type.toDictionary()
        }
        if version != nil{
            dictionary["version"] = version
        }
        return dictionary
    }
    
}
