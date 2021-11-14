### 👨‍🏫 Rewrite Systems
> Rewrite Systems

#### Motivation

A list [2,0] is represented as follows:

```
cons(s(s(0)), cons(0, nil))
```
> El término cons tiene una aridad de 2. El primero es el elemento que queremos introducir a la lista, y el segundo, es la lista ya definida. En este caso de trata de otro cons el cual se le añade un 0 a la lista vacía 'nil'

The evaluation of length(cons(s(s(0)),cons(0,nil))) should produce 2, i.e., s(s(0))

Para poder comprobar esto, aplicamos 'deduccion' el cual representamos lo que queramos comprobar como un conjunto de reglas, `rewrite rules`. En este caso:

```
length(cons(s(s(0)), cons(0, nil))) →∗ s(s(0))
``` 

> Decimos que el length declarado de arriba, se sobreescribe en uno o más pasos (*) en s(s(0)), que es el número 2 representado en notación de Peano.

#### Como hacer un rewrite system.
* The transformations are introduced by means of a set R of rewrite rules l → r, where l and r are terms. We call R a Term Rewriting System. The rules are treated as axioms of the form. (∀x) l → r. 
> Donde ~x, contiene las variables de l y r,  y → is a binary predicate. En el caso anterior, l = length(cons(s(s(0)), cons(0, nil))), y r = s(s(0)), siendo ambos términos como dice la teoría.
* The one-step rewriting steps are propagated into the syntactic structure of terms by means of axioms
* Predicate →∗ representing many-step (i.e., zero or more) computations is given the following axioms*
> (∀x) x →∗ x, (∀x)(∀y)(∀z) x → y ∧ y →∗ z


Given a Term Rewriting System R, the set of axioms obtained in this way (which is a first-order theory) is denoted as R- (R barrita arriba)

Un ejemplo de un TRS(Term Rewriting System) es: 

```
length(nil) → 0
length(cons(x, xs)) → s(length(xs))
``` 

> Sabemos que el length(nil), el cual representa una lista vacía, es 0. Y El length de cons(x,xs) va a ser el sucesor del lenght(xs), puesto que vamos a meter un elemento x en la lista xs, y su length va a ser el siguiente sucesor del length quye había previamente en la lista.

> Cada regla que hay ahi, se le dice axioma?

When using `Rewrite Rules` we obtain a `Term Rewriting System (TRS)` where we use `Term Rewriting` where we replace, within an expression, instances of the left-hand side of a rule by the corresponding instance of the right-hand side.

Entonces dado el siguiente TRS:

```
length(nil) → 0                         (0)
length(cons(x, xs)) → s(length(xs))     (1)
``` 
 
> Acordarse que todas las reglas en un TRS, todas las variables de cada regla se encuentran implicamente universalmente cuantificadas!

Calcula length(cons(s(s(0)), cons(0, nil)))?

length(cons(s(s(0)), cons(0, nil))) <br>
→<sub>(1)</sub> s(length(cons(0, nil)))<br>
→<sub>(1)</sub> s(s(length(nil)))<br>
→<sub>(0)</sub> s(s(0))<br>

> Cada flecha dice el número de la regla que hemos usado para reescribir los términos.


#### Notations on terms

Let `t` be a term.

* Var(t) is the set of variables occurring in `t`
* If Var(t) = ∅, then we say that `t` is *ground*
* The set of ground terms is denoted T(F) (rather than T(F, ∅))
* If t contains no multiple occurrences of the same variable, then `t` is *linear*
* root(t) is the symbol labelling the root of t
    * root(t) = t if t ∈ X
    * root(f (t1, . . . ,tk )) = f if f ∈ F.

> El root de un término es su propio término, root(t) = t if t ∈ X. Al igual que si se tratase de una función root(f(t1, . . . ,tk )) = f if f ∈ F

Dado el ejemplo de un término por ejemplo x + x, que se escribe de normal, sin el azucar sintáctico como +(x,x); su root es +, por root(f(t1, . . . ,tk )) = f if f ∈ F.

Let x,y ∈ X , t = x + x and s = cons(x,cons(y,nil)).

> El término t *NO es lineal* debido a que hay mas de una ocurrencia de una misma variable en el término. t = x + x, con lo que aparece 2 veces la misma variable x, por tanto no es lineal. El término s *SI es lineal*, por que su Var(s), no se repite mas de una vez, solo existe una única x e y en el término. También sabemos que Var(t) = {x}, Var(s) = {x, y}, root(t) = + y root(s) = cons

#### Terms as trees.

A position p is a (possibly empty) chain of positive integers. The length of a position p is |p|.

```
p ∈ Pos = {Λ} ∪ {i.q | i ∈ N>0 ∧ q ∈ Pos}
```

> Simplemente como se nombran en el arbol cada rama, el 'numerito' de 1, 1.1, 1.1.1, ...

The set of positions of a term t is

Pos(t) = {Λ} if t ∈ X <br>
Pos(t) = {Λ} ∪U<sub>1≤i≤k</sub>i.Pos(t<sub>i</sub>) if t = f (t1, . . . ,tk )

> Si el termino es una variable, el conjunto de posiciones va a ser Λ(Λ es la primera posición de arbol) puesto que no hay nada mas. Y si se trata de una función, sera Λ más todo lo que cuelga. En caso de una suma +(x,y) el conjunto de posiciones sería ) {Λ,1,2} dando un arbol parecido así:
```
+(x,y)    → t
├─ +      → Λ
│  ├─ x   → 1
│  ├─ y   → 2
```

Pos(t) = {Λ,1,2}

Los subtérminos de t a una determinada posición se representa como t|<sub>p</sub> donde t|<sub>Λ</sub> = t and f (t<sub>1</sub>, . . . ,t<sub>k</sub> )|<sub>i.p</sub> = t<sub>i</sub>|<sub>p</sub>

Básicamente, en el ejemplo anterior t|<sub>Λ</sub> = +(x,y), t|<sub>1</sub> = x, y  t|<sub>2</sub> = y. Se coge todo lo que cuelga por debajo. Es decir si hubiera un subtérmino 1.1, debajo de 1. El subtérmino en la posicion 1, sería el que esta en la posicion 1, Y el que esta en la posicion 1.1.

The depth of subterm s = t|p is the length |p| of p.

Pos<sub>F<sub>(t) is the set of positions of nonvariable subterms in t.
> *`PosF(t)`* es el conjunto de t que no varía, es decir, las funciones y constantes. O hay algo más?

#### Subterm replacement.

We let t[s]<sub>p</sub> be the term t where t|p has been replaced by s.

For t = f(f(x,a),y) we have Pos(t) = {Λ, 1, 2, 1.1, 1.2}.
```
f(f(x,a),y)    → t
├─ f           → Λ
│  ├─ f        → 1
│  │  ├─ x     → 1.1
│  │  ├─ a     → 1.1
│  ├─ y        → 2
```

t|<sub>Λ</sub> = f(f(x,a),y) <br>
t|<sub>1</sub> = f(x,a) → se coge todo lo que hay por debajo también!<br>
...

Y luego nos pueden hacer sustituciones como por ejemplo:

t[b]<sub>1</sub> = f(b,y) → Coger el termino t desde Λ en la primera posicion y cambiarlo por b. <br>
t[b]<sub>1</sub>[a]<sub>2</sub> = f(b,a) → Coger el termino t desde Λ en la primera posicion y cambiarlo por b, y coger el termino t en la segunda posicion y cambiarlo por a.

#### Substitutions

Dom(σ) = {x ∈ X | σ(x) != x}.

σ*barrita*(x) = σ(x) and σ(f (t<sub>1</sub>, . . . ,t<sub>k</sub> )) = f (σ(t<sub>1</sub>), . . . , σ(t<sub>k</sub>))

Se declara de la siguiente manera:

σ = {x<sub>1</sub> → t<sub>1</sub>, . . . , x<sub>n</sub> → t<sub>n</sub>}.

> The identity or empty substitution is written ε (note that Dom(ε) = ∅), cuando hacemos una sustitución vacía aplicando una regla de reescritura.

#### Matching, unification

A term *`l` matches `t`* if there is a substitution σ (the matcher of t against) such that t = σ(l). Two terms *`s` and `t` unify* if there is a substitution σ (a unifier of s and t) such that σ(s) = σ(t).

> Matching → Cuando instanciando *UNA* obtenemos la misma función t = σ(l). Unify  → Cuando instanciando *AMBAS* obtenemos la misma función σ(s) = σ(t). *`SOLO SE APLICA A VARIABLES. A CONSTANTES NO!`*

For l = f(x,y), s = f(f(z,a),y), and t = f(x,a), we have:
> Ejercicio hecho en una hoja de los apuntes, bien detallado.

* l *matches* both s and t. (s y t se ajustan al patrón de l)
```
l = f(x,y) U σ = {x → f(z,a)} → σ(l) = f(f(z,a),y) → s
l = f(x,y) U σ = {y → a)} → σ(l) = f(x,a) → t
```
* s and t *unify*
```
s = f(f(z,a),y) U σ = {x → f(z,a), y → a)} → σ(l) = f(f(z,a),a)
t = f(x,a) U σ = {x → f(z,a), y → a)} → σ(l) = f(f(z,a),a)
```
> Al usar la misma substitucion e instar ambos términos, obtenemos lo mismo, por lo tal, s y t unifican.
* t does *not match* s
> No podemos debido a que no se pueden instanciar constante. En este caso estamos intentando hacer que s se convierta en t. Para hacer eso la x → f(z,a), y a → y, pero no podemos modificar las constantes, y a es una constante.
* s and s|<sub>1</sub> do *not unify*
> No se puede porque generaría bucle. Instanciariamos z → f(z,a), pero al sustituir tendriamos un bucle ya que z sed transforma en algo que tambien contiene z. Esto se le suele llamar *`OCCUR-CHECK`*
* s and f(y,a) do *not unify*
> No no se pueden hacer dos sustituciones diferentes sobre la misma variable.

#### Rewrite Rules

A rewrite rule is an ordered pair l → r, where l,r ∈ T (F, X ) are called the left- and right-hand-sides (lhs and rhs for short), respectively, and:
* l !∈ X (the left-hand side is not a variable),
* Var(r) ⊆ Var(`) (there is no extra variable)

> En una regla de reescritura (l → r), la parte izquierda de esta(l), no puede ser una variable o constante. En la parte derecha r, no deben de haber variables extras, y la aridad de las funciones se deben de mantener en las dos partes.

```
if (true, x, y) → x   → OK
x → 0 + x             → ERROR (x es una variable en la parte izq, no puede haber solo una variable.)
```

##### Tipo de rewrite rules
* *`left-linear`* 
> Si 'l' es un término lineal. → No hay más de una ocurrencia de una misma variable (p.ej 2 x's), en la parte izquierda.
* *`right-linear`* 
> Si 'r' es un término lineal. → No hay más de una ocurrencia de una misma variable (p.ej 2 x's), en la parte derecha.
* *`linear`* 
> Si 'l' y 'r' son lineales. → No hay más de una ocurrencia de una misma variable (p.ej 2 x's), en ninguna de las dos partes.
* *`colapsante/collapsing`* → if r ∈ X. 
> Si la parte derecha es una variable. La parte izq *NO* puede ser una variable, pero la parte derecha *SÍ*
* *`duplicante`* 
> Si la variable 'x' o cualquiera, tiene más ocurrencias en la parte derecha r que en la parte izquiera l. 
> Si es *`linear`*  o *`right-linear`* , no puede ser duplicante.
* *`duplicante`* 
> Si la variable 'x' o cualquiera, tiene más ocurrencias en la parte derecha r que en la parte izquiera l. 
* *`conservative/conservativa`* → Var(l) = Var(r). 
> Si ambas partes tienen las mismas variables
* *`destructiva`* → Var(l) ⊃ Var(r). 
> ? Si l contiene las variables de r pero r no las de l.

#### Term Rewriting System

A Term Rewriting System (TRS) is a pair R = (F, R) such that F is a signature and R is a set of rewrite rules over the signature F.

#### Redex 

An instance σ(l) of the left-hand side l of a rule l → r is called a redex ('red'ucible 'ex'pression) of the rule.

> Un redex es cualquier instancia que has cambiado de l con lo del σ = {...} 

```
from(x) → x : from(s(x))
t1 = from(zero) *σ = {x → zero}*
y su PosR(t1) = {Λ, 1}
*t1 is a redex of the above rule*
```
> PosR es el conjunto de posiciones del redex. Donde cambiamos los valores.

A Term Rewriting System R = (F, R) is called:

* *`left-linear`* 
* *`right-linear`* 
* *`linear`* 
* *`conservative/conservativa`*

if *`EACH`* rule has the corresponding property.

> *`TODAS`* las reglas del sistema han de tener la propiedad para ser llamada de algo de arriba. Si es left-linear, todas las reglas son left-linear, etc...

On the other hand:

* *`collapsing`* 
* *`duplicating`* 

if *`AT LEAST ONE`* rule has the corresponding property.

> *`CON UNA`* de las reglas con una de las propiedades de arriba sobra para hablar de que todo el sistema entero tiene esa propiedad.


#### Normal form

Let R = (F, R) be a TRS and t ∈ T (F, X ). We say that t is an R-normal form (or just a normal form if R is clear from the context) if no rewriting step is possible on t (equivalently, if t contains no redex of R).

> t es una forma normal, si no se puede aplicar ninguna regla de reescritura sobre el. Es decir, no contiene ningún Redex.