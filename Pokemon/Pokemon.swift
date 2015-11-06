//
//  Pokemon.swift
//  Pokemon
//
//  Created by muratcakmak on 06/11/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokemonID: Int!
    
    var name: String{
        return _name
    }
    
    var pokemonID: Int{
        return _pokemonID
    }
    
    init(name: String, pokemonID: Int){
        self._name = name
        self._pokemonID = pokemonID
    }
    
    
}