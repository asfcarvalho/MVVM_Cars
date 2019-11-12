//
//  ModelCell.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ModelCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ name: String?, _ row: Int) {
        self.nameLabel.text = "Name: \(name  ?? "")"
        self.backgroundColor = row % 2 == 0 ? UIColor.white : UIColor.blue.withAlphaComponent(0.3)
    }
    
}
