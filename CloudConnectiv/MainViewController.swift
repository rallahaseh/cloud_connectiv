//
//  MainViewController.swift
//  CloudConnectiv
//
//  Created by Rashed Al-Lahaseh on 10/14/18.
//  Copyright © 2018 Rashed Al-Lahaseh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //
    var tableData = [Content]()
    var filteredTableData = [Content]()
    
    var totalPages   = 0
    var currentPage  = 0
    var dataSize     = 10

    //
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var logoButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var filtrationLabel: UILabel!
    @IBOutlet weak var filtrationAllButton: UIButton!
    @IBOutlet weak var filtrationActiveButton: UIButton!
    @IBOutlet weak var filtrationDownButton: UIButton!
    @IBOutlet weak var filtrationAllLocationsButton: UIButton!
    @IBOutlet weak var filtrationStackView: UIStackView!

    @IBOutlet weak var filtrationSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var notificationCounterLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var filtrationButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        setupView()
        setupCells()
        //
        getDataFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Buttons Functionality
    @IBAction func filtrationButtonsFunctionality(_ sender: UIButton) {
        for view in self.filtrationStackView.subviews {
            if view is UIButton {
                if let button:UIButton = view as? UIButton {
                    button.isSelected = false
                    if button.tag == sender.tag {
                        button.isSelected = !button.isSelected
                        let selectedColor: UIColor = UIColor(red: 29.0/255.0, green: 166.0/255.0, blue: 252.0/255.0, alpha: 1.0)
                        if button.isSelected {
                            button.backgroundColor = selectedColor
                            button.setTitleColor(.white, for: .normal)
                        } else {
                            button.backgroundColor = .clear
                            button.setTitleColor(.lightGray, for: .normal)
                        }
                    } else {
                        button.backgroundColor = .clear
                        button.setTitleColor(.lightGray, for: .normal)
                    }
                }
            }
        }
//        sender.isSelected = !sender.isSelected
//        let selectedColor: UIColor = UIColor(red: 29.0/255.0, green: 166.0/255.0, blue: 252.0/255.0, alpha: 1.0)
//        if sender.isSelected {
//            sender.backgroundColor = selectedColor
//            sender.setTitleColor(.white, for: .normal)
//        } else {
//            sender.backgroundColor = .clear
//            sender.setTitleColor(.lightGray, for: .normal)
//        }
        switch sender.tag {
        // ALL
        case 0:
            if self.tableData.count < 0 {
                // Get Data
                self.currentPage = 0
                getDataFromServer()
                // Filter Data
                filterData(isFiltering() ? filteredTableData : tableData)
                // Reload Data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // Filter Data
                filterData(isFiltering() ? filteredTableData : tableData)
                // Reload Data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            break
            // 1. Active
        // 2. Down
        case 1, 2:
            self.currentPage = 0
            self.tableData.removeAll()
            // Reload data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            break
        // 3. All Locations
        case 3:
            self.currentPage = 0
            self.tableData.removeAll()
            getDataFromServer()
            break;
        default:
            break
        }
    }
    @IBAction func segmentSelectionFunctionality(_ sender: Any) {
        if let selector = sender as? UISegmentedControl {
            switch selector.selectedSegmentIndex {
            // ALL
            case 0:
                if self.tableData.count < 0 {
                    // Get Data
                    self.currentPage = 0
                    getDataFromServer()
                    // Filter Data
                    filterData(isFiltering() ? filteredTableData : tableData)
                    // Reload Data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    // Filter Data
                    filterData(isFiltering() ? filteredTableData : tableData)
                    // Reload Data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                break
            // 1. Active
            // 2. Down
            case 1, 2:
                self.currentPage = 0
                self.tableData.removeAll()
                // Reload data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            // 3. All Locations
            case 3:
                self.currentPage = 0
                self.tableData.removeAll()
                getDataFromServer()
                break;
            default:
                break
            }
        }
    }
    
    func filterData(_ array:[Content]) {
        if array.count > 0 {
            var lastArray = [Content]()
            let firstFloor = array.filter { $0.status.id < 4 && $0.status.id > -1}
            var middleFloor = array.last
            middleFloor?.id = -99
            let secondFloor = array.filter { $0.status.id > 5 }
            lastArray = firstFloor
            lastArray.append(middleFloor!)
            lastArray += secondFloor
            if isFiltering() {
                self.filteredTableData = lastArray
            } else {
                self.tableData = lastArray
            }
        }
    }
    
    @IBAction func headerButtonsFunctionality(_ sender: UIButton) {
        switch sender.tag {
        // Home
        case 1:
            break
        // Settings
        case 2:
            break
        // Filtration
        case 3:
            break
        default:
            break
        }
    }
    
    func setupView() {
        // Filtration Buttons
        let filtrationButtonCornerRadius:CGFloat = 15
        let filtrationButtonBorderWidth:CGFloat = 1
        let filtrationButtonBackgroundColor:UIColor = .clear
        let filtrationButtonBorderColor:CGColor = UIColor.lightGray.cgColor
        
        self.filtrationAllButton.backgroundColor = filtrationButtonBackgroundColor
        self.filtrationAllButton.layer.cornerRadius = filtrationButtonCornerRadius
        self.filtrationAllButton.layer.borderWidth = filtrationButtonBorderWidth
        self.filtrationAllButton.layer.borderColor = filtrationButtonBorderColor
        self.filtrationActiveButton.backgroundColor = filtrationButtonBackgroundColor
        self.filtrationActiveButton.layer.cornerRadius = filtrationButtonCornerRadius
        self.filtrationActiveButton.layer.borderWidth = filtrationButtonBorderWidth
        self.filtrationActiveButton.layer.borderColor = filtrationButtonBorderColor
        self.filtrationDownButton.backgroundColor = filtrationButtonBackgroundColor
        self.filtrationDownButton.layer.cornerRadius = filtrationButtonCornerRadius
        self.filtrationDownButton.layer.borderWidth = filtrationButtonBorderWidth
        self.filtrationDownButton.layer.borderColor = filtrationButtonBorderColor
        self.filtrationAllLocationsButton.backgroundColor = filtrationButtonBackgroundColor
        self.filtrationAllLocationsButton.layer.cornerRadius = filtrationButtonCornerRadius
        self.filtrationAllLocationsButton.layer.borderWidth = filtrationButtonBorderWidth
        self.filtrationAllLocationsButton.layer.borderColor = filtrationButtonBorderColor
    }

    func setupCells() {
        self.tableView.register(UINib(nibName: "ServersInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ServersInfoTableViewCell")
        self.tableView.register(UINib(nibName: "SeparatorTableViewCell", bundle: nil), forCellReuseIdentifier: "SeparatorTableViewCell")
    }
}


// MARK: Handle HTTP Request
extension MainViewController: URLSessionDelegate {
    
    func getDataFromServer() {
//        print()
        let params  = paramsToString(["page": currentPage, "size": dataSize])
        let url     = "https://45.55.43.15:9090/api/machine"
//        print("\(url)\(params)")
        addLoadingAlert()
        httpGet(request: URLRequest( url: URL(string: "\(url)\(params)")!))
    }
    
    func paramsToString(_ data: [String: Any]) -> String {
        var parameter_string = "?"
        for (key, value) in data {
            parameter_string += key.description + "=" + "\(value)" + "&"
        }
        parameter_string = String(parameter_string.dropLast())
        
        return parameter_string
    }
    
    func httpGet(request: URLRequest) {
        let configuration               = URLSessionConfiguration.default
        /***************** Basic Authentication ********************/
        let userName                    = "admin@boot.com"
        let password                    = "admin"
        let authInfoString              = "\(userName):\(password)"
        let authInfoData                = authInfoString.data(using: String.Encoding.utf8)
        let base64EncodingCredential    = authInfoData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let authString                  = "Basic \(base64EncodingCredential)"
        configuration.httpAdditionalHeaders = ["Authorization": authString]
        /*********** Accepting Self-Signed SSL Certificate **************/
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: request)
        {
            (data, response, error) -> Void in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                self.dismiss(animated: false, completion: nil)
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                {
                    let machine_data = Machine(fromDictionary: json)
                    if (self.tableData.count > 0 && self.currentPage > 0) {
                        for object in machine_data.content {
                            if !self.tableData.contains(where: { $0.id == object.id }) {
                                self.tableData.append(object)
                            }
                        }
                    } else {
                        self.tableData = machine_data.content
                    }
                    self.totalPages = machine_data.totalPages
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func addLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential,
                          URLCredential(trust: challenge.protectionSpace.serverTrust!) )
    }
}

// MARK: - Table view data source
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTableData.count
        }
        return (tableData.count > 0) ? tableData.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object: Content = isFiltering() ? filteredTableData[indexPath.row] : tableData[indexPath.row]
        if let item_id = object.id {
            if item_id == -99 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell", for: indexPath) as? SeparatorTableViewCell {
                    cell.selectionStyle = .none
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ServersInfoTableViewCell", for: indexPath) as? ServersInfoTableViewCell {
                    cell.selectionStyle = .none
                    cell.fillDetails(object)
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let object: Content = isFiltering() ? filteredTableData[indexPath.row] : tableData[indexPath.row]
        if let item_id = object.id {
            return (item_id == -99) ? 50 : 120
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if (indexPath.section == lastSectionIndex) && (indexPath.row == (lastRowIndex - 1)) && (currentPage <= totalPages)
        {
            currentPage += 1
            if totalPages >= currentPage {
                getDataFromServer()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? ServersInfoTableViewCell {
            let skyColor = UIColor(red: 229.0/255.0, green: 246.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            if selectedCell.contentView.backgroundColor == skyColor {
                selectedCell.contentView.backgroundColor = .white
            } else {
                selectedCell.contentView.backgroundColor = skyColor
            }
        }
        let object: Content = tableData[indexPath.row]
        print("\n Selected Object: \(object) \n")
    }
}

// MARK: - UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchBar.selectedScopeButtonIndex != 0
        return (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTableData = searchText.isEmpty ? tableData : tableData.filter { (item: Content) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension UIButton {
    func selectedButton(title:String, iconName: String, widthConstraints: NSLayoutConstraint){
        self.backgroundColor = UIColor(red: 0, green: 118/255, blue: 254/255, alpha: 1)
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setImage(UIImage(named: iconName), for: .normal)
        self.setImage(UIImage(named: iconName), for: .highlighted)
        let imageWidth = self.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes:[NSAttributedStringKey.font: self.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 24
        //24 - the sum of your insets from left and right
        widthConstraints.constant = width
        self.layoutIfNeeded()
    }
}

