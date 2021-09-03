//
//  SecondNetViewController.swift
//  Harton
//
//  Created by harton on 2021/9/2.
//

import UIKit

class SecondNetViewController: BaseViewController {

    lazy var tableView = UITableView(frame: .zero,style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        tableView.estimatedRowHeight = 100
        
        APIProvider.rx.request(HartonService.getList(params: ["page":1]).muTarget).mapObject(type: ResponseData<ListModel>.self).map { $0.data?.info ?? [] }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){index,item,cell in
            cell.textLabel?.text = item.worksName
        }.disposed(by: rx.disposeBag)
        tableView.rx.itemSelected._subscribe {[weak self] index in
            self?.tableView.deselectRow(at: index, animated: true)
        }.disposed(by: rx.disposeBag)
        tableView.rx.modelSelected(Info.self)._subscribe {[weak self] info in
            ///选中模型
            self?.navigationController?.pushViewController(InfoViewController(info: info), animated: true)
        }.disposed(by: rx.disposeBag)
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    private func setupTable(){
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
