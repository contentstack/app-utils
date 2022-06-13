//
//  File.swift
//  
//
//  Created by Uttam Ukkoji on 01/06/22.
//

import Foundation
import image_transform

class JSONParser {
    static func parse(from json: String) -> AssetModel {
        let data = json.data(using: .utf8)
        return try! JSONDecoder().decode(AssetModel.self, from: data!)
    }
}
