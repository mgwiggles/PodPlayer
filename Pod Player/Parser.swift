//
//  Parser.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Foundation

class Parser {
    
    func getPodcastMetaData(data:Data) {
        let xml = SWXMLHash.parse(data)
        
        print(xml)
    }
}
