//
//  MenuNavigationController.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/01.
//

import SideMenu
import UIKit

final class MenuNavigationController: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        presentationStyle = .menuSlideIn
//        menuWidth = 250
        leftSide = true
    }
}
