//
//  JSONParser.swift
//  LickabilityCodingChallenge
//
//  Created by Robert Deans on 4/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class JSONParser {
    
    
    static func getDictionary(from jsonFilename: String, completion: @escaping ([[String : Any]]) -> Void) {
        guard let filePath = Bundle.main.path(forResource: jsonFilename, ofType: "json") else { print("error unwrapping json file path"); return }
        
        do {
            let data = try NSData(contentsOfFile: filePath, options: NSData.ReadingOptions.uncached)
            
            guard let pictureDictionary = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String : Any]] else { print("error typecasting json dictionary"); return }
            
            completion(pictureDictionary)
        } catch {
            print("error reading data from file in json serializer")
        }
    }
    
}
