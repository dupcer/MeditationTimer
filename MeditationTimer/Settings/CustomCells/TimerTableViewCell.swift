//
//  TimerTableViewCell.swift
//  MeditationTimer
//
//  Created by Damie on 10.11.2022.
//

import UIKit

class TimerTableViewCell: UITableViewCell, DisplayFormatedTimeExtension {
    var indexPathItem: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        var content = self.defaultContentConfiguration()
        populateTimerCellWithContent(&content)

        content.image = UIImage(systemName: "stopwatch")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        self.contentConfiguration = content
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func populateTimerCellWithContent(_ content: inout UIListContentConfiguration) {
        content.text = "Timer"

        if let list = ModelTimer.shared.getListOfTimersForSound() {
            if list.count > indexPathItem {
                let text = getShortedFormattedTimer(list[indexPathItem])
                content.secondaryText = text
            }
        } else {
            content.secondaryText = "--:-- min"
        }
    }
}
