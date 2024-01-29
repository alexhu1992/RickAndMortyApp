//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import UIKit

final class RMCharacterViewController: UIViewController, CharacterListViewDelegate {
    
    private let characterListView = CharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func characterListView(_ characterListView: CharacterListView, didSelectCharacter character: RMCharacter) {
        // open detailed controller for the characterr
        let detailViewModel = RMCharacterDetailViewModel(character: character)
        let detailViewController = RMCharacterDetailViewController(viewModel: detailViewModel)
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
