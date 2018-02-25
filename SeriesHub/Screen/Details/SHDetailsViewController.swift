//
//  SHDetailsViewController.swift
//  SeriesHub
//
//  Created by Javier Manzo on 4/24/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit
import IOStickyHeader
import Kingfisher

class SHDetailsViewController: UIViewController {
    
    var serie: SHSerie!
    
    @IBOutlet private var topView: UIView!
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var backgroundAlphaView: UIView!
    @IBOutlet private var collectionView: UICollectionView!
    let headerNib = UINib(nibName: "IOGrowHeader", bundle: Bundle.main)
    
    var handlePan: ((_ panGestureRecognizer: UIPanGestureRecognizer) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImageView.kf.setImage(with: URL(string: serie.backgroundImageUrl), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil) { (image, error, cache, url) in
            
            self.backgroundImageView.image = image
            
        }
        
        self.setupCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.backgroundColor = UIColor.clear
        
        if let layout: IOStickyHeaderFlowLayout = self.collectionView.collectionViewLayout as? IOStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 320)
            layout.parallaxHeaderMinimumReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 160)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: layout.itemSize.height)
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = true
            self.collectionView.collectionViewLayout = layout
        }
        
        
        
        self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.collectionView.register(SHDetailsOverviewCollectionViewCell.cellNib, forCellWithReuseIdentifier: SHDetailsOverviewCollectionViewCell.idCell)
        
        self.collectionView.register(self.headerNib, forSupplementaryViewOfKind: IOStickyHeaderParallaxHeader, withReuseIdentifier: IOGrowHeader.idCell)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dragTop(_ sender: UIPanGestureRecognizer) {
        self.handlePan?(sender)
    }
    
    @objc func subscribeAction() {
        if SHRealmHelper.shared.isSubscribed(serie: serie) {
            SHRealmHelper.shared.removeSerie(serie: serie)
        } else {
            SHRealmHelper.shared.addSerie(serie: serie)
        }
        
        self.collectionView.reloadData()
    }
    
}

extension SHDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SHDetailsOverviewCollectionViewCell.idCell, for: indexPath) as? SHDetailsOverviewCollectionViewCell {
            cell.setInfo(serie: serie)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 100
        
        let padding: CGFloat = 20
        
        height = estimateFrameForText(text: serie.overview).height + padding
        return CGSize(width: UIScreen.main.bounds.size.width, height: height)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case IOStickyHeaderParallaxHeader:
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: IOGrowHeader.idCell, for: indexPath) as? IOGrowHeader {
                
                cell.subscribeButton.addTarget(self, action: #selector(subscribeAction), for: .touchUpInside)
                
                cell.setInfo(serie: serie)
                
                return cell
            }
            return UICollectionReusableView()
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    private func estimateFrameForText(text: String) -> CGRect {
        
        let size = CGSize(width: UIScreen.main.bounds.size.width - 150, height: UIScreen.main.bounds.size.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
}
