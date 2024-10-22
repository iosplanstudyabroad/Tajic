//
//  DocumentsListCell.swift
//  unitree
//
//  Created by Mohit Kumar  on 14/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
protocol DocumentDelegate {
    func getSelectedDocument(model:DocumentModel)
}
class DocumentsListCell: UITableViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var docTitle: UILabel!
    @IBOutlet var uplaodBtn: UIButton!
    var currentDocuments:DocumentModel?
    var delegate:DocumentDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        card.cardView()
        self.layoutIfNeeded()
        card.border(1, borderColor: UIColor().hexStringToUIColor(hex: "005F96"))
    }

    func configure(_ model:DocumentModel){
        let tick = UIImage(named: "tick")
        let uplaod = UIImage(named: "upload")
        currentDocuments = model
        docTitle.text = model.name
         uplaodBtn.setImage(uplaod, for: .normal)
        if model.isUploaded {
            uplaodBtn.setImage(tick, for: .normal)
        }
    }

    @IBAction func uplaodBtnTapped(_ sender:UIButton){
        if let model = currentDocuments {
          delegate?.getSelectedDocument(model: model)
        }
    }
}
