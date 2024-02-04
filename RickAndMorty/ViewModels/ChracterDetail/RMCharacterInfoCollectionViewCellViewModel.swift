//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mengheng Hu on 2/1/24.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let value: String
    private let valueType: ValueType
    
    static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    public var title: String {
        self.valueType.displayTile
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None" }
        
        if let date = Self.dataFormatter.date(from: value), valueType == .created {
            let result = Self.shortDateFormatter.string(from: date)
            return result
        }
        
        return value
    }
    
    public var iconImage: UIImage? {
        return valueType.iconImage
    }
    
    public var tintColor: UIColor {
        return valueType.tintColor
    }
    
    enum ValueType: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemBlue
            case .type:
                return .systemBlue
            case .species:
                return .systemBlue
            case .origin:
                return .systemBlue
            case .created:
                return .systemBlue
            case .location:
                return .systemBlue
            case .episodeCount:
                return .systemBlue
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTile: String {
            switch self {
            case .status, .gender, .type, .species, .origin, .created, .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init (type: ValueType, value: String) {
        self.valueType = type
        self.value = value
    }
}
