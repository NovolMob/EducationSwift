//
//  PhotoCollectionViewController.swift
//  FirstApplication
//
//  Created by Antares on 07.12.2021.
//

import UIKit
public class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let numberOfItemsInLine = 3
    let images = [UIImage(named: "cat"), UIImage(named: "cats"), UIImage(named: "rainbow_cat"), UIImage(named: "sky"), UIImage(named: "stich")]
    
    public override func viewDidLoad() {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = calculateItemSize(layout: layout)
    }
    
    func calculateItemSize(layout: UICollectionViewFlowLayout) -> CGSize {
        let widthForItems = collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing * CGFloat((numberOfItemsInLine - 1))
        let size = widthForItems / CGFloat(numberOfItemsInLine)
        return CGSize(width: size, height: size)
    }
    
    public override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoStorage.instance.photos?.count ?? 0
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoAsset = PhotoStorage.instance.photos?[indexPath.row]
        return cell
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = storyboard?.instantiateViewController(withIdentifier: "PhotoDetails") as? PhotoDetailsViewController else { return }
        collectionView.deselectItem(at: indexPath, animated: false)
        details.photoAsset = PhotoStorage.instance.photos?[indexPath.row]
        navigationController?.pushViewController(details, animated: true)
    }
}
