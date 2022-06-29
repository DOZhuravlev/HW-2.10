//
//  CollectionViewController.swift
//  HW 2.10
//
//  Created by Zdrenko Zigich on 23.06.2022.
//

import UIKit

class CharacterListViewController: UICollectionViewController {
    
    private let urlName = "http://hp-api.herokuapp.com/api/characters"
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UserActionCell
        
        cell.actionLabel.text = characters[indexPath.item].name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let characterIndex = characters[indexPath.row]
        
        performSegue(withIdentifier: "showCharacter", sender: characterIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? AboutCharacterViewController else { return }
        viewController.character = sender as? Character
        }
    
    private func fetchCharacter() {
        NetworkManager.shared.fetchCharacter(urlMain: urlName) { characters in
            self.characters = characters
            self.collectionView.reloadData()
        }
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
    }
}


