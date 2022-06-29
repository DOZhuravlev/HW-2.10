//
//  NetworkManager.swift
//  HW 2.10
//
//  Created by Zdrenko Zigich on 28.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(urlMain: String, completion: @escaping([Character]) -> ()) {
       guard let url = URL(string: urlMain) else { return }
        
       URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data else {
               print(error ?? "Error!!!!!!!")
               return
           }
           
           do {
               let product = try JSONDecoder().decode([Character].self, from: data)
               DispatchQueue.main.async {
                   completion(product)
               }
           } catch let error {
               print(error)
           }
       }.resume()
   }
    
    func fetchImage(from urlImage: String?) -> Data? {
        guard let imageUrl = URL(string: urlImage ?? "") else { return nil }
        return try? Data(contentsOf: imageUrl)
    }
}
