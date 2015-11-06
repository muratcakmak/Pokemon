//
//  DetailViewController.swift
//  Pokemon
//
//  Created by muratcakmak on 06/11/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var lbl: UILabel!
    var pokemon = Pokemon!()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl.text = pokemon.name

        
    
    }

    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }


}
