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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var typePoke: UILabel!
    @IBOutlet weak var defensePoke: UILabel!
    @IBOutlet weak var heightPoke: UILabel!
    @IBOutlet weak var weightPoke: UILabel!
    @IBOutlet weak var descriptionPoke: UILabel!
    @IBOutlet weak var nextEvo: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    
    @IBOutlet weak var leftBottomImage: UIImageView!
    @IBOutlet weak var rightBottomImage: UIImageView!
    
    
    
    
    var pokemon = Pokemon!()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl.text = pokemon.name

        
    
    }

    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }


}
