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

length(cons(s(s(0)), cons(0, nil)))
→<sub>(1)</sub> s(length(cons(0, nil)))
→<sub>(1)</sub> s(s(length(nil)))
→<sub>(0)</sub> s(s(0))

> Cada flecha dice el número de la regla que hemos usado para reescribir los términos.
