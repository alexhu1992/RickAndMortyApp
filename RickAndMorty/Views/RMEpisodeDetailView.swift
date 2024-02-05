//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/4/24.
//

import UIKit

final class RMEpisodeDetailView: UIView {
    
    private
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }
   
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
