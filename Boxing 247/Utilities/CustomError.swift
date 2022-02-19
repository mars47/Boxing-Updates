//
//  CustomError.swift
//  Boxing 247
//
//  Created by Omar on 19/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {

    var title: String
    var code: Int?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String? = nil, description: String, code: Int? = nil) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
