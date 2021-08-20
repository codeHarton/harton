//
//  TextureViewController.swift
//  Harton
//
//  Created by harton on 2021/8/20.
//

import UIKit
import AsyncDisplayKit

class TextureViewController: BaseViewController {
    
    
    var dataSource =  ["现在直播还可以带货了","这个主播不错","Middle for Mac(触控板和鼠标增强工具)_macz_yo的博客-CSD...","秋天 秋天到了,天空蓝得像一块透明的蓝玻璃;一群大雁往南飞,它们一会排成“人”字, 一会排成“一”字。 公园里,枫树阿姨脱去了绿罩衫,换上了红外套,秋风吹来,枫叶像许多漂漂亮亮的蝴 蝶,从树上...","在平平淡淡的日常中,大家或多或少都会接触过作文吧,借助作文可以宣泄心中的情感,调节自己的心情。相信写作文是一个让许多人都头痛的问题,以下是小编为大家收...","秋天到了，秋天带着一身金黄，迈着轻盈的脚步，悄然来到人间。她诱惑着我们，走进了秋的校园。顺着小路走去，便看见了“梧桐们”换上了秋装，满地的梧桐叶，像是一块块金砖铺在地上。踢一脚，便卷起一股金浪。同学们见此美景，纷纷拾起一片树叶，我也捡了一片。我们在金色的海洋里，杨帆把舵，奋勇拼搏。在这美景的渲染下，使我创造出一首简易的小诗：秋叶雨 金秋时节叶纷纷，雨叶如绵未断绝。如梦似影孩未醒，叶梦雨来不用顶。只有真正走进秋天，才能真正体会到秋天给我们带来的五彩缤纷。","秋天到了，菊花开了。有红的，有黄的，有紫的，还有白的，美丽极了","秋天到了的作文范文 1秋天到了 今天,我和妈妈去野外,我发现了秋天到了,秋天到了,天凉了下来,大树的叶子都黄了落下来像一只只黄色的蝴蝶在空中翩翩起舞。落到底墒,就像铺上了金黄的...","宋理宗宝祐四年（1256年），文天祥中进士第一，成为状元。一度掌理军器监兼权直学士院，因直言斥责宦官董宋臣，讥讽权相贾似道而遭到贬斥，数度沉浮，在三十七岁时自请致仕。德祐元年（1275年），元军南下攻宋，文天祥散尽家财，招募士卒勤王，被任命为浙西、江东制置使兼知平江府。在援救常州时，因内部失和而退守余杭。随后升任右丞相兼枢密使，奉命与元军议和，因面斥元主帅伯颜被拘留，于押解北上途中逃归。不久后在福州参与拥立益王赵昰为帝，又自赴南剑州聚兵抗元。景炎二年（1277年）再攻江西，终因势孤力单败退广东。祥兴元年（1278年）卫王赵昺继位后，拜少保，封信国公。后在五坡岭被俘，押至元大都，被囚三年，屡经威逼利诱，仍誓死不屈。元至元十九年十二月（1283年1月），文天祥从容就义，终年四十七岁。明代时追赐谥号“忠烈” [3]  。","文云孙（后改名天祥），字天祥， [6]  于南宋端平三年五月初二（1236年6月6日）出生在江南西路吉州庐陵县淳化乡富田村（今江西省吉安市青原区富田镇 [1]  ）人，是父亲文仪与母亲曾氏的长子。富田文氏，本为四川成都人，后移居庐陵。 [52]  [64] ","宝祐四年（1256年），二十岁的文云孙参加科举考试，在集英殿答对论策。当时宋理宗在位日久，倦怠政事，文云孙以“法天不息”为题议论策对，文章洋洋洒洒一万多字，没有草稿，一气呵成。理宗览后，亲自选拔他为进士第一。考官王应麟上奏说：“这个试卷以古代的事情作为借鉴，忠心肝胆好似铁石，我以为能得到这样的人才可喜可贺。”于是，成为状元的文云孙改名文天祥，改字为宋瑞（又字履善）。 [7]  中举不久后，因父亲逝世，文天祥回家守丧。 [8] ","现在直播还可以带货了","这个主播不错","Middle for Mac(触控板和鼠标增强工具)_macz_yo的博客-CSD...","秋天 秋天到了,天空蓝得像一块透明的蓝玻璃;一群大雁往南飞,它们一会排成“人”字, 一会排成“一”字。 公园里,枫树阿姨脱去了绿罩衫,换上了红外套,秋风吹来,枫叶像许多漂漂亮亮的蝴 蝶,从树上...","在平平淡淡的日常中,大家或多或少都会接触过作文吧,借助作文可以宣泄心中的情感,调节自己的心情。相信写作文是一个让许多人都头痛的问题,以下是小编为大家收...","秋天到了，秋天带着一身金黄，迈着轻盈的脚步，悄然来到人间。她诱惑着我们，走进了秋的校园。顺着小路走去，便看见了“梧桐们”换上了秋装，满地的梧桐叶，像是一块块金砖铺在地上。踢一脚，便卷起一股金浪。同学们见此美景，纷纷拾起一片树叶，我也捡了一片。我们在金色的海洋里，杨帆把舵，奋勇拼搏。在这美景的渲染下，使我创造出一首简易的小诗：秋叶雨 金秋时节叶纷纷，雨叶如绵未断绝。如梦似影孩未醒，叶梦雨来不用顶。只有真正走进秋天，才能真正体会到秋天给我们带来的五彩缤纷。","秋天到了，菊花开了。有红的，有黄的，有紫的，还有白的，美丽极了","秋天到了的作文范文 1秋天到了 今天,我和妈妈去野外,我发现了秋天到了,秋天到了,天凉了下来,大树的叶子都黄了落下来像一只只黄色的蝴蝶在空中翩翩起舞。落到底墒,就像铺上了金黄的...","宋理宗宝祐四年（1256年），文天祥中进士第一，成为状元。一度掌理军器监兼权直学士院，因直言斥责宦官董宋臣，讥讽权相贾似道而遭到贬斥，数度沉浮，在三十七岁时自请致仕。德祐元年（1275年），元军南下攻宋，文天祥散尽家财，招募士卒勤王，被任命为浙西、江东制置使兼知平江府。在援救常州时，因内部失和而退守余杭。随后升任右丞相兼枢密使，奉命与元军议和，因面斥元主帅伯颜被拘留，于押解北上途中逃归。不久后在福州参与拥立益王赵昰为帝，又自赴南剑州聚兵抗元。景炎二年（1277年）再攻江西，终因势孤力单败退广东。祥兴元年（1278年）卫王赵昺继位后，拜少保，封信国公。后在五坡岭被俘，押至元大都，被囚三年，屡经威逼利诱，仍誓死不屈。元至元十九年十二月（1283年1月），文天祥从容就义，终年四十七岁。明代时追赐谥号“忠烈” [3]  。","文云孙（后改名天祥），字天祥， [6]  于南宋端平三年五月初二（1236年6月6日）出生在江南西路吉州庐陵县淳化乡富田村（今江西省吉安市青原区富田镇 [1]  ）人，是父亲文仪与母亲曾氏的长子。富田文氏，本为四川成都人，后移居庐陵。 [52]  [64] ","宝祐四年（1256年），二十岁的文云孙参加科举考试，在集英殿答对论策。当时宋理宗在位日久，倦怠政事，文云孙以“法天不息”为题议论策对，文章洋洋洒洒一万多字，没有草稿，一气呵成。理宗览后，亲自选拔他为进士第一。考官王应麟上奏说：“这个试卷以古代的事情作为借鉴，忠心肝胆好似铁石，我以为能得到这样的人才可喜可贺。”于是，成为状元的文云孙改名文天祥，改字为宋瑞（又字履善）。 [7]  中举不久后，因父亲逝世，文天祥回家守丧。 [8] "]
    
    let tableView = ASTableNode(style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubnode(tableView)
        tableView.view.separatorStyle = .none
        tableView.view.allowsSelection = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
}
extension TextureViewController : ASTableDelegate,ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            if indexPath.row == self.dataSource.count {
                return ImageNode()
            }
            let message = self.dataSource[indexPath.row]

            return MessageNode(message: message)
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
}


class MessageNode: ASCellNode {
    
    lazy var textNode = ASButtonNode()
    
    let message : String
    init(message : String) {
        self.message = message
        super.init()
        _config()
    }
    
    private func _config(){
        let string = NSAttributedString(string: message,attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.orange])
        textNode.titleNode.maximumNumberOfLines = 3
        textNode.titleNode.attributedText = string
        textNode.backgroundColor = .red
        textNode.titleNode.backgroundColor = .cyan
        addSubnode(textNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textNode.titleNode.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let absSpec = ASAbsoluteLayoutSpec(children: [textNode])
        absSpec.sizing = .sizeToFit
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), child: absSpec)
    }
}

class ImageNode: ASCellNode {
    lazy var node = ASNetworkImageNode()

    override init() {
        super.init()
        _init()
    }
    
    
    private func _init(){
        node.url = URL(string: "https://static.feihuo.com/bizhi/video/new_video/static/1080/20210605/19e6e8a2f4372816b2edaae3e2eac27e.jpg")
        node.contentMode = .scaleAspectFill
        backgroundColor = .blue
        node.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubnode(node)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let absSpec = ASAbsoluteLayoutSpec(children: [node])
        absSpec.sizing = .sizeToFit
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), child: absSpec)
    }
}
