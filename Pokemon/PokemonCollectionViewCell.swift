//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by muratcakmak on 06/11/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var pokemonTitle: UILabel!
    
    var pokemon = Pokemon!()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 7.0
        
    }
    
    func createCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        pokemonTitle.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokemonID)")
    
    }
    
    
}
