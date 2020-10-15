//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 13/10/20.
//

import UIKit

protocol AddRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemDelegate{

    //MARK: - Atributos
    //Instancia a viewcontroller que preciso chaar o metodo de add
    var delegate: AddRefeicaoDelegate?
    var itens: [Item] = [Item("Molho de tomate", 40.0), Item("Queijo", 20.2), Item("Molho Apimentado", 120.4), Item("Manjericao", 30.7)]
    
    var itensSelecionado: [Item] = []
     
    //MARK: - IBOutlets
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTabView: UITableView!
    
    //MARK: - View Life Cycler
    override func viewDidLoad() {
        super.viewDidLoad()
        let botaoAddItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = botaoAddItem
    }
    
    @objc func addItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTabView.reloadData()
        
    }
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell(style: .default, reuseIdentifier: nil)
        cel.textLabel?.text = itens[indexPath.row].nome
        return cel
    }
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cel = tableView.cellForRow(at: indexPath) else {return}
        if cel.accessoryType == .none {
            itensSelecionado.append(itens[indexPath.row])
            cel.accessoryType = .checkmark
        }
        else{
            cel.accessoryType = .none
            let item = itens[indexPath.row]
            if let position = itensSelecionado.firstIndex(of: item) {
                itensSelecionado.remove(at: position)
            }
        }
    }

    //MARK: - IBActions 
    @IBAction func adicionar(_ sender: Any) {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return
        }
                
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
                
        let refeicao = Refeicao(nomeDaRefeicao, felicidade, itensSelecionado)
        
        refeicao.itens = itensSelecionado
        
        print("comi \(refeicao.nome) e fiquei com felicidade: \(refeicao.felicidade)")
        
        delegate?.add(refeicao)
        //Add viewController
        navigationController?.popViewController(animated: true)
    }
}

