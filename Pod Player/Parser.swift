//
//  Parser.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Foundation

class Parser {
    
    func getPodcastMetaData(data:Data) -> (title: String?, imageURL: String?) {
        let xml = SWXMLHash.parse(data)
        
//        print(xml["rss"]["channel"]["title"].element?.text as Any)
        
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text as Any)
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
    }
    
    func getEpisodes(data: Data) -> [Episode] {
        
        let xml = SWXMLHash.parse(data)
        
        var episodes : [Episode] = []
        
        for item in xml["rss"]["channel"]["item"] {
            let episode = Episode()
            if let title = item["title"].element?.text {
                episode.title = title
            }
            if let htmlDescription = item["description"].element?.text {
                episode.htmlDescription = htmlDescription
            }
            if let audioURL = item["link"].element?.text {
                episode.audioURL = audioURL
            }
            if let pubDate = item["pubDate"].element?.text {
                if let date = Episode.formatter.date(from: pubDate) {
                episode.pubDate = date
                }
            }
            
            episodes.append(episode)
            print(episode.pubDate)
            
        }
        
        return episodes
    }
}
