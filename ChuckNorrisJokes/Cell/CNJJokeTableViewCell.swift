//
//  CNJJokeTableViewCell.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 18/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//

import UIKit

class CNJJokeTableViewCell: UITableViewCell {

    @IBOutlet weak var jokeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(managedObject: CNJJokeManagedObject) {
        self.jokeLabel.text = managedObject.toString()
    }
}
