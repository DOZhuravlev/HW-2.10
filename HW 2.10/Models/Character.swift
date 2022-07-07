//
//  Character.swift
//  HW 2.10
//
//  Created by Zdrenko Zigich on 23.06.2022.
//


struct Character: Decodable {
    let name: String?
    let house: String?
    let actor: String?
    let image: String?
    let gender: String?
    
    init(characterData: [String: Any]) {
        name = characterData["name"] as? String
        house = characterData["house"] as? String
        actor = characterData["actor"] as? String
        image = characterData["image"] as? String
        gender = characterData["gender"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else {
            return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
}
