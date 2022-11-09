//
//  DetalhesDoAutorViewController.swift
//  LearningTask-8.2
//
//  Created by Laura Pinheiro Marson on 09/11/22.
//

import UIKit

class DetalhesDoAutorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var livrosAPI: LivrosAPI?
    
    var autor: Autor!
    var livros: [Livro] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        configuraTableView()
        carregarLivrosDoAutor()
    }
    
    private func configuraTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableHeaderView = AutorTableHeaderView.constroi(para: autor)
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func carregarLivrosDoAutor() {
        guard let livrosAPI = livrosAPI else { return }
        livros = livrosAPI.carregaLivros(por: autor)
    }

}

extension DetalhesDoAutorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return livros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LivroDoAutorViewCell", for: indexPath) as? LivroDoAutorViewCell else {
            fatalError("Não foi possível carregar célula do livro")
        }
        
        cell.livro = livros[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível carregar a header view")
        }

        header.titulo = "Livros publicados"
        return header
    }
    
}

extension DetalhesDoAutorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
//            fatalError("Não foi possível carregar a header view")
//        }
//
//        header.titulo = "Livros publicados"
//        return header
//    }
}


