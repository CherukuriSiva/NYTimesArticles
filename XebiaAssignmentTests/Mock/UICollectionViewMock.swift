//
//  UICollectionViewMock.swift
//  XebiaAssignmentTests
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit

final class UICollectionViewMock: UICollectionView {
    var cell: UICollectionViewCell!
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return cell
    }
}
