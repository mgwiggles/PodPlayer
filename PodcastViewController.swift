//
//  PodcastViewController.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa

class PodcastViewController: NSViewController {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        
        if let url = URL(string: podcastURLTextField.stringValue) {
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                
                if error != nil {
                    print(error!)
                    
                } else {
                    
                    if data != nil {
                        let parser = Parser()
                        let info = parser.getPodcastMetaData(data: data!) 
                        
                    }
                    
                }
                
                }.resume()
            
            podcastURLTextField.stringValue = ""
            
        }
    }
}
