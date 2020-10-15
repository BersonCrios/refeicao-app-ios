//
//  Item.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 14/10/20.
//

import UIKit

class Item: NSObject {
    // MARK: - Atributos
    let nome: String
    let calorias: Double
    
    // MARK: - Método Construtor
    init(_ nome: String, _ calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
