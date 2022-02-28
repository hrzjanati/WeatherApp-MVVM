//
//  HomeViewController.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/13/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let viewModel = HomeViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        configurationUIRefresh()
        initViewModel()
        
    }
    
    private func initViewModel(){
        viewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        viewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong") }
        }
        viewModel.tableViewHeader = {
            DispatchQueue.main.async {
                self.tableView.tableHeaderView = self.createTableViewHeader()
            }
        }
        viewModel.callLocation()
    }
    
    private func createTableViewHeader() -> UIView {
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        headerView.imageView.image = UIImage(named: viewModel.getcurrent().imageName)
        headerView.locationLabel.text = viewModel.getcurrent().locationName.upperBoundString("/")
        headerView.tempLabel.text = "\(viewModel.getcurrent().temp)°"
        headerView.descrebtionLabel.text = viewModel.getcurrent().descrebtion
        self.tableView.tableHeaderView = headerView
        return headerView
    }
    
    private func configurationUIRefresh() {
        refreshControl.tintColor = .systemBlue
        refreshControl.addTarget(self,
                                 action: #selector(self.refresh(_:)),
                                 for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.callLocation()
        refreshControl.endRefreshing()
    }
}
// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = self.tableView.tableHeaderView as? StretchyTableHeaderView else {return}
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as! HomeWeatherCellTableViewCell
        let cellViewModel = viewModel.getCell(indexPaths: indexPath)
        cell.configuration(day: cellViewModel.day,
                           main: "\(cellViewModel.main)",
                           min: "\(cellViewModel.min)°▼",
                           max: "\(cellViewModel.max)°▲")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Details", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewControllerID") as? DetailsViewController
        vc?.initViewModel(model: [viewModel.getCell(indexPaths: indexPath)])
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
