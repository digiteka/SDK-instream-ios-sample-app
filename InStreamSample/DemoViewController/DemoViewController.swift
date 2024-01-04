//
//  ViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import UIKit

class DemoViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "MockTableViewCell", bundle: nil), forCellReuseIdentifier: "MockTableViewCell")
            tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        }
    }
    private var mockVideoView: UIView?
    
    private var shouldStickVideo: Bool!
    
    convenience init(_ shouldStickVideo: Bool = true) {
        self.init()
        self.shouldStickVideo = shouldStickVideo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


// MARK: UITableViewDataSource
extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 15 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
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


