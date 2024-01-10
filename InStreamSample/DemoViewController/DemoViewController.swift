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
    
    private var visiblePlayer: VisiblePlayer?
    private var videoCell: VideoTableViewCell?
    private var playMode: PlayMode!
    private var hasVisiblePlayer: Bool!
    private var visiblePlayerPosition: VisiblePlayerPosition!
    private var visiblePlayerWidth: CGFloat!
    
    convenience init(playMode: String, hasVisiblePlayer: Bool, visiblePlayerPosition: VisiblePlayerPosition, visiblePlayerWidth: Bool) {
        self.init()
        switch playMode {
        case "1":
            self.playMode = .auto
        case "2":
            self.playMode = .scroll
        default:
            self.playMode = .user
        }
        self.hasVisiblePlayer = hasVisiblePlayer
        self.visiblePlayerPosition = visiblePlayerPosition
        self.visiblePlayerWidth = visiblePlayerWidth ? 0.5 : 0.33
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if hasVisiblePlayer {
            visiblePlayer = InStream.shared.initVisiblePlayerWith(config: DTKISVisiblePlayerConfig(playerPosition: visiblePlayerPosition, widthPercent: visiblePlayerWidth, ratio: "16:9", horizontalMargin: 20.0, verticalMargin: 30.0), in: self.view, scrollView: tableView)
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
            cell.setUp(playMode: playMode)
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
            visiblePlayer?.viewDidScroll(videoView: videoView)
            videoView.viewDidScroll(scrollView: tableView)
        }
    }
}
