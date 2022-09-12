//
//  InfoLabel.swift
//  iOSEngineerCodeCheck
//
//  Created by 上條栞汰 on 2022/09/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class InfoLabel: UILabel {
  
    init(size: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)
        
        font = .systemFont(ofSize: size, weight: weight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
