//
//  RefeicaoDAO.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 19/10/20.
//

import Foundation

class RefeicaoDao {
    func save(_ refeicoes: [Refeicao]) {
        guard let diretorio = recuperaDiretorio() else {return}        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: diretorio)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let caminho = diretorio.appendingPathComponent("refeicoes")
        return caminho
    }
    
    func recupera() -> [Refeicao]{
        guard let diretorio = recuperaDiretorio() else {return []}
        do {
            let dados = try Data(contentsOf: diretorio)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {return []}
            return refeicoesSalvas
        }
        catch{
            print(error.localizedDescription)
            return[]
        }
    }
}
