//
//  DimSwitchTableViewCell.swift
//  MeditationTimer
//
//  Created by Damie on 10.11.2022.
//

import UIKit

class DimSwitchTableViewCell: UITableViewCell {
    let customCellStyle = CustomCellStyleParameters()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let switcher = UISwitch()
        switcher.setOn(ModelSettings.shared.DimSetting, animated: true)
        switcher.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        accessoryView = switcher
        self.backgroundColor = customCellStyle.backgroundColor
        self.layer.cornerRadius = customCellStyle.cornerRadius
        var content = self.defaultContentConfiguration()
        content.text = "Dim down while meditating"
        content.secondaryText = "Recommended"
        self.contentConfiguration = content
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc private func switchValueDidChange(_ sender: UISwitch) {
        ModelSettings.shared.DimSetting = sender.isOn
    }
}
