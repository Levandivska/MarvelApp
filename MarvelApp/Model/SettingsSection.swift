//
//  SettingSections.swift
//  MarvelApp
//
//  Created by оля on 28.02.2021.
//

import Foundation


protocol SectionType: CustomStringConvertible{
    var containSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    case characters
    case sections
        
    var description: String {
        switch self{
        case .characters : return "Characters"
        case .sections : return "Sections"
        }
    }
}

enum Sections: Int, CaseIterable, CustomStringConvertible, SectionType{
    case comics
    case events
    case stories
    case series
        
    var containSwitch: Bool{
        return true
    }
    
    var description: String{
        switch self{
        case .comics: return "Comics"
        case .events: return "Events"
        case .stories: return "Stories"
        case .series: return "Series"
        }
    }
}

struct CharachersSection: CustomStringConvertible, SectionType{
    var name: String

    var containSwitch: Bool{
        return false
    }
    
    var description: String {
        return name
    }
}
