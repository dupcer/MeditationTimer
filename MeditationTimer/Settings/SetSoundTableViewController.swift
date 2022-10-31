//
//  SetSoundTableViewController.swift
//  MeditationTimer
//
//  Created by Damie on 31.10.2022.
//

import UIKit

class SetSoundTableViewController: UITableViewController {

    private let myAudios = ModelSound.shared.dictOfSounds.filter({ $0.key.hasPrefix("Audio_my") })
    private let otherAudios = ModelSound.shared.dictOfSounds.filter({ !$0.key.hasPrefix("Audio_my") })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "setSoundCell")
        title = "Select sound"
        view.backgroundColor = .systemGray6
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myAudios.count
        } else {
            return otherAudios.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
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
            content.text = Array(myAudios.keys)[indexPath.item]
        } else {
            content.text = Array(otherAudios.keys)[indexPath.item]
        }
        
        cell.layer.cornerRadius = 10
        cell.contentView.frame(forAlignmentRect: CGRect(origin: CGPoint(x: 10, y: 15), size: CGSize(width: 200, height: 50)))
        cell.window?.clipsToBounds = true
        cell.contentConfiguration = content

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let soundName = Array(ModelSound.shared.dictOfSounds.keys)[indexPath.item]
        ModelSound.shared.selectSound(name: soundName)
    }
}
