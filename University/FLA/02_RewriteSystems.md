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
* The transformations are introduced by means of a set R of rewrite rules ` → r, where ` and r are terms. We call R a Term Rewriting System. The rules are treated as axioms of the form. (∀~x) ` → r. 
> Donde ~x, contiene las variables de l y r,  y → is a binary predicate. En el caso anterior, l = length(cons(s(s(0)), cons(0, nil))), y r = s(s(0)), siendo ambos términos como dice la teoría.
* The one-step rewriting steps are propagated into the syntactic structure of terms by means of axioms
* Predicate →∗ representing many-step (i.e., zero or more) computations is given the following axioms*
> (∀x) x →∗ x, (∀x)(∀y)(∀z) x → y ∧ y →∗ z


Given a Term Rewriting System R, the set of axioms obtained in this way (which is a first-order theory) is denoted as R- (R barrita arriba)

Un ejejmplo de un TRS(Term Rewriting System) es: 

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

Dado el ejemplo de un término por ejemplo x + x, que se escribe de noraml +(x,x), su root es +, por root(f(t1, . . . ,tk )) = f if f ∈ F.

Let x,y ∈ X , t = x + x and s = cons(x,cons(y,nil)).

> El término t *NO es lineal* debido a que hay mas de una ocurrencia de una misma variable en el término. t = x + x, con lo que aparece 2 veces la misma variable x, por tanto no es lineal. También sabemos que Var(t) = {x}, Var(s) = {x, y}, root(t) = + y root(s) = cons

#### Terms as trees.

A position p is a (possibly empty) chain of positive integers. The length of a position p is |p|.

```
p ∈ Pos = {Λ} ∪ {i.q | i ∈ N>0 ∧ q ∈ Pos}
```

> Simplemente como se nombran en el arbol cada rama, el 'numerito' de 1, 1.1, 1.1.1, ...

The set of positions of a term t is

Pos(t) = {Λ} if t ∈ X
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

> PosF (t) is the set of positions of nonvariable subterms in t

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

> The identity or empty substitution is written ε (note that Dom(ε) = ∅).

#### Matching, unification

A term *`l` matches `t`* if there is a substitution σ (the matcher of t against`) such that t = σ(l). Two terms *`s` and `t` unify* if there is a substitution σ (a unifier of s and t) such that σ(s) = σ(t).

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



