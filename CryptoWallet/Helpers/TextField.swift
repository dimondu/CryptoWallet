//
//  TextField.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 25.12.2022.
//

import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextField() {
        layer.cornerRadius = 10
        backgroundColor = .white
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        textColor = .black
    }
}
