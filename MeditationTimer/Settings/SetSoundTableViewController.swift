//
//  SetSoundTableViewController.swift
//  MeditationTimer
//
//  Created by Damie on 31.10.2022.
//

import UIKit

class SetSoundTableViewController: UITableViewController {
    
    init(indexOfCellToSetTimerFor: Int) {
        self.indexInModelTimerToSetSoundFor = indexOfCellToSetTimerFor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var indexInModelTimerToSetSoundFor: Int

    private let myAudios = ModelSound.shared.AllSounds[1]
    private let otherAudios = ModelSound.shared.AllSounds[2]
    
    private var selectedSection = 1
    private var selectedItem = 0
  
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
        cell.frame = view.bounds
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
        if indexPath.section == selectedSection, indexPath.item == selectedItem {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem = indexPath.item
        self.selectedSection = indexPath.section
        
        let soundName = ModelSound.shared.AllSounds[indexPath.section][indexPath.item]
        ModelSound.shared.selectSound(name: soundName)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let fileName = ModelSound.shared.AllSounds[self.selectedSection][self.selectedItem]
        
        ModelTimer.shared.addSound(
            indexInList: indexInModelTimerToSetSoundFor,
            fileName: fileName
        )

    }
}
