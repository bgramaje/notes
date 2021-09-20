### 👨‍🏫 First Order Logic
> First Order Logic, es un framework universal, simple y familiar para determinadas cosas.

#### Definintion

First-order logic is an appropriate (simple, familiar) framework to:
* *specify* programs `syntax`.
* *describe* computations `semantics`-
* *specify* properties about programs.
* *reason* about computations and program properties `verification`.

#### Signatures
[EN] A signature is a set of symbols together with a mapping ar which indicates the number of arguments associated to each symbol (i.e., its arity)
<br>
[ES] Conjunto de simbolos que indican el número de argumentos asociado al simbolo; su `aridad` 

A continuación se expone un ejemplo para aritmética en el programa, (creo recordar que se llama), mod.

```
mod Arithmetics is
    sort Numbers .
    op 0 : -> Numbers . *** Constant
    op _+_ : Numbers Numbers -> Numbers . *** Binary operator
endm
```

* El `sort` es como el tipo de este. Si pensasemos en programación serían las tipicas variables de programacion: entero;char;string.
* El `op` es usado para declarar el operador, en el caso de arriba hay dos.

##### Operadores binarios

En los operadores hay que diferencias una estructura básica. A la hora de declarar el operador, hay que hacerlo siguiendo mas menos la estructura que se ha usado en la programación de toda la vida. Por ejemplo, el operador declarado arriba como `_+_`.

Para hacer una funcion que sume dos numeros, de normal hariamos lo siguiente: 

```javascript
const add = (x, y) => {
    return x + y;
}
```

En la que la función de suma se le pasan dos parámetros de tipo entero, y se le devuelve la suma de estos en modo entero. Pues para declararo en orden de primera lógica, antes de la flechita se le pasan la cantidad de parámetros que son necesarios para el operador, y despues de la flechita se indica si la función devuelve algo.

Con lo que :

```
op _+_ : Numbers Numbers -> Numbers .
```

El operador `_+_`, tiene una aridad de dos, puesto admite dos argumentos, de tipo Numbers Numbers (lo de antes de la ->), y devuelve un valor de tipo Numbers (lo de despues de la ->). Al tener una aridad de 2, se le suele llamar `operador binario`. El caso de que solo tenga un argumento, p.e. calcular el factorial de un númerom se tratará de un `operador unario`, y si tiene tres, se le diria un `operador ternario`, lo siguiente de ahi ya son `operadores n-arios`.

##### Constantes

Cuando antes de la -> en la parte izquierda, no hay declarado nada, con lo que no admite ningun argumento y su aridad es 0, significa que se trata de una constante.

```
op 0 : -> Numbers . *** Constant
```

#### Logic Signature

Se trata de una pareja de  Σ = (F, Π), donde F es una signature de `function symbols` y Π una signature de `predicate symbols`

##### Simbolos de predicado

Los símbolos de predicado, siempre devuelven un booleano. Pilla como argumento del tipo que quieras, y devuelve un booleano (`true` or `false`)

```
mod Philosophers is
    sort Human .
    ops : homer plato socrates : -> Human . *** Constants
    op isClever : Human -> Bool . *** predicates
    op colleagues : Beings Beings -> Bool . *** Binary
    op teacherOf : Beings Beings -> Bool . *** predicates
endm
```

Las operaciones `isClever`, `teacherOf`, son un símbolo de predicado.