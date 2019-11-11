//
//  ManufacturerCell.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ManufacturerCell: UITableViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ code: String?, _ name: String?, _ row: Int) {
        self.codeLabel.text = "Code: \(code ?? "")"
        self.nameLabel.text = "Name: \(name  ?? "")"
        self.backgroundColor = row % 2 == 0 ? UIColor.white : UIColor.blue.withAlphaComponent(0.3)
    }
}
