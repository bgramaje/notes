### 👨‍🏫 SPRING FRAMEWORK
> The Spring framework is an open-source Java application framework, which is based on two key principles: dependency injection and Inversion of Control.

### Inversion of Control
Process in which an object defines its dependencies without creating them.

### `@Component` or Bean
Un Bean, son los objetos/componentes que forman el backend del servidor. Un ejemplo, seria el típico ejemplo de 'Producto'. Un bean es iniciado, ensamblado y manejado por el container de Spring. Se declara de la siguiente manera:

```java
@Component
public class Example {
    //...
}
```

Imaginemos que tenemos una clase 'Experimento', que necesita de una clase 'Categoria'.

```java
//Categoria.java
public interface Categoria {
    //...
}
```

```java
//Experimento.java
public class Experimento {
    private Categoria cat;
    
    public Experimento(Categoria cat) {
        super();
        this.cat = cat;
    }
}
```

A la hora de crear una clase Experimento, necesitamos pasar un objecto de la clase Categoria al constructor de esta:

```java
//Main.java
Experimento exp = new Experimento(new Categoria());
```

El problema de este approach es que las clases tienen una relación muy fuerte. Si se diera el caso de que en vez Experimento necesitase de otro tipo de Categoria, tendríamos que cambiar el código unicamente y exclusivamente por ese motivo. Entonces se hace uso de los beans para producir un código más genérico y asbtracto sin tanta dependencia entre clases.

Entonces el approach a seguir sería el siguiente; Se declaran ambas clases como componenetes, y se realiza la notación de @autowired para indiciar la dependecia de que Experimento necesita una categoría. The @Autowired annotation tells Spring that 'Experimento' needs an object of type 'Categoria'.


```java
//Experimento.java
@Component
public class Experimento {
    @Autowired
    private Categoria cat;
    //...
}
```

```java
//Categoria.java
public interface Categoria {
    //...
}
```

```java
//Animales.java
@Component
public class Animales extends Categoria {
    //...
}
```

En este caso, Spring nos creará un Experimento con una categoria la cual esta extiende de la interfaz Categoria. Al ser `Animales.java` la única categoria que extiende de la interfaz, Spring nos asociará automaticamente el objecto `exp`  con la categoria de `Animales.java` 

```java
//Main.java
ApplicationContext appContext = SpringApplication.run(ExampleApplication.class, args);
//use ApplicationContext to find which filter is being used, the one with the @Component tag.
Experimento exp = appContext.getBean(Experimento.class);	
```
### Autowiring by `@Primary`, `@Qualifier` and Name
Hasta aqui hemos visto el uso de beans, pero que pasa si tenemos otra categoria? Como sabe Spring que categoría debe elegir dependiendo del experimento? Para este caso tenemos el autowiring por tipo con el `@Primary`, o por `@Qualifier` o por Nombre.

#### *Autowiring by `@Primary`*

Creamos una nueva categoria:

```java
//Plantas.java
@Component
public class Plantas extends Categoria {
    //...
}
```

Junto con la de Animales previa:

```java
//Animales.java
@Component
public class Animales extends Categoria {
    //...
}
```

```java
//Experimento.java
@Component
public class Experimento {
    @Autowired
    private Categoria cat;
    //...
}
```
Ahora cuando creemos un experimento, Spring dará error, por que no sabe que categoría elegir al haber mas de un bean. En este caso se pueden implementar 3 soluciones. La primera y más sencilla es con el `@Primary`, pero es la menos recomendada ya que no te deja 'jugar' entre distintas categorias para experimentos. Siendo asi su implementación:

```java
//Plantas.java
@Component
@Primary
public class Plantas extends Categoria {
    //...
}
```

Junto con la de Animales previa:
```java
//Animales.java
@Component
public class Animales extends Categoria {
    //...
}
```

A partir de ahora, todos los experimentos que creemos, tendran la categoría Plantas, puesto que esta clase es la que contiene la anotación `@Primary`. Si a la clase de `Animales.java` también añadimos `@Primary`, Spring lanzará un erro puesto no sabe que clase debe elegir ya que ambas tienen la misma prioridad. 

#### *Autowiring by Name*

En vez de usar el `@Primary`, simplemente con usar el mismo nombre en la variabl de la clase que vamos a usar es suficiente. Es decir: 

```java
//Experimento.java
@Component
public class Experimento {
    @Autowired
    private Categoria Plantas;
    //private Categoria cat;
    //...
}
```

Como el nombre de la variable es igual a el nombre de la clase que implementa la interfaz de Categoria, Spring lo reconoce automáticamente, y sabe que clase poner. Los nombres tanto de la variable como de la clase deben de ser exactamente igual puesto que Spring lanzará el siguiente error de `NoUniqueBeanDefinitionException`.

> The autowiring by name approach is advantageous when we want to use one bean in one situation and another bean in some other situation. Using @Primary will always give preference to one bean, which is impractical if we want to use different beans in different scenarios. 

