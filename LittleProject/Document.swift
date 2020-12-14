//
//  Document.swift
//  SwiftForReact
//
//  Created by Maria Grynychyn on 6/13/19.
//  Copyright © 2019 Maria Grynychyn. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    var text:String?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        
        return (self.text?.data(using: .utf8) ?? Data())
        
        //     return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        self.text = String.init(data: contents as! Data, encoding:.utf8)
        
        
    }
}

