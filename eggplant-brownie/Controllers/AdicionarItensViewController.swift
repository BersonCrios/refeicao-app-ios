//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 15/10/20.
//

import UIKit

protocol AddItemDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    //MARK: -IBOutlets
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextFiel: UITextField!
    
    //MARK: - Atributos
    var delegate: AddItemDelegate?
    
    
    init(delegate: AddItemDelegate) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeTextField.text, let calorias = caloriasTextFiel.text
        else{
            return
        }
        guard let numeroDeCalorias = Double(calorias) else {
            return
        }
        let item = Item(nome, numeroDeCalorias)
        delegate?.add(item)
        navigationController?.popViewController(animated: true)
    }
    
}
