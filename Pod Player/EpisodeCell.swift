//
//  EpisodeCell.swift
//  Pod Player
//
//  Created by Mitch Guzman on 3/19/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa
import WebKit

class EpisodeCell: NSTableCellView {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionWebView: WebView!
    @IBOutlet weak var pubDateLabel: NSTextField!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
