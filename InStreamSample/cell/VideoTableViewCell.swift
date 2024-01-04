//
//  VideoTableViewCell.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit
import InStreamSDK

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoViewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let urlString = "https://www.ultimedia.com/deliver/generic/iframe/mdtk/01357940/src/pqvp3r/zone/1/showtitle/1/gdprconsentstring/BOj8iv4Oj8iwYAHABAlxCS-AAAAnF7_______9______9uz_Ov_v_f__33e87_9v_l_7_-___u_-3zd4-_1vf99yfm1-7etr3tp_87ues2_Xur__59__3z3_9phPrsk89r633A/idfa/2D2859BC-7FB6-4225-A3E8-EED25341CA93?urlfacebook=[URL_REFERER]&tagparamdecoded=video_app&sa=D&ust=1586938702508000&usg=AOvVaw0EoSE28fXl4HfVg-fQrA4n"
        let url = URL(string: urlString)!

        let videoPlayerView = VideoView.AddVideoViewIn(withURL: url)
        videoPlayerView.setIn(containerView: videoViewContainer)
    }
}
