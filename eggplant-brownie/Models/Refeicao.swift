//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 14/10/20.
//

import UIKit

class Refeicao: NSObject {
    // MARK: - Atributos
    var nome: String
    var felicidade: Int
    var itens: Array<Item> = []
    
    // MARK: - Método Construtor
    init(_ nome: String, _ felicidade: Int, _ itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    // MARK: - Métodos
    func totalDeCalorias() -> Double {
        var totalCalorias = 0.0
        for item in itens {
            totalCalorias+=item.calorias
        }
        return totalCalorias
    }
}
