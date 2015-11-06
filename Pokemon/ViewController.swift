//
//  ViewController.swift
//  Pokemon
//
//  Created by muratcakmak on 06/11/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionViewPokemon: UICollectionView!
    @IBOutlet weak var musicButtonImage: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    
    var inEditingMode = false
    
    var resultPokemons = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewPokemon.delegate = self
        collectionViewPokemon.dataSource = self
        searchBar.delegate = self
        parserCSVtoArray()
        
        searchBar.returnKeyType = UIReturnKeyType.Done
        playMusic()
    }
    
    func playMusic(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicButtonImage.alpha = 0.2
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    
    }
    
    
    
    func parserCSVtoArray(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let pokemonID = Int(row["id"]!)!
                let pokemonName = row["identifier"]!
                let char = Pokemon(name: pokemonName, pokemonID: pokemonID)
                pokemon.append(char)
            
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionViewPokemon.dequeueReusableCellWithReuseIdentifier("PokemonCollectionVC", forIndexPath: indexPath) as? PokemonCollectionViewCell{
            
            if inEditingMode{
                cell.createCell(resultPokemons[indexPath.row])
            }else{
                cell.createCell(pokemon[indexPath.row])
            }
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var poke = Pokemon!()
        
        if inEditingMode {
            poke = resultPokemons[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("DetailViewController", sender: poke)
    }
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inEditingMode{
            return resultPokemons.count
        }
        return pokemon.count
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    @IBAction func musicButton(sender: UIButton!) {
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inEditingMode = false
            view.endEditing(true)
            collectionViewPokemon.reloadData()
        }else{
            inEditingMode = true
            let lower = searchBar.text!.lowercaseString
            resultPokemons = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collectionViewPokemon.reloadData()

            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewController" {
            if let detailVC = segue.destinationViewController as? DetailViewController{
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
            }
        
        }
    }
    
}

