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

#### *Autowiring by `@Qualifier`*

El último método es por un calificador, 'alias', que le pones a una clase. Siendo asi su implementación


```java
//Plantas.java
@Component
@Qualifier("Plantas")
public class Plantas extends Categoria {
    //...
}
```

```java
//Animales.java
@Component
@Qualifier("Animales")
public class Animales extends Categoria {
    //...
}
```

Posteriormente en la clase del experimento, que es la que tiene una dependencia sobre categoría, se especifíca la clase Categoria que se desea usar:

```java
//Experimento.java
@Component
public class Experimento {
    @Autowired
    @Qualifier("Plantas")
    private Categoria cat;
    //...
}
```

Al crear el experimento, este será usado con la categoria Plantas pues es que se ha declarado en la clase Experimento como: `@Qualifier("Plantas")`

```java
//Main.java
ApplicationContext appContext = SpringApplication.run(ExampleApplication.class, args);
//use ApplicationContext to find which filter is being used, the one with the @Component tag.
Experimento exp = appContext.getBean(Experimento.class);	
```

> `@Primary` annotation should be used if there is one clear favorite to be used in a majority of situations. The `@Qualifier` annotation takes precedence over the `@Primary` annotation. Eso siginifica que si tengo el `@Primary` en la clase de Animales, pero en experimento uso el `@Qualifier("Plantas")`, el experimento hará uso de la categoría de plantas.


### Constructor and setter injection

Todo lo que hemos visto hasta ahora era una inyección de dependencias de tipo `Field Injection`, pero tenemos dos tipos mas de inyección de dependencias, la : `Constructor Injection` y `Setter Injection`.

####  *`Constructor` Injection*

Es la que se realiza a través del contructor el cual tiene una dependecia sobre otro bean o clase/componente. En este caso es la clase Experimento sobre categoria.

```java
//Plantas.java
@Component
@Qualifier("Plantas")
public class Plantas extends Categoria {
    //...
}
```

```java
//Experimento.java
@Component
public class Experimento {
    /*
    @Autowired
    private Categoria cat;
    */
    private Categoria cat;

    @Autowired
    public Experimento(@Qualifier("Plantas")Categoria cat) {
        this.cat = cat;
    }
    //...
}
```

> The use of the `@Autowired` annotation is optional when using constructors dependecy injection.

####  *`Setter` Injection*

Otra manera de realizar lo mismo, en vez de con el constructor de la propia clase, es con un propio setter de la clase.

```java
//Plantas.java
@Component
@Qualifier("Plantas")
public class Plantas extends Categoria {
    //...
}
```

```java
//Experimento.java
@Component
public class Experimento {
    /*
    @Autowired
    private Categoria cat;
    */
    private Categoria cat;

    @Autowired
    @Qualifier("contentBasedFilter")
    public void setCategory(Categoria cat) {
        //...
    }
    //...
}
```

> Setter injection is more readable as it specifies the name of the dependency as the method name but the number of setter methods increases with each increasing dependency increasing the boiler plate code.

Usando este approach evitamos la excepión de `BeanCurrentlyInCreationException`. Ya que la principal diferencia entre la inyección por contrusctor y la inyeccón por setter, es que la del setter unicamente inyecta dependecias cuando son necesarias, y la de constructor siempre son inyectadas cuando se crea una nueva instancia del objeto en cuestión. En este caso el objeto de la clase Experimento.

####  *`Field` Injection*

```java
//Experimento.java
@Component
public class Experimento {
    @Autowired
    private Categoria cat;
    //...
}
```

> Using `field injection` keeps the code simple and readable, but it is unsafe because Spring can set private fields of the objects. 

### Bean Scope

It refers to the lifecycle and the visibility of beans. It tells how long the bean lives, how many instances of the bean are created, and how the bean is shared.

> There are six types of scopes: singleton, prototype, request, session, application, and websocket. The singleton and prototype scopes can be used in any application while the last four scopes are only available for a web application. 

#### *Singleton* scope.

Es el scope por default del bean. Una única instancia del bean es creada y guardada (cacheada) en la memoria. Multiples peticiones sobre un bean devuelve el mismo bean con la misma referencia. Este scope se usa para minimizar el numero de objetos creatos. Los beans son creados cuando se ha cargado el contexto y se ha cacheado en memoria. 

> This type of scope is best suited for cases where stateless beans are required

```java
//main.java
public static void main(String[] args) {
    //ApplicationContext manages the beans and dependencies
    ApplicationContext appContext = SpringApplication.run(ExperimentExample.class, args);

    //Retrieve singleton bean from application context thrice
    Animales al1 = appContext.getBean(Animales.class); 
    Animales al2 = appContext.getBean(Animales.class); 
    
    //Prints the same bean with same reference.
    System.out.println(exp1);
    System.out.println(exp2);
}
```

#### *Prorotype* scope.

Crea tantos beans nuevos y distintos, con referencias distintas cada uno, en cada petición que se realiza sobre el bean. Se realiza declarando el scope sobre el bean que queremos que se actue el scope de prototype.

```java
//Plantas.java
@Component
@Scope("Prototype")
//@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class Plantas extends Categoria {
    //...
}
```

> This type of scope is best suited for cases where we need to maintain the state of the beans.

```java
//main.java
public static void main(String[] args) {
    //ApplicationContext manages the beans and dependencies
    ApplicationContext appContext = SpringApplication.run(ExperimentExample.class, args);

    //Retrieve singleton bean from application context thrice
    Plantas pl1 = appContext.getBean(Plantas.class); 
    Plantas pl2 = appContext.getBean(Plantas.class); 
    
    //Prints two different beans with two referencies to memory address diferent.
    System.out.println(pl1);
    System.out.println(pl2);
}
```

> Spring creates a singleton bean even before we ask for it while a prototype bean is not created till we request Spring for the bean. 

*REPASAR ESTE APARTADO!*

*CUIDADO!*

Si tenemos las clases definidas anteriormente:

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
//Plantas.java
@Component
@Scope("Prototype")
//@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class Plantas extends Categoria {
    //...
}
```

Y hacemos uso de este código:

```java
//main.java
public static void main(String[] args) {
    //ApplicationContext manages the beans and dependencies
    ApplicationContext appContext = SpringApplication.run(ExampleApplication.class, args);
    //use ApplicationContext to find which filter is being used, the one with the @Component tag.
    Experimento exp = appContext.getBean(Experimento.class);	

    //Retrieve singleton bean from application context thrice
    Plantas pl1 = appContext.getBean(Plantas.class); 
    Plantas pl2 = appContext.getBean(Plantas.class); 

    System.out.println(exp);
        
    //Prints two same beans with two sames references to memory address.
    System.out.println(pl1);
    System.out.println(pl2);
}
```

Según la teoría impartida, imprimiriamos un objeto exp con una referencia de este de memoria, y dos beans de tipo Plantas siendo totalmente distintos y con diferentes direcciones de memoria, pero NO. Tanto los beans `pl1` como `pl2` son el mismo bean con la misma dirección a memoria.  Debido a que se hace una inyección de dependecias sobre un bean `singleton` el cual es `Experimento` 

> When a prototype bean is injected into a singleton bean, it loses its prototype behavior and acts as a singleton. Entonces, si no creasemos el experimento que es el objeto al cual se inyecta la dependecia de ` Plantas`, el scope de este bean seria de `Prototype` y no de `Singleton` 

Para solucionar ese problema hace falta declarar la clase `Plantas` de la siguiente manera:

```java
//Plantas.java
@Component
@Scope(value=ConfigurableBeanFactory.SCOPE_PROTOTYPE, proxyMode=ScopedProxyMode.TARGET_CLASS)
//@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class Plantas extends Categoria {
    //...
}
```

> The prototype bean doesn't get autowired into the singleton bean at the time of its creation. Instead, a proxy or placeholder object is autowired. When the developer requests the prototype bean from Spring, a new instance of the prototype bean is created and is returned by the application context. The proxy mode allows Spring container to inject a new object into the singleton bean.

### Component Scan

Como escanea los compomentes (beans) Spring? Usando `@ComponentScan`. 

> The `@ComponentScan` annotation without any argument tells Spring to scan the current package as well as any sub-packages that might exist. Spring detects all classes marked with the @Component, @Repository, @Service, and @Controller annotations during component scan

`@SpringBootApplication` = `@Configuration` + `@EnableAutoConfiguration` + `@ComponentScan`

If a bean is present in a package other than the base package or its sub-packages, it will not be found (el mismo package es la misma carpeta o subcarpetas dentro de la carpeta 'padre'). If we want Spring to find beans defined in other packages, we need to use the @ComponentScan annotation and provide the path of the package where we want Spring to look for the beans:.

```java
//Plantas.java
@Component
@ComponentScan(basePackages={"package_name of the root of @SpringBootApplication", "package_name without the file with @SpringBootApplication"})
public class Plantas extends Categoria {
    //...
}
```

Si no declaramos tambien el package que contiene el @SpringBootApplication, solo encontrará los beans que estan en el package (carpeta) que le hemos pasado y no analizará ni buscará beans de donde esta el main con el @SpringBootApplication.

#### Include and exclude filters 

@ComponentScan can be used to include or exclude certain packages from being scanned. Podemos elegir que paquetes queremos que escanee para encontrar los beans. nclude filters are used to include certain classes in component scan. Exclude filters are used to stop Spring from auto-detecting classes in component scan.


```bash
FilterType.ANNOTATION
FilterType.ASPECTJ
FilterType.ASSIGNABLE_TYPE
FilterType.REGEX
FilterType.CUSTOM
```
Con lo que tanto el approach siguiente como el de abajo es lo mismo.

```java
//Plantas.java
@Component
@ComponentScan(basePackages={"package_name of the root of @SpringBootApplication", "package_name without the file with @SpringBootApplication"})
public class Plantas extends Categoria {
    //...
}
```

```java
//Plantas.java
@Component
//@ComponentScan(basePackages={"package_name of the root of @SpringBootApplication", "package_name without the file with @SpringBootApplication"})
@ComponentScan(includeFilters = @ComponentScan.Filter (type= FilterType.REGEX, pattern="io.datajek.spring.basics.movierecommendersystem.lesson9.*"))
public class Plantas extends Categoria {
    //...
}
```

### Bean Lifecycle: `@PostConstruct`, `@PreDestroy`

Spring provides post-initialization and pre-destruction callback methods on the beans.

#### `@PostConstruct`

When Spring creates a bean, the first thing it does, is to autowire the dependencies. The `@PostConstruct` annotation tells Spring to call the method for us once the object has been created. Its return type is always *`void`*

#### `@PreDestroy`

The callback method that is executed just before the bean is destroyed is annotated using `@PreDestroy`. A method with the @PreDestroy annotation can be used to release resources or close a database connection.
