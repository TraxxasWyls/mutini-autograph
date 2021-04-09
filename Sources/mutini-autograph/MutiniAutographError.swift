//
//  MutiniAutographError.swift
//  
//
//  Created by Дмитрий Савинов on 09.04.2021.
//

import Foundation

// MARK: - MutiniAutographError

public enum MutiniAutographError {

    // MARK: - Cases

    /// You haven't specified a path to plain objects
    case noPlainsFolder
}

// MARK: - LocalizedError

extension MutiniAutographError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .noPlainsFolder:
            return "You haven't specified a path to plain objects"
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension MutiniAutographError: CustomDebugStringConvertible {

    public var debugDescription: String {
        errorDescription ?? ""
    }
}
