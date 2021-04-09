//
//  MutiniImplementationComposer.swift
//  
//
//  Created by Дмитрий Савинов on 09.04.2021.
//

import Synopsis
import Autograph

// MARK: - MutiniImplementationComposer

public final class MutiniImplementationComposer {

    // MARK: - Initializers

    public init() {
    }

    // MARK: - Private

    private func properties(
        fromStructure structure: StructureSpecification
    ) -> [String] {
        structure.properties.map { property in
            PropertySpecification.template(
                comment: property.comment,
                accessibility: property.accessibility,
                declarationKind: property.annotations.contains(annotationName: "mutable")
                    ? .privateSet
                    : property.declarationKind,
                name: property.name,
                type: property.type,
                defaultValue: property.defaultValue,
                kind: property.kind,
                body: property.body
            )
        }.map(\.verse)
    }

    private func initializer(
        fromStructure structure: StructureSpecification
    ) -> String {
        let propertiesSequence = structure.properties.map { property in
            "\(property.name): \(property.type.verse)".indent
        }.joined(separator: ",\n")
        let assignmentSequence = structure.properties.map { property in
            "self.\(property.name) = \(property.name)".indent
        }.joined(separator: "\n")
        return """
        init(
        \(propertiesSequence)
        ) {
        \(assignmentSequence)
        }
        """
    }

    private func mutators(
        fromStructure structure: StructureSpecification
    ) -> [String] {
        structure.properties
            .filter { $0.annotations.contains(annotationName: "mutable") }
            .map { property in
                """
                /// Changes `\(property.name)` value
                /// - Parameter \(property.name): new `\(property.name)` value
                /// - Returns: current instance
                @discardableResult mutating func \(property.name)(_ \(property.name): \(property.type.verse)) -> Self {
                    self.\(property.name) = \(property.name)
                    return self
                }
                """
            }
    }
}

// MARK: - ImplementationComposer

extension MutiniImplementationComposer: ImplementationComposer {

    public func compose(
        forSpecifications specifications: Specifications,
        parameters: AutographExecutionParameters
    ) throws -> [AutographImplementation] {
        specifications.structures.map { structure in
            let propertiesSequence = properties(fromStructure: structure)
                .map(\.indent)
                .joined(separator: "\n\n")
            let initializerCode = initializer(fromStructure: structure).indent
            let mutatorsSequence = mutators(fromStructure: structure)
                .map(\.indent)
                .joined(separator: "\n\n")
            let sourceCode = """
            import Foundation

            // MARK: - \(structure.name)

            struct \(structure.name) {

                // MARK: - Properties

            \(propertiesSequence)

                // MARK: Initializers

            \(initializerCode)

                // MARK: Mutatots

            \(mutatorsSequence)
            }
            """
            return AutographImplementation(
                filePath: "/Users/savinov/Desktop/\(structure.name)Generated.swift",
                sourceCode: sourceCode
            )
        }
    }
}
