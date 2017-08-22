//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/21/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateDataOnCell(data: ForecastDay) {
        if let iconURL = data.iconURL {
            if let imageData = Utility.getImage(url: iconURL) {
                self.iconImageView.image = UIImage(data: imageData)
            }
        }
        highTempLabel.text = data.highTemp ?? "-"
        lowTempLabel.text = data.lowTemp ?? "-"
        weatherConditionLabel.text = data.conditions ?? "-"
        dayLabel.text = data.date ?? "-"
        windLabel.text = data.wind ?? "-"
        humidityLabel.text = data.humidity ?? "-"
        precipitationLabel.text = data.precipitation ?? "-"
        
    }

}
