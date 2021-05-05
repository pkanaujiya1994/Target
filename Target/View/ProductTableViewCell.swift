//
//  ProductTableViewCell.swift
//  Target
//
//  Created by priti.kanaujiya on 04/05/21.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var lbllAisle: PaddingLabel!{
        didSet {
            lbllAisle.layer.borderWidth = 2
            lbllAisle.layer.borderColor = #colorLiteral(red: 0.8783541918, green: 0.8784809113, blue: 0.8783264756, alpha: 1)
        }
    }
    
    @IBOutlet var viewBackGround: UIView!{
        didSet {
            viewBackGround.layer.borderWidth = 0.4
            viewBackGround.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    static let identifier = "ProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    
    func configureCell(model: Product) {
        labelName.text = model.title
        lbllAisle.text = model.aisle
        lbllAisle.paddingLeft = 10
        lbllAisle.paddingRight = 10
        lbllAisle.paddingTop = 10
        lbllAisle.paddingBottom = 10
        lbllAisle.layer.cornerRadius = (lbllAisle.paddingLeft + lbllAisle.paddingRight + lbllAisle.bounds.width - 20 )/2
        if let strImg = model.imageUrl, let url  = URL(string: strImg) {
            imgView.sd_setImage(with: url)
            activityIndicator.stopAnimating()
        }
        if let sale = model.salePrice {
            labelPrice.text =  sale.displayString
        } else {
            labelPrice.text = model.regularPrice.displayString
        }
    }
    
    
}
