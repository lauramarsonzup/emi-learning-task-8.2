//
//  AutoresListViewController.swift
//  LearningTask-8.2
//
//  Created by rafael.rollo on 20/06/2022.
//

import UIKit

class AutoresListViewController: UITableViewController {

    var autoresAPI: AutoresAPI?
    var livrosAPI: LivrosAPI?
    
    var autores: [Autor] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        // Do any additional setup after loading the view.
    
        setupViews()
        carregaAutores()
    }
    
    private func setupViews() {
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
    }

    func carregaAutores() {
        guard let autorAPI = autoresAPI else { return }
        self.autores = autorAPI.listaTodos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "seeAuthorDetailsSegue" else { return }
        
        guard let cell = sender as? AutorTableViewCell, let destinationController = segue.destination as? DetalhesDoAutorViewController else {
            fatalError("Não foi possível executar a segue")
        }
        
        destinationController.autor = cell.autor
        destinationController.livrosAPI = livrosAPI
    }

}

// MARK: - UITableViewDataSource Implementations
extension AutoresListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutorTableViewCell", for: indexPath) as? AutorTableViewCell else {
            fatalError("Não foi possível obter celula para a lista de autores")
        }
        
        let autor = autores[indexPath.row]
        cell.autor = autor
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate Implementations
extension AutoresListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de autores.")
        }
        
        headerView.titulo = "Todos os Autores"
        return headerView
    }
    
}

