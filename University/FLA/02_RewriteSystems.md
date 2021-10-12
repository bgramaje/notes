### 👨‍🏫 Rewrite Systems
> Rewrite Systems

#### Motivation

A list [2,0] is represented as follows:

```
cons(s(s(0)), cons(0, nil))
```
> El término cons tiene una aridad de 2. El primero es el elemento que queremos introducir a la lista, y el segundo, es la lista ya definida. En este caso de trata de otro cons el cual se le añade un 0 a la lista vacía 'nil'

The evaluation of length(cons(s(s(0)),cons(0,nil))) should produce 2, i.e., s(s(0))ç

Para poder comprobar esto, aplicamos 'deduccion' el cual representamos lo que queramos comprobar como un conjunto de reglas, `rewrite rules`. En este caso:

```
length(cons(s(s(0)), cons(0, nil))) →∗ s(s(0))
``` 

> Decimos que el length declarado de arriba, se sobreescribe en uno o más pasos (*) en s(s(0)), que es el número 2 representado en notación de Peano.



