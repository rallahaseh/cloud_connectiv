//
//  ServersInfoTableViewCell.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import UIKit


class ServersInfoTableViewCell: UITableViewCell {
        
    @IBOutlet weak var serverImageView: UIImageView!
    @IBOutlet weak var serverNameLabel: UILabel!
    @IBOutlet weak var serverInfoLabel: UILabel!
    @IBOutlet weak var serverIPLabel: UILabel!
    @IBOutlet weak var serverSubnetMaskAddressLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusColorButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            //
            self.serverImageView.clipsToBounds = true
            self.serverImageView.translatesAutoresizingMaskIntoConstraints = false
            self.serverImageView.layer.borderWidth = 1
            self.serverImageView.layer.borderColor = UIColor.clear.cgColor
            self.serverImageView.layer.cornerRadius = self.serverImageView.frame.size.width / 2
            //
            self.statusButton.layer.cornerRadius = 7
            self.statusButton.layer.borderWidth = 1
            self.statusButton.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupStatusButton(_ color: UIColor) {
        let statusColorButtonCornerRadius:CGFloat = self.statusColorButton.frame.size.width/2
        let statusColorButtonBorderWidth:CGFloat = 10
        let statusColorButtonBackgroundColor:UIColor = .clear
        
        DispatchQueue.main.async {
            self.statusColorButton.backgroundColor = statusColorButtonBackgroundColor
            self.statusColorButton.layer.cornerRadius = statusColorButtonCornerRadius
            self.statusColorButton.layer.borderWidth = statusColorButtonBorderWidth
            self.statusColorButton.layer.borderColor = color.cgColor
        }
    }
    
    @IBAction func buttonsFunctionality(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.tag {
        // Check
        case 1:
            break;
        // Call
        case 2:
            break;
        // Alarm
        case 3:
            break;
        // Mute
        case 4:
            break;
        default:
            break;
        }
    }
    
    @IBAction func statusButtonFunctionality(_ sender: Any) {
        
    }
    
    func fillDetails(_ data: Content) {
        
        guard let server_name = data.name,
              let model_info = data.model,
              let model_name = model_info.name,
              let ip_address = data.ipAddress,
              let subnet_mask = data.ipSubnetMask
            else
        {
            self.serverNameLabel.text = "N/A"
            self.serverInfoLabel.text = "N/A"
            self.serverIPLabel.text = "N/A"
            self.serverSubnetMaskAddressLabel.text = "N/A"
            
            return;
        }
        
        self.serverImageView.image = UIImage(named: "icon_15")
        self.serverNameLabel.text = server_name
        self.serverInfoLabel.text = model_name
        self.serverIPLabel.text = ip_address
        self.serverSubnetMaskAddressLabel.text = subnet_mask

        self.statusButton.isHidden  = false
        self.statusView.isHidden    = false
        guard let status_info = data.status,
              let status_value = status_info.statusValue,
              let status_id = status_info.id
            else
        {
            self.statusView.isHidden = true
            self.statusButton.setTitle("", for: .normal)
            self.statusButton.backgroundColor = .clear
            
            return;
        }
        //
        self.statusButton.setTitle(status_value, for: .normal)
        self.statusView.isHidden = false
        switch status_id {
        case 1:
            setupStatusButton(.green)
            break;
        case 2:
            setupStatusButton(.orange)
            break;
        case 3:
            setupStatusButton(.yellow)
            break;
        case 4:
            setupStatusButton(.red)
            break;
        default:
            setupStatusButton(UIColor(red: 67.0/255.0, green: 233.0/255.0, blue: 253.0/255.0, alpha: 1.0))
            break;
        }
    }
}
