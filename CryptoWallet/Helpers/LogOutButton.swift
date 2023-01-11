//
//  LogOutButton.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 26.12.2022.
//

import UIKit


final class LogOutButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        layer.cornerRadius = 20
        backgroundColor = .systemRed
        tintColor = .white
        setTitle("Log Out", for: .normal)
    }
}
