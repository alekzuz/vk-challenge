//
//  TitleView.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

protocol TitleViewDelegate: class {
    func titleViewFieldDidChangeText(_ newText: String?)
    func titleViewFieldDidFinish()
}

final class TitleView: UIView, UITextFieldDelegate {

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var avatarView: WebImageView!
    
    weak var delegate: TitleViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        
        let image = UIImage(named: "search")
        textField.leftView = UIImageView(image: image)
        textField.leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(texFieldDidChange), for: .editingChanged)
        textField.delegate = self
        
        avatarView.layer.cornerRadius = avatarView.frame.width/2
        avatarView.clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    func set(userViewModel: TitleViewViewModel) {
        avatarView.set(imageUrl: userViewModel.photoUrlString)
    }
    
    @objc private func texFieldDidChange() {
        delegate?.titleViewFieldDidChangeText(textField.text)
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        avatarView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        avatarView.isHidden = false
        delegate?.titleViewFieldDidFinish()
    }
    
}
