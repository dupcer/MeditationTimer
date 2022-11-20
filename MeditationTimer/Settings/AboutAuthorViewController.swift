//
//  AboutAuthorViewController.swift
//  MeditationTimer
//
//  Created by Damie on 16.11.2022.
//

import UIKit

class AboutAuthorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guesture = UITapGestureRecognizer(target: self, action: #selector(openInstagram))
        
        self.title = "About the Author"
        self.view.backgroundColor = .systemBackground
        
        let image = UIImage(named: "author")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let text = UILabel()
        text.text = textAboutMe
        text.font = UIFont.preferredFont(forTextStyle: .body)
        text.textColor = .label
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.translatesAutoresizingMaskIntoConstraints = false

        let follow = UILabel()
        follow.text = "Follow"
        follow.font = UIFont.preferredFont(forTextStyle: .callout)
        follow.textColor = .label
        follow.numberOfLines = 1
        follow.lineBreakMode = .byWordWrapping
        follow.translatesAutoresizingMaskIntoConstraints = false
        follow.isUserInteractionEnabled = true
        follow.addGestureRecognizer(guesture)

        let isDarkMode = self.traitCollection.userInterfaceStyle == .dark
        
        let igIcon = UIImage(named: "instagramIcon")
        let igIconView = UIImageView(image: igIcon!)
        igIconView.isUserInteractionEnabled = true
        igIconView.addGestureRecognizer(guesture)
        igIconView.translatesAutoresizingMaskIntoConstraints = false

        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(text)
        scrollView.addSubview(follow)
        scrollView.addSubview(igIconView)

        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),

            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat((imageView.image?.size.width)! / 2)),
            imageView.heightAnchor.constraint(equalToConstant: (imageView.image?.size.height)! / 2),

            text.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.0),
            text.bottomAnchor.constraint(equalTo: follow.topAnchor, constant: -16.0),

            follow.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            follow.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 16),
            
            igIconView.widthAnchor.constraint(equalToConstant: 35),
            igIconView.heightAnchor.constraint(equalToConstant: 35),
            igIconView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            igIconView.topAnchor.constraint(equalTo: follow.bottomAnchor, constant: 16.0),
            igIconView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0),

        ])
    }
    
    @objc private func openInstagram() {
        if let url = URL(string: "https://www.instagram.com/damiejohn/") {
            UIApplication.shared.open(url)
        }
    }
}





fileprivate let textAboutMe = "Hi, I'm Damie John. I live with my family in London, UK. I started meditating in order to raise the quality of my sleep. The effect was almost immediate. So I started meditating every evening, for 15 minutes or so. Sometime after I've decided to build this application to make the process is smooth and convenient as possible.\nThanks to my wife, Angelina, as she's been practicing meditation for years. She encouraged and guided me through this process. Which, in turn, inspired me to build this app."
