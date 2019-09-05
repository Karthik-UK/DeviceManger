//
//  ViewController.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class OnBoardingVC: BaseVC {
    @IBOutlet weak var onClick: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    let model =  WalkThroughVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.onBoarding()
        onClick.layer.borderWidth = 2
        onClick.layer.borderColor = UIColor.black.cgColor
    }
}

extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.info.count
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(scrollView.contentOffset.x)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "OnBoardingCVC"), for: indexPath as IndexPath) as? OnBoardingCVC
        cell?.imageOutlet.image =  UIImage(named: model.info[indexPath.row].images)
        cell?.title.text = model.info[indexPath.row].titles
        cell?.descriptionLabel.text = model.info[indexPath.row].about
        return cell ?? UICollectionViewCell()
    }
}

extension OnBoardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
}
