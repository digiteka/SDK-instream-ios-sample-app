//
//  MockTableViewCell.swift
//  InStreamSample
//
//  Created by ARoussel on 03/01/2024.
//

import Foundation
import UIKit

class MockTableViewCell: UITableViewCell {
    @IBOutlet private weak var mockTextLabel: UILabel!
    
    func displayText() {
        mockTextLabel.text = "Ligne 1\nLigne 2\nLigne 3"
    }
}
