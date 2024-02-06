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
    private var visiblePlayerWidth: WidthProportion!
    private var ratio: Ratio!
    
    convenience init(playMode: PlayMode, hasVisiblePlayer: Bool, visiblePlayerPosition: VisiblePlayerPosition, visiblePlayerWidth: WidthProportion, ratio: Ratio) {
        self.init()
        self.playMode = playMode
        self.hasVisiblePlayer = hasVisiblePlayer
        self.visiblePlayerPosition = visiblePlayerPosition
        self.visiblePlayerWidth = visiblePlayerWidth
        self.ratio = ratio
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if hasVisiblePlayer {
            visiblePlayer = InStream.shared.initVisiblePlayerWith(config: DTKISVisiblePlayerConfig(playerPosition: visiblePlayerPosition, widthPercent: visiblePlayerWidth, ratio: ratio, horizontalMargin: 20.0, verticalMargin: 30.0), in: self.view)
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
            _cell.displayText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
        if let videoCell = videoCell, let videoView = videoCell.mainPlayerView {
            visiblePlayer?.viewDidScroll(mainPlayerView: videoView, scrollView: scrollView)
            videoView.viewDidScroll(scrollView: tableView)
        }
    }
}
