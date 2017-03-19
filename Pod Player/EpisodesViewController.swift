//
//  EpisodesViewController.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa
import AVFoundation

class EpisodesViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var pausePlayButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast : Podcast? = nil
    var podcastsVC : PodcastViewController? = nil
    var episodes : [Episode] = []
    var player : AVPlayer? = nil
    
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
                        self.episodes = parser.getEpisodes(data: data!)
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let episode = episodes[row]
        
        let cell = tableView.make(withIdentifier: "episodeCell", owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = episode.title
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            
            let episode = episodes[tableView.selectedRow]
            
                if let url = URL(string: episode.audioURL) {
                    player = AVPlayer(url: url)
                    
                    player?.play()
                }
 
        }
    }
    
}
