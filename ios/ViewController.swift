//
//  ViewController.swift
//  C_Mega_Menu
//
//  Created by 이성민 on 2023/05/14.
//

import UIKit
import Lottie
import SwiftUI

class ViewController: UIViewController {
    
    private let textLabelMain: UILabel = {
        let label = UILabel()
        label.text = "남부터미널 맛집 메가스터디 구내식당"
        label.font = UIFont(name: "나눔손글씨 맛있는체", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "cat")
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .repeat(2)
        lottieAnimationView.animationSpeed = 1
        return lottieAnimationView
    }()
    
    private let textLabelSub: UILabel = {
        let label = UILabel()
        label.text = "메뉴 정보 불러오는 중 🐾"
        label.font = UIFont(name: "나눔손글씨 맛있는체", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabelCopy: UILabel = {
        let label = UILabel()
        label.text = "Copyright. 써밍"
        label.font = UIFont(name: "나눔손글씨 맛있는체", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add animation view to view hierarchy
        view.addSubview(textLabelMain)
        view.addSubview(animationView)
        view.addSubview(textLabelSub)
        view.addSubview(textLabelCopy)

        // Set up animation view constraints
        let animationSize = CGSize(width: view.bounds.width / 2, height: view.bounds.height / 2)
        animationView.frame = CGRect(origin: .zero, size: animationSize)
        animationView.center = view.center
        animationView.alpha = 1

        // Position the animationView and textLabel
        NSLayoutConstraint.activate([
            textLabelMain.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 0),
            textLabelMain.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabelMain.widthAnchor.constraint(equalToConstant: 300),
            textLabelMain.heightAnchor.constraint(equalToConstant: 50),
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            
            textLabelSub.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 0),
            textLabelSub.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabelSub.widthAnchor.constraint(equalToConstant: 200),
            textLabelSub.heightAnchor.constraint(equalToConstant: 50),
            
            textLabelCopy.topAnchor.constraint(equalTo: textLabelSub.bottomAnchor, constant: 0),
            textLabelCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabelCopy.widthAnchor.constraint(equalToConstant: 200),
            textLabelCopy.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Check if dark mode is enabled
            if #available(iOS 13.0, *) {
                if self.traitCollection.userInterfaceStyle == .dark {
                    // Set text label color to white
                    textLabelMain.textColor = .white
                    textLabelSub.textColor = .white
                    textLabelCopy.textColor = .white
                }
            }

//        // Start the animationView
//        animationView.play { _ in
//            UIView.animate(withDuration: 0.3, animations: {
//                self.animationView.alpha = 0
//            }, completion: { _ in
//                self.animationView.isHidden = true
//                self.animationView.removeFromSuperview()
//                self.textLabel.removeFromSuperview()
//
//
//            })
//        }
        // Lottie 애니메이션 재생
                animationView.play { [weak self] finished in
                    guard let self = self else { return }
                    if finished {
                        // 애니메이션이 종료되면 SwiftUI의 CarouselExapleView가 보이도록 전환
                        let swiftUIView = CarouselExapleView()
                        let vc = UIHostingController(rootView: swiftUIView)
                        vc.view.frame = self.view.bounds
                        self.addChild(vc)
                        self.view.addSubview(vc.view)
                        vc.didMove(toParent: self)
                    }
                }
    }

}

