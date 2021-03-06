//
//  ViewController.swift
//  Harton
//
//  Created by harton on 2021/8/17.
//

import UIKit

import RxCocoa
import RxSwift
import Then
import NSObject_Rx
import RxDataSources
protocol Identifier {
    static var identifier : String{get}
    var identifier : String{get}
}
extension UITableViewCell : Identifier{
    var identifier: String {
       return type(of: self).description()
        
    }
    
    static var identifier: String{    
        return self.description()
    }
}
class MyCell: UITableViewCell {
    
}
class ViewController: BaseViewController {
    
    struct Item {
        var name : String
        var type : UIViewController.Type
    }

    @IBOutlet weak var tableView : UITableView!
    let disposeBag = DisposeBag()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
   
        
   
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightAciton))
    }
    
    @objc func rightAciton(){
//        let vc = UIStoryboard(name: "LoginAndRegister", bundle: nil).instantiateViewController(identifier: "LoginViewController")
//        self.navigationController?.pushViewController(vc)
        
        UIApplication.shared.setAlternateIconName("wechat") { error  in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        Observable.just([Item(name: "TextureLayoutViewController", type: TextureLayoutViewController.self),Item(name: "AlgorithmViewController", type: AlgorithmViewController.self),Item(name: "InterviewViewController", type: InterviewViewController.self),Item(name: "LayoutViewController", type: LayoutViewController.self),Item(name: "OCAutoReleasePoolViewController", type: OCAutoReleasePoolViewController.self),Item(name: "TestViewController", type: TestViewController.self),Item(name: "NatureViewController", type: NatureViewController.self),Item(name: "RXEXTViewController", type: RXEXTViewController.self),Item(name: "Runloop", type: RunLoopViewController.self),Item(name: "???????????????", type: HitTestViewController.self),Item(name: "?????????", type: ThreadViewController.self),Item(name: "Init", type: InitViewController.self),Item(name: "??????", type: SandBoxViewController.self),Item(name: "ISA??????", type: IsaViewController.self),Item(name: "?????????", type: DataBaseViewController.self),Item(name: "AsyncDisplayKit", type: TextureViewController.self),Item(name: "RxSwift", type: RxViewController.self),Item(name: "Promise", type: HUDViewController.self),Item(name: "Lotto", type: BigLottoController.self),Item(name: "lock", type: LockViewController.self)]).bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){ row, ele, cell in
            print("row = \(row),ele = \(ele),cell = \(cell)")
            cell.textLabel?.text = ele.name
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(Item.self).subscribe { [weak self] item in
            guard let type = item.element?.type else{
                return
            }
            let vc = type.init()
            vc.title = item.element?.name
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: rx.disposeBag)
    }
}

