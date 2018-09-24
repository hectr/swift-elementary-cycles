/*
 (BSD-2 license)

 Copyright (c) 2018, Hèctor Marquès

 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Swift

public final class Matrix<Element> {
    private var vector: Vector<Vector<Element>>
    
    public subscript(_ row: Int) -> Vector<Element>! {
        get {
            return vector[row]
        }
        set(newValue) {
            vector[row] = newValue
        }
    }

    public init(_ reservedRows: Int, _ reservedColumns: Int = 0) {
        self.vector = Vector<Vector<Element>>(reservedRows)
        for i in 0 ..< reservedLength {
            vector[i] = Vector<Element>(reservedColumns)
        }
    }

    public convenience init(rows: [[Element]]) {
        var reservedColumns = 0
        for row in rows {
            reservedColumns = Swift.max(reservedColumns, row.count)
        }
        self.init(rows.count, reservedColumns)
        for (offset, row) in rows.enumerated() {
            self[offset] = Vector(array: row, reservedLength: reservedColumns)
        }
    }

    public var reservedLength: Int {
        return vector.reservedLength
    }
}

extension Matrix: CustomDebugStringConvertible {
    public var debugDescription: String {
        return vector.debugDescription
    }
}

extension Matrix: CustomStringConvertible {
    public var description: String {
        return vector.description
    }
}

extension Matrix: Equatable where Element: Equatable {
    public static func == (lhs: Matrix<Element>, rhs: Matrix<Element>) -> Bool {
        guard lhs.reservedLength == rhs.reservedLength else { return false }
        for index in 0 ..< lhs.reservedLength {
            guard lhs[index] == rhs[index] else { return false }
        }
        return true
    }
}
