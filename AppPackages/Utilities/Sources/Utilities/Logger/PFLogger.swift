//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Utilities
// Created on 05/10/24
// -----------------------------------------------------------
//

import Foundation
import os

public final class PFLogger {

    static private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.app.PeakFit", category: "PeakFit")

    public static let shouldLog: Bool = {
        #if DEBUG
            true
        #else
            false
        #endif
    }()

    static private func log(
        category: LogCategory,
        logType: LogType,
        messages: Any...,
        file: String,
        function: String,
        line: Int
    ) {
        if Self.shouldLog {
            let message = [
                category.rawValue,
                logType.rawValue,
                URL(fileURLWithPath: file).lastPathComponent,
                function,
                String(line)
            ] + messages.map { "\($0)" }
            let log = message.joined(separator: " ")
            switch logType {
            case .error:
                logger.log(level: .error, "\(log)")
            case .info:
                logger.log(level: .info, "\(log, privacy: .public)")
            case .message:
                logger.log(level: .default, "\(log)")
            }
        }
    }

    public static func info(
        category: LogCategory,
        _ messages: Any...,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(category: category, logType: .info, messages: messages, file: file, function: function, line: line)
    }

    public static func message(
        category: LogCategory,
        _ messages: Any...,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(category: category, logType: .message, messages: messages, file: file, function: function, line: line)
    }

    public static func error(
        category: LogCategory,
        _ error: Error,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(category: category, logType: .error, messages: error, file: file, function: function, line: line)
    }

}
