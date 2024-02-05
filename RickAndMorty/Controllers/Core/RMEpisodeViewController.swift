//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 1/7/24.
//

import UIKit

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {
    
    
    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .systemBackground
        setupView()
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
    
    private func setupView() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        // open detailed controller for the characterr
        let detailViewModel = RMEpisodeDetailedViewModel(endpointUrl: URL(string: episode.url))
        let detailViewController = RMEpisodeDetailedViewController(url: URL(string: episode.url))
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
