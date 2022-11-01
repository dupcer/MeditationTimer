//
//  SetSoundTableViewController.swift
//  MeditationTimer
//
//  Created by Damie on 31.10.2022.
//

import UIKit

class SetSoundTableViewController: UITableViewController {

    private let myAudios = ModelSound.shared.AllSounds[1]
    private let otherAudios = ModelSound.shared.AllSounds[2]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "setSoundCell")
        title = "Select sound"
        view.backgroundColor = .systemGray6
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return myAudios.count
        } else {
            return otherAudios.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "No sound"
        } else if section == 1 {
            return "Meditational sounds"
        } else {
            return "Others"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setSoundCell", for: indexPath)
        cell.backgroundColor = .tertiarySystemBackground
        var content = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            content.text = ModelSound.shared.AllSounds[0][0]
        } else if indexPath.section == 1 {
            content.text = ModelSound.shared.getDescriptiveName(myAudios[indexPath.item])
        } else {
            content.text = ModelSound.shared.getDescriptiveName(otherAudios[indexPath.item])
        }
        
        cell.layer.cornerRadius = 10
        cell.contentView.frame(forAlignmentRect: CGRect(origin: CGPoint(x: 10, y: 15), size: CGSize(width: 200, height: 50)))
        cell.window?.clipsToBounds = true
        cell.contentConfiguration = content

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setSoundCell", for: indexPath)
        cell.accessoryType = .checkmark
        
        let soundName = ModelSound.shared.AllSounds[indexPath.section][indexPath.item]
        ModelSound.shared.selectSound(name: soundName)
        self.tableView.reloadData()
    }
}
