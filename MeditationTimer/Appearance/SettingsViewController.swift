//
//  MeditationTimer
//
//  Created by Damie on 21.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        
        timePicker = UIDatePicker()
        timePicker.datePickerMode = .countDownTimer
//        timePicker.datePickerStyle = .wheels
        
    }


}
