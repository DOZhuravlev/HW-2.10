//
//  NetworkManager.swift
//  HW 2.10
//
//  Created by Zdrenko Zigich on 28.06.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(urlMain: String, completion: @escaping(Result<[Character], NetworkError>) -> ()) {
       guard let url = URL(string: urlMain) else {
           completion(.failure(.invalidUrl))
           return }
        
       URLSession.shared.dataTask(with: url) { data, _, error in
           guard let data = data else {
               completion(.failure(.noData))
               print(error ?? "Error!!!!!!!")
               return
           }
           
           do {
               let product = try JSONDecoder().decode([Character].self, from: data)
               DispatchQueue.main.async {
                   completion(.success(product))
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
    
    func fetchCharacterWithAlamofire(urlMain: String, completion: @escaping(Result<[Character], NetworkError>) -> ()) {
        AF.request(urlMain)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters = Character.getCharacters(from: value)
                    DispatchQueue.main.async {
                        completion(.success(characters))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
    func fetchImageWithAlamofire(urlMain: String, completion: @escaping (Data) -> ()) {
        AF.request(urlMain)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
                
            }
    }
}
