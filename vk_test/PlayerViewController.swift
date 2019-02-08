//
//  PlayerViewController.swift
//  vk_test
//
//  Created by Артем Закиров on 08.02.2019.
//  Copyright © 2019 bmstu. All rights reserved.
//

import Foundation
import UIKit
import AVKit


class PlayerViewController : UIViewController{
    var video = Video(title: "", duration: 0, picture: UIImage(), urlVid: URL(fileURLWithPath: ""))
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
//        var infoLabel = UIView()
//        self.view.addSubview(infoLabel)
//        infoLabel.backgroundColor = .red
        let url = video.urlVid
//        let assets = AVURLAsset(url: url!, options: nil)
//        let playMe = AVPlayerItem(asset: assets)
//        playMe.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(rawValue: NSKeyValueObservingOptions.initial.rawValue | NSKeyValueObservingOptions.new.rawValue), context: nil)
//        var playER = AVPlayer.init(playerItem: playMe)
//        playER.play()
        
        let player = AVPlayer(url: url)
        let avpCon = AVPlayerViewController()
        avpCon.player = player
        avpCon.view.frame.size.height = self.view.frame.size.height
        avpCon.view.frame.size.width = self.view.frame.size.width
        self.view.addSubview(avpCon.view)
        player.play()
//        var infoLabel = UILabel()
//        infoLabel.text = video.title
//        view.addSubview(infoLabel)
//        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        let horizontal = NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
//        let vert = NSLayoutConstraint(item: infoLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
//        let width = NSLayoutConstraint(item: infoLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 100)
//        infoLabel.backgroundColor = UIColor(patternImage: video.picture)
//        infoLabel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        infoLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        infoLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        infoLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
//        let height = NSLayoutConstraint(item: infoLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.5, constant: 100)
        
//        let constrains: [NSLayoutConstraint] = [horizontal, vert,width,height]
//        NSLayoutConstraint.activate(constrains)
    }
    }

