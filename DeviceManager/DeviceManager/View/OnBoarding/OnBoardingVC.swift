//
//  ViewController.swift
//  DeviceManager
//
//  Created by Karthik UK on 03/09/19.
//  Copyright © 2019 Karthik UK. All rights reserved.
//

import UIKit

class OnBoardingVC: BaseVC {
    
    @IBOutlet weak var pageControl: UIPageControl!

    let onBoardingmodel = OnBoardingVM()
    
    @IBAction func goNext(_ sender: Any) {
        guard let loginVC  = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC else { return }
        self.present(loginVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .white
        onBoardingmodel.formInfoModel()
    }
}

extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingmodel.info.count
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(scrollView.contentOffset.x)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "OnBoardingCVC"), for: indexPath as IndexPath) as? OnBoardingCVC
        cell?.imageOutlet.image = onBoardingmodel.info[indexPath.row].images
        cell?.title.text = onBoardingmodel.info[indexPath.row].titles
        cell?.descriptionLabel.text = onBoardingmodel.info[indexPath.row].about
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
