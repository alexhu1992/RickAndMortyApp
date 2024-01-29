//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/28/24.
//

import UIKit

// Detail controller for a single character
final class RMCharacterDetailViewController: UIViewController {
   
    private let viewModel: RMCharacterDetailViewModel
    
    init(viewModel: RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

    
}
