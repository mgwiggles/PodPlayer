//
//  EpisodesViewController.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa

class EpisodesViewController: NSViewController {
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var pausePlayButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast : Podcast? = nil
    var podcastsVC : PodcastViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        if podcast?.title != nil {
            titleLabel.stringValue = podcast!.title!
        } else {
            titleLabel.stringValue = ""
        }
        
        if podcast?.imageURL != nil {
            
            let image = NSImage(byReferencing: URL(string: (podcast?.imageURL!)!)!)
            
            imageView.image = image
        } else {
            imageView.image = nil
        }
        
        pausePlayButton.isHidden = true
        
        getEpisodes()
        
    }
    
    func getEpisodes() {
        if podcast?.rssURL != nil {
            
            if let url = URL(string: podcast!.rssURL!) {
            
            
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                
                if error != nil {
                    print(error!)
                    
                } else {
                    
                    if data != nil {
                        let parser = Parser()
                        let episodes = parser.getEpisodes(data: data!)
                        print(episodes)
                        
                    }
                    
                }
                
                }.resume()
            }
            
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        if podcast != nil {
            
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
                
                context.delete(podcast!)
                
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                
                podcastsVC?.getPodcasts()
                
                podcast = nil
                updateView()
            }
        }
    }
    
    @IBAction func pausePlayClicked(_ sender: Any) {
    }
}
