//
//  ViewController.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "MockTableViewCell", bundle: nil), forCellReuseIdentifier: "MockTableViewCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MockTableViewCell", for: indexPath)
        if let _cell = cell  as? MockTableViewCell {
            _cell.displayText()
            return _cell
        }
        return UITableViewCell()
    }
}


extension ViewController: UITableViewDelegate {}
