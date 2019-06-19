//
//  CollectionDelegate.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Stanwood GmbH (www.stanwood.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import UIKit

protocol CollectionDelegating {
    
    var dataType: ModelCollection? { get set }
    var type: Model? { get set }
    
    func update(modelCollection: ModelCollection?)
    func update(model: Model?)
}

/**
 The `CollectionDelegate` conforms to the `CollectionDelegating` protocol. It allows you to manage the selection and highlighting of items in a collection view and to perform actions on those items. [`UICollectionView`](https://developer.apple.com/documentation/uikit/uicollectionview).
 
 #####Example: DataSource and Delegate design#####
 ````swift
 let items = [Element(id: "1"), Element(id: "2")]
 self.objects = Stanwood.Elements<Element>(items: items)
 
 self.dataSource = ElementDataSource(dataObject: objects)
 self.delegate = ElementDelegate(dataObject: objects)
 
 self.collectionView.dataSource = self.dataSource
 self.collectionView.delegate = self.delegate
 ````
 
 - SeeAlso:
 
 `AbstractCollectionDataSource`
 
 `Objects`
 
 `ModelCollection`
 
 `Type`
 */
open class CollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionDelegating, DelegateSourceType {
    
    // MARK: Properties
    
    /// dataObject, a collection of types
    public internal(set) var dataType:ModelCollection?
    
    /// A single type object to present
    public internal(set) var type: Model?
    
    // MARK: Initializers
    
    /**
     Initialise with a collection of types
     
     - Parameters:
     - dataObject: dataObject
     
     - SeeAlso: `ModelCollection`
     */
    public init(modelCollection: ModelCollection?) {
        self.dataType = modelCollection
    }
    
    /// Unavalible
    @available(*, unavailable, renamed: "init(model:)")
    public init(dataType: DataType?) {}
    
    /**
     Initialise with a a single type object.
     
     - Parameters:
     - dataType: DataType
     
     - SeeAlso: `Type`
     */
    public init(model: Model) {
        self.type = model
    }
    
    /// Unavalible
    @available(*, unavailable, renamed: "init(model:)")
    public init(type: Type) {}
    
    /// Unavalible
    @available(*, unavailable, renamed: "init(type:)")
    public init(dataType: Model) {}
    
    // MARK: Public functions
    
    /**
     update current dataSource with dataObject.
     >Note: If data type is a `class`, it is not reqruied to update the dataType.
     
     - Parameters:
     - dataObject: DataType
     
     - SeeAlso: `Type`
     */
    open func update(modelCollection: ModelCollection?) {
        self.dataType = modelCollection
    }
    
    /// Unavalible
    @available(*, unavailable, renamed: "update(modelCollection:)")
    open func update(with dataType: DataType?) {}
    
    /**
     update current dataSource with dataType.
     >Note: If data type is a `class`, it is not reqruied to update the dataType.
     
     - Parameters:
     - dataType: Type
     
     - SeeAlso: `DataType`
     */
    open func update(model: Model?) {
        self.type = model
    }
    
    /// Unavalible
    @available(*, unavailable, renamed: "update(model:)")
    open func update(with type: Type?) {}
    
    /// :nodoc:
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let headerable = dataType?[section] as? Headerable,
            let view = headerable.reusableView {
            return view.bounds.size
        }
        return CGSize.zero
    }
}
