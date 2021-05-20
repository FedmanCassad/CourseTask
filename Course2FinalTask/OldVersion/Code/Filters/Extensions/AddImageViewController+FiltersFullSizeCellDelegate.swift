//
//  AddImageViewController+FiltersThumbinalsDelegate.swift
//  Course2FinalTask
//
//  Created by Vladimir Banushkin on 18.10.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

extension AddImageViewController: FiltersFullSizeCellDelegate {
  
  func goToFiltersViewController(image: UIImage) {
    let vc = ChooseFilterViewController(image)
    navigationController?.pushViewController(vc, animated: true)
  }
  
}
