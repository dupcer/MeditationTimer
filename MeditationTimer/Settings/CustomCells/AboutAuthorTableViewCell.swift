//
//  DimSwitchTableViewCell.swift
//  MeditationTimer
//
//  Created by Damie on 10.11.2022.
//

import UIKit

class AboutAuthorTableViewCell: UITableViewCell {
    let customCellStyle = CustomCellStyleParameters()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator
        self.backgroundColor = customCellStyle.backgroundColor
        self.layer.cornerRadius = customCellStyle.cornerRadius
        var content = self.defaultContentConfiguration()
        content.text = "About the Author"

        content.image = UIImage(systemName: "person.crop.circle")?.withTintColor(.label, renderingMode: .alwaysOriginal)

        self.contentConfiguration = content
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
