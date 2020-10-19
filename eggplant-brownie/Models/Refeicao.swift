//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 14/10/20.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    
    
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
    
    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(felicidade,forKey: "felicidade")
        aCoder.encode(itens, forKey: "itens")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nome = aDecoder.decodeObject(forKey: "nome") as! String
        felicidade = aDecoder.decodeInteger(forKey: "felicidade")
        itens = aDecoder.decodeObject(forKey: "itens") as! Array<Item>
    }
    
    // MARK: - Métodos
    func totalDeCalorias() -> Double {
        var totalCalorias = 0.0
        for item in itens {
            totalCalorias+=item.calorias
        }
        return totalCalorias
    }
    
    func detalher() -> String {
        var mensagem = "Felicidade: \(felicidade)"
        for item in itens {
            mensagem += ", \(item.nome) - Calorias: \(item.calorias)"
        }
        return mensagem
    }
}
