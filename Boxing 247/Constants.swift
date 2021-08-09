//
//  Extension-UIColour.swift
//  Boxing 247
//
//  Created by Omar  on 27/07/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit
import AudioToolbox


//let charcoal  = UIColor(red:0.06, green:0.06, blue:0.06, alpha:1.0)
let base247 = UIColor(named: "base247")
let pomegranate247 = UIColor(named: "pomegranate247")

    //UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
let grey247 = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
let lightGrey247 = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0) // text
let white247 = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0) // text
let red247 = UIColor(red:0.82, green:0.05, blue:0.00, alpha:1.0) // D00E00

let test247 = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.0)

let fetchLimit = 10
let deviceWidth = UIScreen.main.bounds.size.width
let deviceHeight = UIScreen.main.bounds.size.height

enum Vibration {
       case error
       case success
       case warning
       case light
       case medium
       case heavy
       @available(iOS 13.0, *)
       case soft
       @available(iOS 13.0, *)
       case rigid
       case selection
       case oldSchool

       public func vibrate() {
           switch self {
           case .error:
               UINotificationFeedbackGenerator().notificationOccurred(.error)
           case .success:
               UINotificationFeedbackGenerator().notificationOccurred(.success)
           case .warning:
               UINotificationFeedbackGenerator().notificationOccurred(.warning)
           case .light:
               UIImpactFeedbackGenerator(style: .light).impactOccurred()
           case .medium:
               UIImpactFeedbackGenerator(style: .medium).impactOccurred()
           case .heavy:
               UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
           case .soft:
               if #available(iOS 13.0, *) {
                   UIImpactFeedbackGenerator(style: .soft).impactOccurred()
               }
           case .rigid:
               if #available(iOS 13.0, *) {
                   UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
               }
           case .selection:
               UISelectionFeedbackGenerator().selectionChanged()
           case .oldSchool:
               AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
           }
       }
   }
