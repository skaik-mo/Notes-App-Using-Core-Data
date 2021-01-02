//
//  CategoryTableViewCell.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/19/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

protocol CategoryProtocol {
    func editCategory(titleCategory: String, descriptionCategory: String, index: Int)
    func deleteCategory(indexPath: IndexPath)
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var titleCategoryLabel: UILabel!
    @IBOutlet var descriptionCategoryLabel: UILabel!
    
    
    var categoryDelegate: CategoryProtocol?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setData(category: Category){
        titleCategoryLabel.text = category.titleCategory
        descriptionCategoryLabel.text = category.descriptionCategory
    }
    
    @IBAction func editAction(_ sender: Any) {
        if let _categoryDelegate = categoryDelegate, let _index = indexPath?.row{
            _categoryDelegate.editCategory(titleCategory: titleCategoryLabel.text!, descriptionCategory: descriptionCategoryLabel.text!, index: _index)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if let _categoryDelegate = categoryDelegate, let _indexPath = indexPath{
            _categoryDelegate.deleteCategory(indexPath: _indexPath)
        }
    }
    
}
