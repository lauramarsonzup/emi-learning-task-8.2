//
//  LivroDoAutorViewCell.swift
//  LearningTask-8.2
//
//  Created by Laura Pinheiro Marson on 09/11/22.
//

import UIKit

class LivroDoAutorViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }
            
            titleLabel.text = livro.titulo
            bookImageView.image = .init(livro.imagemDeCapaURI, aspectFillIn: bookImageView.bounds)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .texasRose.withAlphaComponent(0.3)
        selectedBackgroundView = bgColorView
    }
}
