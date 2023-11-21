//
//  CryptoCell.swift
//  CryptoApp
//
//  Created by umut yalçın on 21.11.2023.
//

import UIKit
import SnapKit

class CryptoCell: UITableViewCell {
    
    static let identifier = "CryptoCell"
    
    private lazy var cryptoTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "Bitcoin"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    private lazy var cryptoSubtitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "0.0000121231231"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(cryptoTitle)
            contentView.addSubview(cryptoSubtitle)
            setupConstraints()
    }
    
    private func setupConstraints(){
        cryptoTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
        }
        cryptoSubtitle.snp.makeConstraints { make in
            make.top.equalTo(cryptoTitle.snp.bottom).offset(8)
            make.left.equalTo(12)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var item : Crypto! {
        didSet {
            self.cryptoTitle.text = item.currency
            self.cryptoSubtitle.text = item.price
        }
    }
}

#Preview {
    CryptoCell()
}
