//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 19/10/20.
//

import Foundation

class ItemDao {
    func save(_ itens: [Item]) {
        guard let diretorio = recuperaDiretorio() else {return}
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            try dados.write(to: diretorio)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let caminho = diretorio.appendingPathComponent("itens")
        return caminho
    }
    
    func recupera() -> [Item]{
        guard let diretorio = recuperaDiretorio() else {return []}
        do {
            let dados = try Data(contentsOf: diretorio)
            guard let itemSalvo = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Item> else {return []}
            return itemSalvo
        }
        catch{
            print(error.localizedDescription)
            return[]
        }
    }
}
