//
//  DetailsViewController.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/23/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.tableView.rowHeight = 100
    }
    
    public func initViewModel(model : [DetailsDaily]) {
        viewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        viewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong in Details View") }
        }
        viewModel.fetchModel(Model: model)
    }
}
//MARK: - UITableViewDataSource
extension DetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCellID", for: indexPath) as! DetailsTableViewCell
        let cellM = viewModel.getCell(indexPaths: indexPath)
        cell.configuration(title: "\(cellM.title)\(suffixString(status: cellM.value))",
                           imageName: "\(cellM.value)",
                           color: setColor(status: "\(cellM.value)"))
        return cell
    }
}
