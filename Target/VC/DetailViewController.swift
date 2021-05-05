//
//  DetailViewController.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var image: UIImageView!
    @IBOutlet var labelAmount: UILabel!
    @IBOutlet var lableDescription: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelRegularPrice: UILabel!
    var viewModel : DetailViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProductInfo()
        bindingViewModel()
        self.title = "Product Description"
    }
    
    private func bindingViewModel() {
        viewModel.updateUI = {[unowned self] in
            DispatchQueue.main.async {
                if let strImg = viewModel.infoModel.imageUrl, let url  = URL(string: strImg) {
                    image.sd_setImage(with:url , completed: {_,_,_,_ in
                        activityIndicator.isHidden = true
                    } )
                }
                labelAmount.text = viewModel.infoModel.salePrice?.displayString
                lableDescription.text = viewModel.infoModel.description
                labelTitle.text = viewModel.infoModel.title
                if let sale = viewModel.infoModel.salePrice {
                    labelAmount.text = sale.displayString
                    labelRegularPrice.text = viewModel.infoModel.regularPrice.displayString
                } else {
                    labelAmount.textAlignment = .left
                    labelAmount.text = viewModel.infoModel.regularPrice.displayString
                    labelRegularPrice.text = nil
                }
                self.view.setNeedsDisplay()
               
            }
        }
    }


}
