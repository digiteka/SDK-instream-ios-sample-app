//
//  ViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import UIKit
import InStreamSDK

class DemoViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "MockTableViewCell", bundle: nil), forCellReuseIdentifier: "MockTableViewCell")
            tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        }
    }
    
    private var visiblePlayerView: VisiblePlayerView?
    private var videoCell: VideoTableViewCell?
    private var autoplay: Autoplay!
    private var visiblePlayer: Bool!
    private var visiblePlayerPosition: VisiblePlayerPosition!
    private var visiblePlayerWidth: CGFloat!
    
    convenience init(autoplay: String, visiblePlayer: Bool, visiblePlayerPosition: VisiblePlayerPosition, visiblePlayerWidth: Bool) {
        self.init()
        switch autoplay {
        case "1":
            self.autoplay = .auto
        case "2":
            self.autoplay = .scroll
        default:
            self.autoplay = .user
        }
        self.visiblePlayer = visiblePlayer
        self.visiblePlayerPosition = visiblePlayerPosition
        self.visiblePlayerWidth = visiblePlayerWidth ? 0.5 : 0.33
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if visiblePlayer {
            visiblePlayerView = InStream.shared.getVisiblePlayerView(in: self.view, scrollView: tableView, playerPosition: visiblePlayerPosition, widthPercent: visiblePlayerWidth, ratio: "16:9", horizontalMargin: 20.0, verticalMargin: 30.0)
            visiblePlayerView?.isHidden = true
        }
    }

}


// MARK: UITableViewDataSource
extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
            cell.setupCell(autoplay: autoplay)
            videoCell = cell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MockTableViewCell", for: indexPath)
        if let _cell = cell  as? MockTableViewCell {
            _cell.displayText("Ligne \(indexPath.row), 1\nLigne \(indexPath.row), 2\nLigne \(indexPath.row), 3\nLigne \(indexPath.row), 4")
            return _cell
        }
        return UITableViewCell()
    }
}


// MARK: UITableViewDelegate
extension DemoViewController: UITableViewDelegate {}


// MARK: UIScrollViewDelegate
extension DemoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let videoCell = videoCell, let videoView = videoCell.videoView {
            visiblePlayerView?.viewDidScroll(videoView: videoView)
        }
    }
}
