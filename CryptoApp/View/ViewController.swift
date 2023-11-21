//
//  ViewController.swift
//  CryptoApp
//
//  Created by umut yalçın on 20.11.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController , UITableViewDelegate{
    
    
    var cryptoList = [Crypto]()
    let cryptoVM = CryptoViewModel()
    let disposed = DisposeBag()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.identifier)
        return tableView
    }()
    
    private let indicatorView : UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        //indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rx.setDelegate(self).disposed(by: disposed)
        
        setupLayout()
        setupBinding()
        cryptoVM.requestData()
    }
    
    private func setupBinding(){
        
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposed)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }.disposed(by: disposed)
        
        
        //MARK: 1 yontem
//        cryptoVM
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoList = cryptos
//                self.tableView.reloadData()
//            }.disposed(by: disposed)
        
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: CryptoCell.identifier, cellType: CryptoCell.self)) {row,item,cell in
                
                cell.item = item
            }.disposed(by: disposed)

    }
    
    private func setupLayout(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



/*
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
}
*/
