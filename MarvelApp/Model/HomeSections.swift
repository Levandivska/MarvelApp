//
//  HomeSections.swift
//  MarvelApp
//
//  Created by оля on 04.03.2021.
//

import Foundation

enum HomeSections: Int, CaseIterable, CustomStringConvertible {
    case comics
    case events
    case series
    case stories
    
    var description: String{
        switch self{
        case .comics: return "comics"
        case .events: return "events"
        case .series: return "series"
        case .stories: return "stories"
        }
    }
}
