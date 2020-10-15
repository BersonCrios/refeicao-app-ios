//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 15/10/20.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AddRefeicaoDelegate  {
    
    var refeicoes = [
        Refeicao("macarrão", 4),
        Refeicao("Sushi", 4),
        Refeicao("Tacos", 3)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //DEFINE A QUANTIDADE DE CÉLULAS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    //DEFINE CONTEÚDO DAS CELULAR
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        cel.textLabel?.text = refeicao.nome
        return cel
    }
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    
    //Função responsável pela preparação para seguir da setinha do storyboard
    //Posso passar coisa para a tela que vai entar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as?
                ViewController {
                viewController.delegate = self
            }
        }
    }
}
