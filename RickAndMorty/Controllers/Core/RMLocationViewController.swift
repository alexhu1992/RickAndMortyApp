//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import UIKit

final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .systemBackground
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}
