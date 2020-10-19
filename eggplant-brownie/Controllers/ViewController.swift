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
    var itens: [Item] = []
    
    var itensSelecionado: [Item] = []
     
    //MARK: - IBOutlets
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    @IBOutlet weak var itensTableView: UITableView?

    //MARK: - View Life Cycler
    override func viewDidLoad() {
        super.viewDidLoad()
        let botaoAddItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = botaoAddItem
        
        itens = ItemDao().recupera()
    }
    
    @objc func addItem(){
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
           itens.append(item)
           if let tableView = itensTableView {
               tableView.reloadData()
           } else {
            Alerta(self).exibe(mensagem: "Não foi possivel att a tabela")
           }
        ItemDao().save(itens)
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

    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
        }
                
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
                
        let refeicao = Refeicao(nomeDaRefeicao, felicidade, itensSelecionado)
        
        refeicao.itens = itensSelecionado
        
        return refeicao
    }
    
    //MARK: - IBActions 
    @IBAction func adicionar(_ sender: Any) {
        guard let refeicao = recuperaRefeicaoDoFormulario() else {
            Alerta.init(self).exibe(mensagem: "Erro ao ler a dados do usuário")
            return
            
        }
        delegate?.add(refeicao)
        //Add viewController
        navigationController?.popViewController(animated: true)
    }
}

