//
//  SettingsTableViewController.swift
//  MeditationTimer
//
//  Created by Damie on 27.10.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController, UINavigationControllerDelegate, DisplayFormatedTimeExtension {

    weak var vcToUpdate: MainScreenTimersListViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsTableCell")
        title = "Settings"
        view.backgroundColor = .systemGray6
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let vcToUpdate = vcToUpdate {
            vcToUpdate.setListOfTimerTimes()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Add timers"
        } else if section == 1 {
            return "Set the sound of the timer"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            guard let numberOfElementsInList = ModelTimer.shared.getListOfTimersForSound()?.count else {
                return 1
            }
            if numberOfElementsInList >= 3 {
                return 3
            } else {
               return numberOfElementsInList+1
            }
            
        } else if section == 1 {
            return 1
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableCell", for: indexPath)
        cell.backgroundColor = .tertiarySystemBackground
        var content = cell.defaultContentConfiguration()
        
        
        if indexPath.section == 0 {
            
            populateTimerCellWithContent(&content, indexPath: indexPath)
            
            content.image = UIImage(systemName: "stopwatch")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        }
        
        cell.layer.cornerRadius = 10
        cell.contentView.frame(forAlignmentRect: CGRect(origin: CGPoint(x: 10, y: 15), size: CGSize(width: 200, height: 50)))
        cell.window?.clipsToBounds = true
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var setTimerVC: SetTimerViewController
        
        if let existingId = getExistingId(indexPathItem: indexPath.item) {
            setTimerVC = SetTimerViewController(id: existingId, isTimerFreshNew: false)
        } else {
            let newTimer = TimerForSound(hour: 0, minute: 1, soundFileName: nil)
            ModelTimer.shared.addNewTimerToList(newTimer)
            setTimerVC = SetTimerViewController(id: newTimer.id, isTimerFreshNew: true)
        }

        _ = UINavigationController(rootViewController: setTimerVC)
        navigationController?.pushViewController(setTimerVC, animated: true)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    private func getExistingId(indexPathItem: Int) -> String? {
        if let list = ModelTimer.shared.getListOfTimersForSound() {
            if list.indices.contains(indexPathItem)  {
                return list[indexPathItem].id
            }
        }
        return nil
    }
    
    private func populateTimerCellWithContent(_ content: inout UIListContentConfiguration, indexPath: IndexPath) {
        content.text = "Timer"

        if let list = ModelTimer.shared.getListOfTimersForSound() {
            if list.count > indexPath.item {
                let text = getShortedFormattedTimer(list[indexPath.item])
                content.secondaryText = text
            }
        } else {
            content.secondaryText = "--:-- min"
        }
    }
}


