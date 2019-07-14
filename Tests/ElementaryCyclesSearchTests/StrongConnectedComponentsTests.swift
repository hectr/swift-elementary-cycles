import XCTest
@testable import ElementaryCyclesSearch

final class StrongConnectedComponentsTests: XCTestCase {
    static var allTests = [("test1", test1),
                           ("test2", test2)]


    func test1() {
        let adjMatrix = Matrix2D(10, 10) { matrix in
            matrix[0][1] = true
            matrix[1][2] = true
            matrix[2][0] = true; matrix[2][6] = true
            matrix[3][4] = true
            matrix[4][5] = true; matrix[4][6] = true
            matrix[5][3] = true
            matrix[6][7] = true
            matrix[7][8] = true
            matrix[8][6] = true
            matrix[6][1] = true
        }

        let adjacencyList: Matrix2D<Int> = AdjacencyList.getAdjacencyList(adjacencyMatrix: adjMatrix)
        let sccs = StrongConnectedComponents(adjacencyList: adjacencyList)

        var description = ""
        for i in 0 ..< adjacencyList.reservedLength {
            description.append("i: \(i)\n")
            guard let r = sccs.getAdjacencyList(node: i) else { continue }
            let al = r.getAdjList()
            for j in i ..< al.reservedLength {
                if al[j].size > 0 {
                    description.append("j: \(j)")
                    for k in 0 ..< al[j].size {
                        description.append(" _\(al[j].get(k))");
                    }
                    description.append("\n")
                }
            }
            description.append("\n")
        }

        let expectedString =
"""
i: 0
j: 0 _1
j: 1 _2
j: 2 _0 _6
j: 6 _1 _7
j: 7 _8
j: 8 _6

i: 1
j: 1 _2
j: 2 _6
j: 6 _1 _7
j: 7 _8
j: 8 _6

i: 2
j: 3 _4
j: 4 _5
j: 5 _3

i: 3
j: 3 _4
j: 4 _5
j: 5 _3

i: 4
j: 6 _7
j: 7 _8
j: 8 _6

i: 5
j: 6 _7
j: 7 _8
j: 8 _6

i: 6
j: 6 _7
j: 7 _8
j: 8 _6

i: 7
i: 8
i: 9

"""
        XCTAssertEqual(description, expectedString)
    }

    func test2() {
        let adjMatrix: AdjacencyMatrix = Matrix2D(10, 10) { matrix in
            matrix[0][1] = true
            matrix[1][2] = true
            matrix[2][0] = true
            matrix[2][4] = true
            matrix[1][3] = true
            matrix[3][6] = true
            matrix[6][5] = true
            matrix[5][3] = true
            matrix[6][7] = true
            matrix[7][8] = true
            matrix[7][9] = true
            matrix[9][6] = true
        }

        let adjacencyList: Matrix2D<Int> = AdjacencyList.getAdjacencyList(adjacencyMatrix: adjMatrix)
        let sccs = StrongConnectedComponents(adjacencyList: adjacencyList)
        
        var description = ""
        for i in 0 ..< adjacencyList.reservedLength {
            description.append("i: \(i)\n")
            guard let r = sccs.getAdjacencyList(node: i) else { continue }
            let al = r.getAdjList()
            for j in i ..< al.reservedLength {
                if al[j].size > 0 {
                    description.append("j: \(j)")
                    for k in 0 ..< al[j].size {
                        description.append(" _\(al[j].get(k))");
                    }
                    description.append("\n")
                }
            }
            description.append("\n")
        }

        let expectedString =
"""
i: 0
j: 0 _1
j: 1 _2
j: 2 _0

i: 1
j: 3 _6
j: 5 _3
j: 6 _5 _7
j: 7 _9
j: 9 _6

i: 2
j: 3 _6
j: 5 _3
j: 6 _5 _7
j: 7 _9
j: 9 _6

i: 3
j: 3 _6
j: 5 _3
j: 6 _5 _7
j: 7 _9
j: 9 _6

i: 4
j: 6 _7
j: 7 _9
j: 9 _6

i: 5
j: 6 _7
j: 7 _9
j: 9 _6

i: 6
j: 6 _7
j: 7 _9
j: 9 _6

i: 7
i: 8
i: 9

"""
        XCTAssertEqual(description, expectedString)
    }
}
