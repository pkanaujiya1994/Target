//
//  ListViewController.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK: - Properties

    var viewModel =  ProductListModel()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderViewModel() // data model observer
        fetchProductList() //fetch Api Call
        self.title = "Product Lists"
    }
    
    private func fetchProductList() {
        self.viewModel.getProductList()
    }
    
    private func renderViewModel() {
        viewModel.reloadList =  { [unowned slf = self] in
            DispatchQueue.main.async {
                slf.activityIndicator.stopAnimating()
                slf.tableView.isHidden = false
                slf.tableView.reloadData()
            }
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell {
            cell.configureCell(model: viewModel.productList[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushInfoViewController(viewModel.productList[indexPath.row].id)
    }
    
    
    
}
extension ListViewController {
    private func pushInfoViewController(_ id: Int? = nil) {
        if let id = id,let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            vc.viewModel = DetailViewModel(id: id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
