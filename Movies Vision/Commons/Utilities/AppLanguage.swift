//
//  AppLanguage.swift
//  Movies Vision
//
//  Created by Luis Gustavo on 11/05/24.
//

import Foundation

enum AppLanguage: String {
    case pt
    case en
    
    var getTMDBLanguage: String {
        switch self {
        case .pt:
            "pt-BR"
        case .en:
            "en-US"
        }
    }
}
