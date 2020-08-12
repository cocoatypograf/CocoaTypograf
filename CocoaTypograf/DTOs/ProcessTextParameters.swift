//
//  ProcessTextParameters.swift
//  CocoaTypograf
//
//  Created by Vadim Zhilinkov on 04/09/2018.
//  Copyright © 2018 dreadct. All rights reserved.
//

import Foundation

/// Specifies text processing parameters to be used by a typograf service.
public struct ProcessTextParameters {

    // MARK: - Properties

    /// Entity types being generated by a service.
    let entityType: EntityType

    /// A maximum number of a non-breaking spaces in processed text.
    ///
    /// Zero value means no restictions.
    let maxNonBreakingSpaces: UInt

    /// Specifies whether processed text should contain break line tags or not.
    let useBreakLineTags: Bool

    /// Specifies whether processed text should contain paragraph tags or not.
    let useParagraphTags: Bool

    // MARK: - Initializers

    /// Makes and initializes a new instance of the parameters.
    ///
    /// - Parameter entityType: Entity types being generated by a service.
    /// - Parameter maxNonBreakingSpaces: A maximum number of a non-breaking spaces in processed text.
    /// - Parameter useBreakLineTags: Specifies whether processed text should contain break line tags or not.
    /// - Parameter useParagraphTags: Specifies whether processed text should contain paragraph tags or not.
    init(entityType: EntityType = .none,
         maxNonBreakingSpaces: UInt = 0,
         useBreakLineTags: Bool = false,
         useParagraphTags: Bool = false) {
        self.entityType = entityType
        self.maxNonBreakingSpaces = maxNonBreakingSpaces
        self.useBreakLineTags = useBreakLineTags
        self.useParagraphTags = useParagraphTags
    }

}

// MARK: - Constants

extension ProcessTextParameters {

    fileprivate enum Constants {
        static let bodyFormatString = """
<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'>
    <soapenv:Header>
    </soapenv:Header>
    <soapenv:Body>
        <tns:ProcessText xmlns:tns='http://typograf.artlebedev.ru/webservices/'>
            <tns:text>%@</tns:text>
            <tns:entityType>%d</tns:entityType>
            <tns:maxNobr>%u</tns:maxNobr>
            <tns:useBr>%@</tns:useBr>
            <tns:useP>%@</tns:useP>
        </tns:ProcessText>
    </soapenv:Body>
</soapenv:Envelope>
"""
    }

}

// MARK: - Body text presentation

extension ProcessTextParameters {

    /// Produces a request body string using the parameters for a given text.
    /// - Parameter text: A text to be processed and passed within a produced request string.
    /// - Returns: A string representing a SOAP request body.
    func requestBody(text: String) -> String {
        return String(format: Constants.bodyFormatString,
                      text,
                      entityType.rawValue,
                      maxNonBreakingSpaces,
                      "\(useBreakLineTags)",
                      "\(useParagraphTags)")
    }

}
