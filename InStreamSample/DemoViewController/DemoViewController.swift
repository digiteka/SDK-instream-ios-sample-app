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
    private var videoView: VideoView?
    private var videoCell: VideoTableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        visiblePlayerView = InStream.shared.getVisiblePlayerView(in: self.view, delegate: self, playerPosition: .TOP_START, widthPercent: 0.5, ratio: "16:9", horizontalMargin: 20.0, verticalMargin: 30.0)
        visiblePlayerView?.isHidden = true
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
        if let videoCell = videoCell {
            if videoView == nil && !tableView.visibleCells.contains(videoCell) {
                if let visiblePlayerView = visiblePlayerView, !visiblePlayerView.hasBeenClosed {
                    videoCell.videoView?.setInVisiblePlayer(containerView: visiblePlayerView)
                }
                videoView = videoCell.videoView
                visiblePlayerView?.isHidden = false
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100 + 12 * 2, right: 0)
            } else if let videoView = videoView, !videoView.wasInCell, tableView.visibleCells.contains(videoCell) {
                videoCell.setVideoView(videoView)
                self.videoView = nil
                visiblePlayerView?.isHidden = true
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
}

// MARK: VisiblePlayerDelegate
extension DemoViewController: VisiblePlayerDelegate {
    func didCloseVisiblePlayer() {
        if let videoView = videoView, let videoCell = videoCell {
            videoCell.didcloseVisiblePlayer(videoView)
            self.videoView = nil
            visiblePlayerView?.isHidden = true
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
