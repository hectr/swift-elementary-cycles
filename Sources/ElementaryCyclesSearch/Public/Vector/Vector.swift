/*
 (BSD-2 license)

 Copyright (c) 2018, Hèctor Marquès

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Swift

public final class Vector<Element> {
    private var array: [Element?] {
        didSet {
            reservedLength = Swift.max(reservedLength, array.count)
        }
    }
    
    public private(set) var reservedLength: Int {
        didSet {
            assert(reservedLength >= size)
        }
    }
    
    public subscript(_ index: Int) -> Element? {
        get {
            guard array.count > index || index >= reservedLength else { return nil }
            return array[index]
        }
        set(newValue) {
            while index >= array.count && index < reservedLength {
                array.append(nil)
            }
            array[index] = newValue
        }
    }

    public init(array: [Element], reservedLength: Int? = nil) {
        self.array = array
        self.reservedLength = Swift.max(reservedLength ?? 0, array.count)
    }
    
    public init(_ reservedLength: Int = 0) {
        self.array = [Element?]()
        self.reservedLength = reservedLength
    }
    
    public var size: Int {
        return array.count
    }
    
    public func get(_ index: Int) -> Element {
        guard let element = self[index] else { fatalError("\(#function): index (\(index)) out of bounds (\(reservedLength))") }
        return element
    }
    
    public func add(_ newElement: Element) {
        array.append(newElement)
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element? {
        var removedObject: Element?
        if index < array.count {
            removedObject = array[index]
            array.remove(at: index)
        } else if index >= reservedLength {
            preconditionFailure("Index out of range: \(index) is beyond count (\(array.count) and reservedLength \(reservedLength)")
        }
        reservedLength -= 1
        return removedObject
    }
}

extension Vector where Element: Equatable {
    public func contains(_ element: Element) -> Bool {
        return array.contains(element)
    }
    
    @discardableResult
    public func remove(element: Element) -> Bool {
        if let index = array.firstIndex(of: element) {
            array.remove(at: -index.distance(to: 0))
            return true
        }
        return false
    }
}

extension Vector: CustomDebugStringConvertible {
    public var debugDescription: String {
        return array.debugDescription
    }
}

extension Vector: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}

extension Vector: Equatable where Element: Equatable {
    public static func == (lhs: Vector<Element>, rhs: Vector<Element>) -> Bool {
        guard lhs.reservedLength == rhs.reservedLength else { return false }
        guard lhs.size == rhs.size else { return false }
        for index in 0 ..< lhs.size {
            guard lhs[index] == rhs[index] else { return false }
        }
        return true
    }
}
