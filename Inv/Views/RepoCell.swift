//
//  RepoCell.swift
//  Inv
//
//  Created by Александр Гаврилов on 24.02.2021.
//

import UIKit

class RepoCell: UITableViewCell {
    
    let name = UILabel()
    let specification = UILabel()
    let language = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        let repoTitle = UILabel()
        repoTitle.textColor = UIColor(displayP3Red: 36/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)
        repoTitle.text = "Title: "
        
        let repoLanguage = UILabel()
        repoLanguage.textColor = UIColor(displayP3Red: 36/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)
        repoLanguage.text = "Language: "
        
        name.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        language.textColor = UIColor(displayP3Red: 255/255.0, green: 172/255.0, blue: 70/255.0, alpha: 1)
        language.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        
        specification.textColor = UIColor(displayP3Red: 86/255.0, green: 95/255.0, blue: 104/255.0, alpha: 1)
        specification.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        specification.textAlignment = .left
        specification.adjustsFontSizeToFitWidth = true
        specification.minimumScaleFactor = 0.01
        specification.contentMode = .scaleAspectFit
        specification.lineBreakMode = .byTruncatingTail
        specification.numberOfLines = 5
        specification.sizeToFit()
        
        [repoTitle, name, specification, repoLanguage, language].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
           
            contentView.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            repoTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            repoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            name.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: repoTitle.trailingAnchor, constant: 5),
            
            repoLanguage.topAnchor.constraint(equalTo: repoTitle.bottomAnchor, constant: 20),
            repoLanguage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            language.centerYAnchor.constraint(equalTo: repoLanguage.centerYAnchor, constant: 0),
            language.leadingAnchor.constraint(equalTo: repoLanguage.trailingAnchor, constant: 5),
            
            specification.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            specification.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            specification.topAnchor.constraint(equalTo: repoLanguage.bottomAnchor, constant: 20),
//            specification.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        contentView.updateConstraints()
    }
}
