//
//  ViewController.swift
//  HW 2.10
//
//  Created by Zdrenko Zigich on 22.06.2022.
//

import UIKit

class AboutCharacterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFilms: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var character: Character!
    var aboutPerson: String {
        """
        Персонаж - \(character.name ?? "")
        Имя актера - \(character.actor ?? "")
        Факультет - \(character.house ?? "")
        Пол - \(character.gender ?? "")
        """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        // fetchImage()
        fetchImageWithAlamofire()
        labelFilms.text = aboutPerson
        activityIndicator.hidesWhenStopped = true
    }
    
   private func fetchImage() {
        guard let picture = NetworkManager.shared.fetchImage(from: character.image ?? "") else { return }
        guard let image = UIImage(data: picture) else { return }
        
        DispatchQueue.main.async {
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func fetchImageWithAlamofire() {
        NetworkManager.shared.fetchImageWithAlamofire(urlMain: character.image ?? "", completion: { imageData in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
                }
            }
        )
    }
}


