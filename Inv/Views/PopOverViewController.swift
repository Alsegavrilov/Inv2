//
//  PopOverViewController.swift
//  Inv
//
//  Created by Александр Гаврилов on 24.02.2021.
//

import UIKit

protocol PopOverDelegate: class {
    func saveRepo()
}

class PopOverViewController: UIViewController {
    
    var link: String?
    
    init(link: String?) {
        super.init(nibName: nil, bundle: nil)
        
        self.link = link
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: PopOverDelegate?
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor(displayP3Red: 46/255.0, green: 164/255.0, blue: 79/255.0, alpha: 0.4)
        
        let addButton = UIButton()
        addButton.setImage(UIImage(systemName: "books.vertical"), for: .normal)
        addButton.setTitleColor(UIColor.darkGray, for: .normal)
        addButton.setTitle("  Add to library", for: .normal)
        addButton.addTarget(self, action: #selector(saveToLibrary), for: .touchUpInside)
        
        let linkButton = UIButton()
        linkButton.setImage(UIImage(systemName: "network"), for: .normal)
        linkButton.setTitleColor(UIColor.darkGray, for: .normal)
        linkButton.setTitle("  Visit on GitHub", for: .normal)
        linkButton.addTarget(self, action: #selector(openGitHub), for: .touchUpInside)
        
        
        [addButton, linkButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            linkButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 35),
            linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
  
        ])
        view.updateConstraints()
    }
    
    
    @objc func saveToLibrary() {
        print(#function)
        self.dismiss(animated: true) {
            self.delegate?.saveRepo()
        }
    }
    
    @objc func openGitHub() {
        if let url = URL(string: link!) {
            UIApplication.shared.open(url)
        }
    }
}

