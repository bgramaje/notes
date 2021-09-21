### 👨‍🏫 First Order Logic
> First Order Logic, es un framework universal, simple y familiar para determinadas cosas.

#### Definintion

First-order logic is an appropriate (simple, familiar) framework to:
* *specify* programs `syntax`.
* *describe* computations `semantics`-
* *specify* properties about programs.
* *reason* about computations and program properties `verification`.

#### Signatures
[EN] A signature is a set of symbols together with a mapping ar which indicates the number of arguments associated to each symbol (i.e., its arity). A signature σ consists of a set
of constant symbols, a set of function symbols and a set of predicate symbols. Each function and predicate symbol has an arity k > 0.
<br><br>
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

En los operadores hay que diferenciar una estructura básica. A la hora de declarar el operador, hay que hacerlo siguiendo mas menos la estructura que se ha usado en la programación de toda la vida. Por ejemplo, el operador declarado arriba como `_+_`.

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

El operador `_+_`, tiene una aridad de dos, puesto admite dos argumentos, de tipo Numbers Numbers (lo de antes de la ->), y devuelve un valor de tipo Numbers (lo de despues de la ->). Al tener una aridad de 2, se le suele llamar `operador binario`. El caso de que solo tenga un argumento, p.e. calcular el factorial de un número se tratará de un `operador unario`, y si tiene tres, se le diria un `operador ternario`, lo siguiente de ahi ya son `operadores n-arios`.

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
    op isPhilosopher : Human -> Bool . *** Monadic
    op isClever : Human -> Bool . *** predicates
    op colleagues : Beings Beings -> Bool . *** Binary
    op teacherOf : Beings Beings -> Bool . *** predicates
endm
```

* Las operaciones `isClever`, `teacherOf`, ¿`isPhilosopher`, `colleagues`? son un símbolo de predicado.
* `Monadic`, significa un operadior unario, de un solo argumento en griego? 
* `homer`,  `plato`, `socrates`, son constantes puesto que no tienen ningún indice de aridad (lo de la parte izq de la ->).
* `colleagues` se trata de una operacion binaria puesto que tiene una aridad de 2 (2 argumentos).

#### Términos (Terms)

Los términos son definidos como:

[EN]

* `T-Base1` - Variable symbols `x` are terms
* `T-Base2` - Constant symbols a (i.e: ar(a) == 0) are terms
* `T-Induction` - If F is a K-ary funcion symbol (i.e: k = ar(f)), where k>0 (not a constant), and t1,.....,tk are terms, then f (t1, . . . ,tk ) is a term.

[ES]

*  `T-Base1` - Todas las variables son términos.
*  `T-Base2` - Todas las constantes `constant symbol` son términos.
* `T-Induction` - Si t1,.....,tk son términos y 'f' es una función de k-aridadm entonces f(t1,.....,tk) es un término

The set of terms is denoted as `T(F,X)` | `(also T(Σ, X))`.

##### Terms - Use

*  `Arithmetic expressions ` : x + (y + z), x × y + x × z, x + 0.
*  `Data structures` : Numbers n are represented in Peano’s notation as sn(0) (only two symbols are necessary: 0 and s!).
*  `Function calls` : 2+1 (or s(s(0)) + s(0)) represents a call to the addition operator.
*  `Assignments` : counter := 3 is a term: ‘:=’ is a binary symbol; counterand 3 are constant symbols.
*  `Conditional statements` : if n > 0 then n := n-1 else n := n+1 is a term: ‘if’ is a ternary symbol, > is a binary operator,

Las operaciones aritméticas son terminos. Los numeros, se representan como sucesiones de Peano. 

La función fact(0) es un término puesto que la aridad de esta es de k-ary = 1, y el parámetro que tiene es una variable que es un término. Al ser t1 un término y k-ary = 1, la funcón fact(0) por inducción es un término?

> Ese 0 de fact(0), esta representado como 0 de toda la vida, o como 0 de sucesión de Peano?. Y en términos a partir de ahora todos los números tienen que ser representados como sucesión de Peano? 

###### Sucesion de Peano
Únicamentge

0 = 0
1 = S(0)
2 = S(S(0))
3 = S(S(S(0)))

> Donde S significa `sucesor`, y el número n = S^n(0).