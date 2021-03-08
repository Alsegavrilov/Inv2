//
//  SearchViewController.swift
//  Inv
//
//  Created by Александр Гаврилов on 23.02.2021.
//

import UIKit

protocol RepoSearchDelegate: class {
    func requestRepo(_ repoName: String)
    func openLibrary()
}


class SearchViewController: UIViewController {
    
    private let textField = UITextField()
    private let searchButton = UIButton()
    private let libraryButton = UIButton()
    weak var delegate: RepoSearchDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        textField.text = ""
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(displayP3Red: 246/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 36/255.0, green: 41/255.0, blue: 47/255.0, alpha: 1)
        
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.textColor = UIColor.gray
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let textFieldPlaceholderAttribute: [NSAttributedString.Key : Any] = [.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]
        textField.attributedPlaceholder = NSAttributedString(string: "type repo name", attributes: textFieldPlaceholderAttribute)
        
        
        searchButton.setTitle("↓", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
//        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        searchButton.isUserInteractionEnabled = true
        
        
        libraryButton.setImage(UIImage(systemName: "books.vertical"), for: .normal)
        libraryButton.imageView?.contentMode = .scaleAspectFill
        let libraryTap = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        libraryButton.isUserInteractionEnabled = true
        libraryButton.addGestureRecognizer(libraryTap)
        
        
        
        [textField, searchButton, libraryButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            searchButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            libraryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            libraryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),

        ])
        view.updateConstraints()
    }
    
    @objc func search() {
//        let userInput = textField.text!.replacingOccurrences(of: " ", with: "_")
        
        delegate?.requestRepo(textField.text!)
    }
    
    @objc func openLibrary() {
        delegate?.openLibrary()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(textField.endEditing(_:)))
        view.addGestureRecognizer(tap)
        searchButton.isUserInteractionEnabled = false
        return true
    }
    
func textFieldDidEndEditing(_ textField: UITextField) {
    if let title = textField.text {
        if !title.isEmpty {
            searchButton.isUserInteractionEnabled = true
            search()
        }
    }
}
}
