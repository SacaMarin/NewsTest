//
//  StyleSheets.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import Foundation
import UIKit

struct StyleSheets {
    
    static func apply(for vc: HomeVC) {
        vc.cornerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        vc.topView.addShadowTo()
    }
    
    static func apply(for vc: NewsVC) {
        vc.cornerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        vc.topView.addShadowTo()
    }
    
    static func apply(for vc: ArticleVC) {
        vc.cornerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        vc.topView.addShadowTo()
    }
    
    static func apply(for vc: SearchVC) {
        vc.cornerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
        vc.sortByView.roundCorners([.topLeft, .topRight], radius: 20)
        vc.topView.addShadowTo()
        vc.filterBtn.cornerRadius = vc.filterBtn.frame.width / 2
        vc.sortBtn.cornerRadius = vc.sortBtn.frame.width / 2
    }
}
