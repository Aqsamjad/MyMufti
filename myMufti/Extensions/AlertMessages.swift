//
//  File.swift
//  Pods
//
//  Created by Rauf on 28/09/2021.
//

import Foundation
import UIKit
import SwiftMessages
import Floaty

class AlertMessages {
    
    static let standard = AlertMessages()

    func showAlert(type : Theme ,title : String){

            // View setup

            let view: MessageView = MessageView.viewFromNib(layout: .cardView)

            view.configureContent(title:"", body: title.capitalized, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })

            let iconStyle: IconStyle  = .default

            switch type {

            case .info:
                view.configureTheme(.info, iconStyle: iconStyle)
                view.accessibilityPrefix = "info"
            case .success:
                view.configureTheme(.success, iconStyle: iconStyle)
                view.accessibilityPrefix = "success"
            case .warning:
                view.configureTheme(.warning, iconStyle: iconStyle)
                view.accessibilityPrefix = "warning"
            case .error:
                view.configureTheme(.error, iconStyle: iconStyle)
                view.accessibilityPrefix = "error"
            }

            var config = SwiftMessages.defaultConfig
            config.presentationStyle = .top
            config.presentationContext = .automatic
            config.presentationContext = .automatic
            config.duration = .seconds(seconds: 2)
            config.preferredStatusBarStyle = .lightContent
            SwiftMessages.show(config: config, view: view)
        }
}
