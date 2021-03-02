//
//  SettingCell.swift
//  MarvelApp
//
//  Created by оля on 01.03.2021.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!
    
    var sectionType: SectionType? {
        didSet{
            guard let sectionType = sectionType else { return }
            titleLabel.text = sectionType.description
            switcher.isHidden = !sectionType.containSwitch
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
