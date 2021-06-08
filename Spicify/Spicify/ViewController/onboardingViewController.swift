//
//  onboardingViewController.swift
//  Spicify
//
//  Created by Alia Nurul Fatihah on 08/06/21.
//

import UIKit

class onboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles = [
        "Welcome to Spicify",
        "Scan the Spices!",
        "Spices Library"
    ]
    
    var desc = [
        "We are here to help you to identify Indonesian spices rhizome root.",
        "Take a photo of a spice to find out what spice it is.",
        "Get detailed information and learn more about rhizome root spices."
    ]
    
    var imgs = ["1", "2", "3" ]
    
    let vc = UINavigationController()
    
    override func viewDidLayoutSubviews() {
          scrollWidth = scrollView.frame.size.width
          scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        self.scrollView.delegate = self
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)
            
            let image = UIImageView(image: UIImage.init(named: imgs[index]))
            image.image = UIImage(named: imgs[index])
            image.frame = CGRect(x: 0, y: 0, width: 191, height: 191)
            image.contentMode = .scaleAspectFit
            image.center = CGPoint(x: scrollWidth / 2, y: scrollHeight / 2 - 167)

            let txt1 = UILabel(frame:CGRect(x: image.frame.minX - 50, y: self.view.center.y - 110, width: 300,height: 200))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 28.0)
            txt1.numberOfLines = 0
            txt1.textColor = #colorLiteral(red: 0.3411764706, green: 0.1764705882, blue: 0.08235294118, alpha: 1)
            txt1.text = titles[index]

            let txt2 = UILabel(frame: CGRect(x: self.view.center.x - 135,y: self.view.center.y + 50, width: 300, height: 200))
            txt2.textAlignment = .center
            txt2.numberOfLines = 0
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.textColor = #colorLiteral(red: 0.3411764706, green: 0.1764705882, blue: 0.08235294118, alpha: 1)
            txt2.text = desc[index]
            
            if index == 2 {
                let button = UIButton(frame: CGRect(x: txt2.frame.minX-27, y: self.view.center.y + 210, width: 328, height: 40))
                button.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.5058823529, blue: 0.3411764706, alpha: 1)
                button.setTitle("Identify Spices", for: .normal)
                button.layer.cornerRadius = 7
                button.isEnabled = true
                button.isUserInteractionEnabled = true
               // button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
                
                slide.addSubview(button)
            }

            slide.addSubview(txt1)
            slide.addSubview(txt2)
            txt2.sizeToFit()
            slide.addSubview(image)
            scrollView.addSubview(slide)
        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count) , height: scrollHeight)
        self.scrollView.contentSize.height = 1.0

        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
    }
    
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
