//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 16/10/20.
//

import UIKit

class Alerta{
    
    let controller: UIViewController
    
    init(_ controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ titulo: String = "atenção ", mensagem: String){
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
    
}
