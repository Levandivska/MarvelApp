//
//  HomeSections.swift
//  MarvelApp
//
//  Created by оля on 04.03.2021.
//

import Foundation

enum HomeSections: Int, CaseIterable, CustomStringConvertible{

    case comics
    
    var description: String{
        switch self{
        case .comics: return "Comics"
        }
    }
}
