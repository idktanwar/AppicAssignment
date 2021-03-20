//
//  FilterMainCell.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit

class FilterMainCell: UITableViewCell {

    
    @IBOutlet weak var lblFilterName: UILabel!
    @IBOutlet weak var lblFilterCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
