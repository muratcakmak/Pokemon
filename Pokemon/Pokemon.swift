//
//  Pokemon.swift
//  Pokemon
//
//  Created by muratcakmak on 06/11/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokemonID: Int!
    private var _description: String!
    private var _typePoke: String!
    private var _defensePoke: String!
    private var _heightPoke: String!
    private var _weightPoke: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionID: String!
    
    
    var name: String{
        return _name
    }
    
    var pokemonID: Int{
        return _pokemonID
    }
    
    var description: String{
        return _description
    }
    
    var typePoke: String{
        return _typePoke
    }
    var defensePoke: String{
        return _defensePoke
    }
    var heightPoke: String{
        return _heightPoke
    }
    var weightPoke: String{
        return _weightPoke
    }
    var nextEvolutionLevel: String{
        return _nextEvolutionLevel
    }
    var nextEvolutionText: String{
        return _nextEvolutionText
    }
    var nextEvolutionID: String {
        return _nextEvolutionID
    }
    var pokemonURL: String {
        return _pokemonURL
    }
    
    init(name: String, pokemonID: Int){
        self._name = name
        self._pokemonID = pokemonID
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokemonID)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonURL)
        
        Alamofire.request(.GET, url!).responseJSON {response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weightPoke = weight
                }
                if let height = dict["height"] as? String{
                    self._heightPoke = height
                }
                if let defense = dict["defense"] as? Int{
                    self._defensePoke = "\(defense)"
                }
                
                print(self._defensePoke)
                print(self._heightPoke)
                print(self._weightPoke)
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    let number = types.count
                    for var i = 0; i < number ; i+=1 {
                        if i == 0{
                            self._typePoke = types[i]["name"]?.capitalizedString
                        }else{
                            if let name = types[i]["name"]{
                                self._typePoke! += "/" + name.capitalizedString
                            }
                            
                        }
                        
                    }
                }else{
                    self._typePoke = ""
                }
                print(self._typePoke)
                
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>]{
                    if let descURL = descArr[0]["resource_uri"]{
                        let URL = URL_BASE + descURL
                        let nsurl = NSURL(string: URL)!
                        Alamofire.request(.GET, nsurl).responseJSON {response in
                            let descriptionResult = response.result
                            if let desc = descriptionResult.value?["description"] as? String {
                                self._description = desc
                            }
                            
                        }
                        
                    }
                
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0{
                    if let to = evolutions[0]["to"] as? String{
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let tempuri = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let id = tempuri.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionID = id
                                self._nextEvolutionText = to
                                print(self._nextEvolutionText)
                            }
                    
                        }else{
                            self._nextEvolutionID = ""
                        }
                        
                        if let level = evolutions[0]["level"] as? Int{
                            self._nextEvolutionLevel = "\(level)"

                        }else{
                            self._nextEvolutionLevel = ""
                        }
                        
                    }else{
                        self._nextEvolutionText = ""
                    }
                    

                
                }
                    
                }
            }
        
        }
    
        
        
    }
