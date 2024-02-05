//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/4/24.
//

import UIKit

final class RMSearchViewController: UIViewController {
    
    struct Config {
        enum FetchType {
            case character
            case episode
            case location
        }
        
        let fetchType: FetchType
    }
    
    private let config: Config
    
    init (config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
    }

}
