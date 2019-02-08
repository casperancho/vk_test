//
//  VIdeoCell.swift
//  vk_test
//
//  Created by Артем Закиров on 08.02.2019.
//  Copyright © 2019 bmstu. All rights reserved.
//

import Foundation
import UIKit

class VideoCell : UITableViewCell{
    var time = ""
    func formatTime(duration: Int){
        let hours = ((duration % 86400) / 3600)
        let minutes = ((duration % 3600) / 60)
        let sec = ((duration % 3600) % 60)
        if minutes == 0{
            time = "\(sec)с"
        }else if hours==0 {
            time = "\(minutes)м\(sec)с"
        }else{
            time = "\(hours)ч\(minutes)м\(sec)с"
        }
//     print(time)
    }
    var video : Video? {
        didSet {
        videoTitleLabel.text = video?.title
        self.formatTime(duration: (video?.duration)!)
        videoDuration.text = time
        videoImage.image = video?.picture
        }
    }
    
    private let videoTitleLabel : UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let videoDuration : UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let videoImage : UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
        return imageV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(videoImage)
        addSubview(videoDuration)
        addSubview(videoTitleLabel)
       
        
        videoImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        videoTitleLabel.anchor(top: topAnchor, left: videoImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 1.2 , height: 0, enableInsets: false)
        videoDuration.anchor(top: videoTitleLabel.bottomAnchor, left: videoImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 1.2, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
