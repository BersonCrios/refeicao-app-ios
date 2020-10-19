//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Berson on 15/10/20.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AddRefeicaoDelegate  {
    
    var refeicoes: [Refeicao] = []
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        refeicoes = RefeicaoDao().recupera()
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
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes(_:)))
        cel.addGestureRecognizer(longPress)
        
        return cel
    }
    
    func add(_ refeicao: Refeicao){
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDao().save(refeicoes)
    }
    
    @objc func mostraDetalhes(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
 
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let caminho = diretorio.appendingPathComponent("refeicao")
        return caminho
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
