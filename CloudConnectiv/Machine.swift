//
//  Machine.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import Foundation

struct Machine {
    
    var content : [Content]!
    var first : Bool!
    var last : Bool!
    var number : Int!
    var numberOfElements : Int!
    var size : Int!
    var sort : AnyObject!
    var totalElements : Int!
    var totalPages : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        content = [Content]()
        if let contentArray = dictionary["content"] as? [[String:Any]]{
            for dic in contentArray{
                let value = Content(fromDictionary: dic)
                content.append(value)
            }
        }
        first = dictionary["first"] as? Bool
        last = dictionary["last"] as? Bool
        number = dictionary["number"] as? Int
        numberOfElements = dictionary["numberOfElements"] as? Int
        size = dictionary["size"] as? Int
        sort = dictionary["sort"] as? AnyObject
        totalElements = dictionary["totalElements"] as? Int
        totalPages = dictionary["totalPages"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if content != nil{
            var dictionaryElements = [[String:Any]]()
            for contentElement in content {
                dictionaryElements.append(contentElement.toDictionary())
            }
            dictionary["content"] = dictionaryElements
        }
        if first != nil{
            dictionary["first"] = first
        }
        if last != nil{
            dictionary["last"] = last
        }
        if number != nil{
            dictionary["number"] = number
        }
        if numberOfElements != nil{
            dictionary["numberOfElements"] = numberOfElements
        }
        if size != nil{
            dictionary["size"] = size
        }
        if sort != nil{
            dictionary["sort"] = sort
        }
        if totalElements != nil{
            dictionary["totalElements"] = totalElements
        }
        if totalPages != nil{
            dictionary["totalPages"] = totalPages
        }
        return dictionary
    }
    
}
