import UIKit

var str = "Hello, playground"


var parentChildPairs2 = [(1,3),(2,3),(3,6),(5,6),(5,7), (4,5), (15,21), (4,8),(4,9),(9,11), (14,4), (13,12), (12,9), (15,13)]

var dicPadreRelatedHijos : [Int:Set<Int>] = [:]
var dicHijosRelatedPadres : [Int:Set<Int>] = [:]


func hasCommonAncestor(parentChildPair:[(Int, Int)], input1: Int , input2: Int) -> Bool{
   
    for ptCP in parentChildPair {
        
        //Se hacen nodos de padres con cada uno de sus hijos cercanos
        if dicPadreRelatedHijos.keys.contains(ptCP.0) {
            dicPadreRelatedHijos[ptCP.0]?.insert(ptCP.1)
        }else {
            var hijosAux = Set<Int>()
            hijosAux.insert(ptCP.1)
            dicPadreRelatedHijos[ptCP.0] = hijosAux
        }
        
        //Se hacen nodos de hijos con cada uno de sus padres cercanos
        if dicHijosRelatedPadres.keys.contains(ptCP.1){
            dicHijosRelatedPadres[ptCP.1]?.insert(ptCP.0)

        }else{
            var hijosAux = Set<Int>()
            hijosAux.insert(ptCP.0)
            dicHijosRelatedPadres[ptCP.1] = hijosAux
        }
    }
    
    //Del nodos dicHijosRelatedPadres, se obtinen la lista de los padres cercanos que estemos buscando en la entrada
    guard let pathers1 = dicHijosRelatedPadres[input1] else {return false}
    guard let pathers2 = dicHijosRelatedPadres[input2] else {return false}
    
    
    
    return searcPatherCommunInNodePathers(listOfPather1: pathers1, listOfPather2: pathers2)
    
    
    
}


func searcPatherCommunInNodePathers(listOfPather1: Set<Int>, listOfPather2: Set<Int> ) -> Bool{
    var lineAncestor1 = listOfPather1
    var lineAncestor2 = listOfPather2
    
    //Se buscan las listas de padres en el nodo "dicPadreRelatedHijos", dado que un padre puede ser un hijo de otro padre
    for nodePather in dicPadreRelatedHijos {
        
        //si se encuantra una coincidencia entre las listas de padres y listas de hijos que tiene cada padre, tomamos el padre superior y lo guardamos para encontrar una coicidencia entre los padres superiores
        let nodePatherContainHijo1 = nodePather.value.intersection(listOfPather1)
        if (!nodePatherContainHijo1.isEmpty ){
            lineAncestor1.insert(nodePather.key)
        }
        
        let nodePatherContainHijo2 = nodePather.value.intersection(listOfPather2)
        if (!nodePatherContainHijo2.isEmpty ){
            lineAncestor2.insert(nodePather.key)
        }
        
        //Se buscan coicidencias entre los ancestros
        let commonAncestor = lineAncestor1.intersection(lineAncestor2)
        if (!commonAncestor.isEmpty ){
            return true
        }
    }
    return false
    
}

print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 3, input2: 8))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 5, input2: 8))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 6, input2: 8))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 6, input2: 9))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 1, input2: 3))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 3, input2: 1))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 7, input2: 11))
print(hasCommonAncestor(parentChildPair: parentChildPairs2, input1: 6, input2: 5))


/**
 
 Ejemplo de  estructura  de nodos en diccionarios.
 1   2    4          30
  \ /     /  \               \
   3   5    9  15      16
    \ / \     \ /
    6   7   12
 
 
 Estructura de nodos creados
 
 dicPadreRelatedHijos
 5:6,7
 1:3
 2:3
 3:6
 15:12
 4:5,9
 9:12
 30:16


 dicHijosRelatedPadres
 6:5,3
 7:5
 3:1,2
 12:15,9
 5:4
 9:4
 16:30
 */



