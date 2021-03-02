//
//  UserSettingsViewController.swift
//  MarvelApp
//
//  Created by оля on 28.02.2021.
//

import UIKit
import CoreData

class UserSettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    var characters: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            if let characters = self?.fetchCharacters(){
                self?.characters = characters
                print("characters= ", characters)
                self?.tableView.reloadData()
            }
        }
    }
    
    func fetchCharacters() -> [NSManagedObject]?{
        guard let context = AppDelegate.context else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        do {
            if let characters = try context.fetch(fetchRequest) as? [NSManagedObject]{
                return characters
            }
        }
        catch {
            fatalError("Failed to fetch Characters")
        }
        return nil
    }
}

extension UserSettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0}
        
        switch section{
        case .characters : return characters.count
        case .sections: return Sections.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .sections: cell.sectionType = Sections(rawValue: indexPath.row)
        case .characters: cell.sectionType = CharachersSection(name: characters[indexPath.row].value(forKey: "name") as! String)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSection(rawValue: section) else {  return "" }
        return section.description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
}
