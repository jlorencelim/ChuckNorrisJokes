//
//  CNJJokeDetailViewController.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 21/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//

import UIKit

class CNJJokeDetailViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    var managedObject:CNJJokeManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.jokeLabel.text = managedObject!.content
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
