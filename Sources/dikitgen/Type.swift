//
//  Type.swift
//  DIKit
//
//  Created by ishkawa on 2017/05/29.
//
//

import Foundation
import SourceKittenFramework

struct Type {
    private static var declarationKinds: [SwiftDeclarationKind] {
        return [.struct, .class, .enum, .protocol]
    }

    let name: String
    let kind: SwiftDeclarationKind
    let functions: [Function]
    let properties: [Property]
    let inheritedTypes: [String]

    init?(structure: Structure) {
        guard
            let kind = structure.kind, Type.declarationKinds.contains(kind),
            let name = structure.name else {
            return nil
        }

        self.name = name
        self.kind = kind
        self.functions = structure.substructures.flatMap(Function.init)
        self.properties = structure.substructures.flatMap(Property.init)
        self.inheritedTypes = (structure[.inheritedtypes] as? [[String: SourceKitRepresentable]])?
            .flatMap { $0["key.name"] as? String } ?? []
    }
}
