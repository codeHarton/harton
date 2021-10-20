//
//  TextureLayoutViewController.swift
//  Harton
//
//  Created by harton on 2021/10/20.
//

import UIKit
import AsyncDisplayKit
class TextureLayoutViewController: BaseViewController{

    let tableView : ASTableNode = ASTableNode()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubnode(tableView)
        tableView.delegate = self
        tableView.dataSource = self 
        tableView.view.snp.makeConstraints { make  in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .cyan
        
        
        
        // Do any additional setup after loading the view.
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



class ASRelativeLayoutCell : ASCellNode{
    let childNode : ASTextNode
    override init() {
        childNode = ASTextNode()
        

        super.init()
        childNode.backgroundColor = .blue
        self.addSubnode(childNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.childNode.style.preferredSize = CGSize(width: 100, height: 100)
        let layout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: childNode)
        return ASInsetLayoutSpec(insets: .all(20), child: layout)
    }
}


class ASRatioLayoutCell: ASCellNode {
    let childNode : ASTextNode
    let titleNode : ASTextNode
    override init() {
        childNode = ASTextNode()
        titleNode = ASTextNode()
        

        super.init()
        titleNode.setText("北京")
        addSubnode(titleNode)
        childNode.attributedText = NSAttributedString(string: "宝祐四年（1256年），二十岁的文云孙参加科举考试，在集英殿答对论策。当时宋理宗在位日久，倦怠政事，文云孙以“法天不息”为题议论策对，文章洋洋洒洒一万多字，没有草稿，一气呵成。理宗览后，亲自选拔他为进士第一。考官王应麟上奏说：“这个试卷以古代的事情作为借鉴，忠心肝胆好似铁石，我以为能得到这样的人才可喜可贺。”于是，成为状元的文云孙改名文天祥，改字为宋瑞（又字履善）",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)])
        childNode.backgroundColor = .yellow
        self.addSubnode(childNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.childNode.style.layoutPosition = .zero
        let layout = ASRatioLayoutSpec(ratio: 0.5, child: self.childNode)
        return ASInsetLayoutSpec(insets: .all(20), child: layout)
    }
}


class AbsoluteLayoutCell: ASCellNode {
    let childNode : ASTextNode
    let titleNode : ASTextNode
    override init() {
        childNode = ASTextNode()
        titleNode = ASTextNode()
        

        super.init()
        titleNode.setText("北京")
        addSubnode(titleNode)
        childNode.setText("宝祐四年（1256年），二十岁的文云孙参加科举考试，在集英殿答对论策。当时宋理宗在位日久，倦怠政事，文云孙以“法天不息”为题议论策对，文章洋洋洒洒一万多字，没有草稿，一气呵成。理宗览后，亲自选拔他为进士第一。考官王应麟上奏说：“这个试卷以古代的事情作为借鉴，忠心肝胆好似铁石，我以为能得到这样的人才可喜可贺。”于是，成为状元的文云孙改名文天祥，改字为宋瑞（又字履善）")
        childNode.backgroundColor = .red
        self.addSubnode(childNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        childNode.style.layoutPosition = CGPoint(x: 0, y: 50)
//        childNode.style.preferredLayoutSize = ASLayoutSize(width: .init(unit: .auto, value: 200), height: .init(unit: .auto, value: 100))
        //childNode.style.preferredSize = CGSize(width: 200, height: 100)
        titleNode.style.layoutPosition = CGPoint(x: 100, y: 0)
        let layout = ASAbsoluteLayoutSpec(sizing: .default, children: [childNode,titleNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), child: layout)
    }
}

extension TextureLayoutViewController : ASTableDelegate,ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if 2 == indexPath.section {
            return ASRelativeLayoutCell()
        }
        if 1 == indexPath.section {
            return ASRatioLayoutCell()
        }
     return AbsoluteLayoutCell()
    }
    
}
