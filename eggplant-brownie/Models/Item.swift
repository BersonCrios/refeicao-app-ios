//
//  Item.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 14/10/20.
//

import UIKit

class Item: NSObject, NSCoding {
    // MARK: - Atributos
    let nome: String
    let calorias: Double
    
    // MARK: - Método Construtor
    init(_ nome: String, _ calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
    
    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(calorias,forKey: "calorias")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nome = aDecoder.decodeObject(forKey: "nome") as! String
        calorias = aDecoder.decodeDouble(forKey: "calorias")
    }
}
