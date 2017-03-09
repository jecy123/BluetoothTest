//
//  Global.swift
//  BluetoothTest
//
//  Created by CBH_Mac on 2017/3/2.
//  Copyright © 2017年 CBH_Mac. All rights reserved.
//

import Foundation
import UIKit

enum KeyCode: Int {
    case power, mute, home, menu, back, up, down, left, right, ok, volumeDown, volumeUp
    case del, shift, space
    case num0, num1, num2, num3, num4, num5, num6, num7, num8, num9
    case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
    case comma, period, slash, backslash, colon, semicolon, doubleQuotation, underscore, hyphen, question
    case plus, equal, asterisk, percent, dollar, pound, at, exclamation, singleQuotation, and
}


struct Assets {
    static let background           = "Background"
    static let centerBackground     = "CenterBackground"
    static let keyboardButton       = "KeyboardButton"
    static let volumeDownButton     = "VolumeDownButton"
    static let volumeUpButton       = "VolumeUpButton"
    static let okButton             = "OKButton"
    static let leftButton           = "LeftButton"
    static let rightButton          = "RightButton"
    static let upButton             = "UpButton"
    static let downButton           = "DownButton"
    static let powerButton          = "PowerButton"
    static let muteButton           = "MuteButton"
    static let homeButton           = "HomeButton"
    static let bluetoothButton   = "BluetoothButton"
    static let connectedButton      = "ConnectedButton"
    static let tipButton            = "TipButton"
    static let menuButton           = "MenuButton"
    static let backButton           = "BackButton"
}

struct Constant {
    static let KeyboardViewHeight :CGFloat = UIScreen.main.bounds.height / 3
    static let BarButtonWidth:CGFloat = 40
    static let SpaceBarButtonWidth:CGFloat = UIScreen.main.bounds.width - 100
}

class Global
{
    static let TagButtonFirst:Int = 1000
    static let TagButtonSecond:Int = 1001
    static let TagMainFirstView:Int = 1
    
    
    
    static let keyCodes: [String: KeyCode] = [
        "PowerButton":      .power,
        "MuteButton":       .mute,
        "HomeButton":       .home,
        "MenuButton":       .menu,
        "BackButton":       .back,
        "UpButton":         .up,
        "DownButton":       .down,
        "LeftButton":       .left,
        "RightButton":      .right,
        "OKButton":         .ok,
        "VolumeDownButton": .volumeDown,
        "VolumeUpButton":   .volumeUp,
        
        "del":      .del,
        "shift":    .shift,
        "space":    .space,
        
        "0": .num0, "1": .num1, "2": .num2, "3": .num3, "4": .num4, "5": .num5, "6": .num6, "7": .num7, "8": .num8, "9": .num9,
        
        "A": .A, "B": .B, "C": .C, "D": .D, "E": .E, "F": .F, "G": .G,
        "H": .H, "I": .I, "J": .J, "K": .K, "L": .L, "M": .M, "N": .N,
        "O": .O, "P": .P, "Q": .Q, "R": .R, "S": .S, "T": .T,
        "U": .U, "V": .V, "W": .W, "X": .X, "Y": .Y, "Z": .Z,
        
        "a": .a, "b": .b, "c": .c, "d": .d, "e": .e, "f": .f, "g": .g,
        "h": .h, "i": .i, "j": .j, "k": .k, "l": .l, "m": .m, "n": .n,
        "o": .o, "p": .p, "q": .q, "r": .r, "s": .s, "t": .t,
        "u": .u, "v": .v, "w": .w, "x": .x, "y": .y, "z": .z,
        
        ",": .comma,        ".": .period,           "/": .slash,        "\\": .backslash,       ":": .colon,
        ";": .semicolon,    "\"": .doubleQuotation, "_": .underscore,   "-": .hyphen,           "?": .question,
        "+": .plus,         "=": .equal,            "*": .asterisk,     "%": .percent,          "$": .dollar,
        "#": .pound,        "@": .at,               "!": .exclamation,  "'": .singleQuotation,  "&": .and,
        ]
    
    static let marks = [",", ".", "/", "\\", ":", ";", "\"", "_", "-", "?", "+", "=", "*", "%", "$", "#", "@", "!", "'", "&"]
    
}


