//
//  SettingsTableViewController.swift
//  MeditationTimer
//
//  Created by Damie on 27.10.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsTableCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Timer time"
        } else if section == 1 {
            return "Sound"
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        }
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableCell", for: indexPath)
        cell.backgroundColor = .secondarySystemBackground
        var content = cell.defaultContentConfiguration()


        if indexPath.section == 0 {
            content.text = "Azazaz"
            content.secondaryText = "--:-- min"
            content.image = UIImage(systemName: "stopwatch")
        } else if indexPath.section == 1 {
            content.text = "Ololol"
            content.text = "Default sound"
            content.image = UIImage(systemName: "speaker.wave.2")
        }
        content.image?.withTintColor(UIColor(named: "AccentColor", in: Bundle.main, compatibleWith: nil)!)
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
}


