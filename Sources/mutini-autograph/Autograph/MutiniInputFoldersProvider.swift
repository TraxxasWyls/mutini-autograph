//
//  MutiniInputFoldersProvider.swift
//  
//
//  Created by Дмитрий Савинов on 09.04.2021.
//

import Autograph

// MARK: - MutiniInputFoldersProvider

public final class MutiniInputFoldersProvider {

    public init() {
    }
}

// MARK: - InputFoldersProvider

extension MutiniInputFoldersProvider: InputFoldersProvider {

    public func inputFoldersList(fromParameters parameters: AutographExecutionParameters) throws -> [String] {
        guard let plainsFolder = parameters["-plains"] else {
            throw MutiniAutographError.noPlainsFolder
        }
        return [plainsFolder]
    }
}
