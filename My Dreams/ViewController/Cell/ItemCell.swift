//
//  ItemCell.swift
//  My Dreams
//
//  Created by Mobile Jakarta Team on 03/06/18.
//  Copyright © 2018 moonshadow. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configure(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        itemImg.image = item.toImage?.image as? UIImage
        
        print("bounds: ", itemImg.bounds)
        print(itemImg.frame)
    }
}
