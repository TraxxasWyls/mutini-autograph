//
//  MutiniApplication.swift
//  
//
//  Created by Дмитрий Савинов on 09.04.2021.
//

import Autograph

final class MutiniApplication: AutographApplication<MutiniImplementationComposer, MutiniInputFoldersProvider> {

    override func printHelp() {
        super.printHelp()
        print(
            """
            Accepted arguments:

            -plains <directory>
            Path to the folder, where plain objects to be processed are stored.
            If not set, current working directory is used by default.
            """
        )
    }
}
