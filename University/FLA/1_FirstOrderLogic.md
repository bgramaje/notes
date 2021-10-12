### 👨‍🏫 First Order Logic
> First Order Logic, es un framework universal, simple y familiar para determinadas cosas.

#### Definintion

First-order logic is an appropriate (simple, familiar) framework to:
* *specify* programs `syntax`.
* *describe* computations `semantics`-
* *specify* properties about programs.
* *reason* about computations and program properties `verification`.

#### Signatures
[EN] A signature is a set of symbols together with a mapping ar which indicates the number of arguments associated to each symbol (i.e., its arity). 
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

Se trata de una pareja de  Σ = (F, Π), donde F es una signature de `function symbols` y Π una signature de `predicate symbols`. A signature σ consists of a set of constant symbols, a set of function symbols and a set of predicate symbols. Each function and predicate symbol has an arity k > 0.


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

* Las operaciones `isClever`, `teacherOf`, `isPhilosopher`, `colleagues` son un símbolo de predicado.
* `Monadic`, significa un operadior unario, de un solo argumento en griego? 
* `homer`,  `plato`, `socrates`, son constantes puesto que no tienen ningún indice de aridad (lo de la parte izq de la ->).
* `colleagues` se trata de una operacion binaria puesto que tiene una aridad de 2 (2 argumentos).

Los predicados no son términos, sino fórmulas.

#### Términos (Terms)

Los términos son definidos como:

*[EN]*

* `T-Base1` - Variable symbols `x` are terms
* `T-Base2` - Constant symbols a (i.e: ar(a) == 0) are terms
* `T-Induction` - If F is a K-ary funcion symbol (i.e: k = ar(f)), where k>0 (not a constant), and t1,.....,tk are terms, then f (t1, . . . ,tk ) is a term.

*[ES]*

*  `T-Base1` - Todas las variables son términos.
*  `T-Base2` - Todas las constantes `constant symbol` son términos.
* `T-Induction` - Si t1,.....,tk son términos y 'f' es una función de k-aridad entonces f(t1,.....,tk) es un término

The set of terms is denoted as `T(F,X)` | `(also T(Σ, X))`.

##### Terms - Use

*  `Arithmetic expressions ` : x + (y + z), x × y + x × z, x + 0.
*  `Data structures` : Numbers n are represented in Peano’s notation as sn(0) (only two symbols are necessary: 0 and s!).
*  `Function calls` : 2+1 (or s(s(0)) + s(0)) represents a call to the addition operator.
*  `Assignments` : counter := 3 is a term: ‘:=’ is a `binary symbol` ; counterand 3 are constant symbols.
*  `Conditional statements` : if n > 0 then n := n-1 else n := n+1 is a term: ‘if’ is a ternary symbol, > is a binary operator,

Las operaciones aritméticas son terminos. Los numeros, se representan como sucesiones de Peano. Las llamadas a las funciones, sus parámetros tambien se hacen con las sucesiones de Peano, si estos son números. Las asignaciones son un símbolo binario, `binary symbol`.

La función fact(0) es un término puesto que la aridad de esta es de k-ary = 1, y el parámetro que tiene es una variable que es un término. Al ser t1 un término y k-ary = 1, la funcón fact(0) por inducción es un término?

> Ese 0 de fact(0), esta representado como 0 de toda la vida, o como 0 de sucesión de Peano? Y en términos a partir de ahora todos los números tienen que ser representados como sucesión de Peano? 

Tener cuidado con los condiciones.

Los condicionales siguen de normal lo siguiente:

*Suponiendo: if n > 0 then n := n-1 else n := n+1*, donde el If es un símbolo ternario, cuya aridad es 3, y el <> es un simbolo bínaro, cuya aridad es 2 (`_<>_`)

```
if_then_else : Bool Int Int -> Int
```

Con lo que si se supone que se usa lo siguiente: *if n > 0 then n := 0*, este NO es un término debido a que no presenta la aridad 3, al faltar el else. Y el *+1* tampoco, por que la asignación de un valor a una variable es de aridad 2: `_:=_`

###### Sucesion de Peano
Únicamente dos símbolos 0 y S! ¿Porqué?

```
0 = 0
1 = S(0)
2 = S(S(0))
3 = S(S(S(0)))
```

Donde S significa `sucesor`, y el número n = S<sup>n</sup>(0)

#### Fórmulas

Los fórmulas son definidas como:

*[EN]*

* `F-Base1` - if P is an n-ary predicate symbol and t1, . . . ,tn are terms, then P(t1, . . . ,tn) is a formula (which is called an atom)
* `F-Induction1` - if φ and φ' are formulas, then φ ∧ φ' and ¬φ (and also φ ∨ φ', φ ⇒ φ',...) are formulas.
* `F-Induction2` - if x is a variable and φ is a formula, then (∀x) φ and (∃x) φ are formulas

*[ES]*

* `F-Base1` - Si un predicado P de aridad K, todos sus argumentos son términos t1,.....,tl. Entonces P(t1,.....,tk) es una fórmula. tambien llamada como `átomo`
* `F-Induction1` - Si φ and φ' are formulas, entonces φ ∧ φ' y ¬φ (and also φ ∨ φ', φ ⇒ φ',...) son formulas, es decir, cualquier operacion de AND;OR;NOT:XOR:etc, sobre dos formulas, tambien es una fórmula.
* `F-Induction2` - Si x es una variable y φ es una fórmula, entonces (∀x) φ y (∃x) φ son formulas. 

#### Sentence 
*[EN]* A sentence is a well-formed formula whose variables are all quantified.
<br>

*[ES]* Esto tiene que aparecer SIEMPRE en todas las variables que aparezacan sobre la formula. Si hay dos variables, en las dos tiene que aparece un para todo (∀) o un existe (∃) sobre estas variables.

```
isPhilosopher(socrates)
(∀x) isPhilosopher(x) ⇒ isClever(x)
(∀x)(∀y) colleagues(x, y) ⇒ colleagues(y, x)
```

* isPhilosopher(socrates) es una fórmula; puesto que socrates es una variable que se ha declarado anteriormente, con lo que es un término, y al tratarse de un predicado por que devuelve un boolean, y todos los parámetros respecto a su aridad son términos, este predicado a su vez es una fórmula. `F-Base1`

* (∀x) isPhilosopher(x) ⇒ isClever(x) se trata de una fórmula, puesto que philosopher es un predicado cuyo parametro (la variable x) es un término, con lo que para  (∀x) φ  es tambien una fórmula `F-Induction2`. 
> En este caso tambien se trata de una sentece?, puesto que todas las variables que participan en esta fórmula estan cuantificadas.

#### Literals and Clauses

Un literal `L` es o un átomo, o la negación de un átomo.

Una Clause `C` es una disyunción L1 ∨ · · · ∨ Ln de literales, normalmente representado como un `set`. Implicitamente todas las variables dentro de la clausula están universalmente cuantificadas. 

```
{ { isPhilosopher(socrates) },{ isClever(homer) },{ teacherOf(socrates,plato) } }
```

El ejemplo de arriba sería un conjunto de set, en este caso 3, que únicamente disponen de 1 literal, que este a su vez es un átomo.

> Every well-formed formula ϕ can be expressed as a set Cϕ of clauses

A → B, es lo mismo que ¬A ∨ B, que cuya versión clausal, sería { ¬A,B }.

De noraml los simbolos de función son entendidos como funciones, y los simbolos de predicado como relaciones.

#### Evaluation mapping

<p>A valuation mapping α : X → D gives values to the variable symbols. The evaluation mapping [_]<sup>A</sup><sub>α</sub> : T (F, X ) → D (also [_]<sup>MA</sup><sub>α</sub> if A is part of M) is defined as follows: for all terms t ∈ T (F, X )</p>

*  (ET-Base1) if t is a variable symbol x, then [x]<sup>A</sup><sub>α</sub> = α(x)
*  (ET-Base2) if t is a constant symbol a, then [a]<sup>A</sup><sub>α</sub> = a<sup>A</sup>
*  (ET-Induction) if t = f (t1, . . . ,tk ) for some k-ary function symbol f and terms t1, . . . ,tk , then [f (t1, . . . ,tk )]<sup>A</sup><sub>α</sub> = f<sup>A</sup>([t1]<sup>A</sup><sub>α</sub> , . . . , [t1]<sup>A</sup><sub>α</sub> ).

Ejemplo: 

*Let F = {0,s} with ar(0) = 0 and ar(s) = 1. Let A = (N, F<sub>N</sub>) be givenby 0<sup>A</sup> = 0 and s<sup>A</sup>(x) = x + 1 for all x ∈ N. For any valuation function α.*

En este caso tenemos F que es {0,s}, y nos expresa que la aridad de 0, ar(0) = 0, con lo que es una constante. Y que la aridad de s, ar(s) = 1, con lo que admite un argumento. Dandonos un conjunto de valores para el dominio que pertenece a los numeros naturales, por 0<sup>A</sup> = 0 and s <sup>A</sup>(x) = x + 1 para todo x ∈ N. Evaluamos con las reglas anteriores.

El primer caso es 0, puesto que al tener aridad 0 se trata de una constante, y según la regla de `ET-Base2`, [a]<sup>A</sup><sub>α</sub> = a<sup>A</sup>, esto será igual a [0]<sup>A</sup><sub>α</sub> = 0<sup>A</sup>, que según el enunciado, 0<sup>A</sup> = 0, con lo que para este caso, [0]<sup>A</sup><sub>α</sub> = 0.

En referente al siguiente término a evaluar que es [s(s(0))]<sup>A</sup><sub>α</sub>, eso según la regla de `ET-Induction`, eso es igual a s<sup>A</sup>([s(0)]<sup>A</sup><sub>α</sub>). Como en la regla nos dice que s<sup>A</sup>(x) = x + 1, y nosotros tenemos s<sup>A</sup>(x) siendo x el valor: ([s(0)]<sup>A</sup><sub>α</sub>), eso será igual a ([s(0)]<sup>A</sup><sub>α</sub>) + 1 y siguiendo la lógica

* [ s ( s(0) )]<sup>A</sup><sub>α</sub> → s<sup>A</sup>([ s(0) ]<sup>A</sup><sub>α</sub>) *`aplicando ET-Induction`* <br>   
* s<sup>A</sup>([ s(0) ]<sup>A</sup><sub>α</sub>) → ([ s(0) ]<sup>A</sup><sub>α</sub>) + 1 *`aplicando la igualdad de` s<sup>A</sup>(x) = x + 1, siendo x el s(0)* <br> 
* ([ s(0) ]<sup>A</sup><sub>α</sub>) + 1 → s<sup>A</sup>([(0)]<sup>A</sup><sub>α</sub>) *`aplicando ET-Induction`* <br>
* s<sup>A</sup>([(0)]<sup>A</sup><sub>α</sub>); → ([0]<sup>A</sup><sub>α</sub> + 1) + 1 *`aplicando la igualdad de` s<sup>A</sup>(x) = x + 1, siendo x el 0*<br>
* ([0]<sup>A</sup><sub>α</sub> + 1) + 1 → (0<sup>A</sup> + 1) + 1 *`aplicando ET-Base2, puesto que 0 es una constante al tener aridad 0` [0]<sup>A</sup><sub>α</sub> = 0<sup>A</sup><br>*
* (0<sup>A</sup> + 1) + 1 → (0 + 1) + 1 *`aplicando la igualdad de` 0<sup>A</sup>* = 0<br> 
* (0 + 1) + 1 → 2 *`aplicando ya la suma normal y corriente`*<br>

##### Diapositiva 12.
Ejemplo con validación (con variables).

Cuando declara *x +<sub>A</sub> y = x + y*, &&  x multiply <sub>A</sub> y = x*, para todos x, y ∈ N. Eso significa que la y puede ser z o cualquier otra letra (sin tener en cuenta las de las constantes)? Porque al hacer [x × y]<sup>A</sup><sub>α</sub>, = [x]<sup>A</sup><sub>α</sub>, ya que se cumple que x y y = x, pero cuando lo hace con 'z', también [x × z]<sup>A</sup><sub>α</sub>, = [x]<sup>A</sup><sub>α</sub>

A parte de esto es que cuando tienes [x]<sup>A</sup><sub>α</sub>, y sabes su función de validación, la cual te la dice el enunciado como α(x) = α(y) = 2, eso implica que *[x]<sup>A</sup><sub>α</sub> = α(x) = 2*.