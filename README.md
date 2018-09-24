# ElementaryCycles

Swift port of an algorythm used to find all the cycles in a directed graph:

> This is an implementation of an algorithm by Donald B. Johnson to find all elementary cycles in a directed graph ([Donald B. Johnson: Finding All the Elementary Circuits of a Directed Graph. SIAM Journal on Computing. Volumne 4, Nr. 1 (1975), pp. 77-84](https://www.cs.tufts.edu/comp/150GA/homeworks/hw1/Johnson%2075.PDF)).
>
> Original Java implementation: <http://normalisiert.de>

## Usage

### ElementaryCycles

```swift
import ElementaryCycles

// dictionary pairs represent node connections from the keys to their values
let graph = ["A": ["B", "C"], "B": ["A"], "C": ["D"], "D": ["C"]]

let cycles = ElementaryCycles.find(graph: graph, sort: { $0 < $1 })

// nodes order is determined by sort parameter 
print(cycles) // [["A", "B"], ["C", "D"]]
```

- **Input**: *Directed graph*

```
                ┌─────────┐
                ∨         │
    ┌───┐     ┌───┐     ┌───┐
 ┌> │ A │ ──> │ C │ ──> │ D │
 │  └───┘     └───┘     └───┘
 │    │
 │    │
 │    ∨
 │  ┌───┐
 └─ │ B │
    └───┘
```

- **Output**: *Elementary circuits*

```
 ┌───┐     ┌───┐
 │ A │ ──> │ B │
 └───┘     └───┘
 ┌───┐     ┌───┐
 │ C │ ──> │ D │
 └───┘     └───┘
```

### ElementaryCyclesSearch

Alternatively, you can use **ElementaryCyclesSearch** library directly, which contains the actual algorythm implementation:

> The implementation is pretty much generic, all it needs is a adjacency-matrix of your graph and the objects of your nodes. Then you get back the sets of node-objects which build a cycle.
>
> Original Java implemnetation: <http://normalisiert.de>

```swift
import ElementaryCyclesSearch

let nodes = Vector(["A", "B", "C", "D"])
let matrix = AdjacencyMatrix(4, 4) { matrix in
    matrix[0][1] = true
    matrix[0][2] = true
    matrix[1][0] = true
    matrix[2][3] = true
    matrix[3][2] = true
}
let cycles = getElementaryCycles(adjacencyMatrix: matrix, graphNodes: nodes)
```

- **Input**: *Node objects*

| **A**   | **B**   | **C**   | **D**   |
|---------|---------|---------|---------|

- **Input**: *Adjacency-matrix*

|         | **A**   | **B**   | **C**   | **D**   |
|---------|---------|---------|---------|---------|
|**A**    | `false` | `true`  | `false` | `false` |
|**B**    | `true`  | `false` | `false` | `false` |
|**C**    | `true`  | `false` | `false` | `true`  |
|**D**    | `false` | `false` | `true`  | `false` |

- **Output**: *Elementary circuits*

```
 ┌───┐     ┌───┐
 │ A │ ──> │ B │
 └───┘     └───┘
 ┌───┐     ┌───┐
 │ C │ ──> │ D │
 └───┘     └───┘
```

## License

> (BSD-2 license)
> 
> Original work Copyright (c) 2012, Frank Meyer
> 
> All rights reserved.
> 
> Swift port Copyright (c) 2018, Hèctor Marquès
> 
> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
> 
> Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
> Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
> 
> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
