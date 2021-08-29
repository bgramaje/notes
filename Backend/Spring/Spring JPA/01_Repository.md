### 👨‍🏫 Spring JPA
> La Java Persistence API (JPA) esta diseñada para facilitar al usuario las operaciones sobre la BBDD.

### Repository

Posteriormente de declarar las entidades, hay que declarar los repositorios. Se declararán tantos repositorios como entidades tengamos en el proyecto de Spring. El repositorio es una clase que sera la encargada de manejar la entidad que le digamos.

#### `@Repository`

Para declarar un repositorio, hacemos uso de la anotación `@Repository`.

```java
@Repository
public class UsuarioRepository {
    //...
}
```

#### `@Transactional`

Using this annotation, all the methods will be executed in a transactional context. So if we have INSERT and UPDATE in a single method, something called an `EntityManager` will keep track of both of them. If one of them fails, the whole operation will be rolled back.

```java
@Repository
@Transactional
public class UsuarioRepository {
    //...
}
```

#### Spring Data JPA

Una manera mas facil de trabajar es a travñes de la interfaz del repositorio JPA, el cual incluye todas las definiciones y lógica de las operaciones CRUD(SELECT, INSERT, DELETE & UPDATE) sobre la BBDD. Para poder usar esto, solo hay que crear un repositorio que extienda del `JpaRepository`

```java
import org.springframework.project.entity.Usuario; //Importamos la entidad declarada en el proyecto Spring.

@Repository
@Transactional
public class UsuarioRepository extends JpaRepository<Usuario, Integer>{ //extendemos de la interfaz, declarando la entidad que sera manejada en el repositorio, y su respectiva Primary KEY.
    //...
}
```

En este caso el repositorio Usuario extiende de `JpaRepository<Usuario, Integer>` puesto que este repositorio opera sobre la entidad Usuario, y su PK es un Integer:

```java
@Entity
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; //PRIMARY KEY
    //..
}
```

Al extender de esta interfaz todas las operaciones sobre la BBDD ya estan implementadas. Para poder usarla, en una clase, de normal en la clase de service, creamos un objecto de este repositorio con la anotación `@Autowired`

```java
@Entity
public class UsuarioService {
    @Autowired
    UsuarioRepository usuarioRepository;

}
```

La operación `SELECT`, sería de la siguiente manera: 

```java
usuarioRepository.findAll(); //returns List<Usuario>
usuarioRepository.findById(1); //return Usuario
```

La operación `INSERT` y `UPDATE`, sería de la siguiente manera: 

```java
usuarioRepository.save(usuario);
```

La función `DELETE`, sería de la siguiente manera: 

```java
usuarioRepository.deleteById(1);
```

Y luego otras funciones como:
```java
usuarioRepository.existsById(1); //returns a boolean if usuario with id=1 exists
```

#### Declaración de tus propias operaciones CRUD.

Para poder crear tus propias operaciones CRUD, con Spring JPA es muy facil. Simplemente declarandolas en el repositorio con la MISMA SINTAXIS que sigue Spring JPA, te crea las funciones automáticamente. Es decir, si queremos crear una operacion que te devuelva su usuario por nombre, simplemente habría que declararla de la siguiente manera:


```java
import org.springframework.project.entity.Usuario; //Importamos la entidad declarada en el proyecto Spring.

@Repository
@Transactional
public class UsuarioRepository extends JpaRepository<Usuario, Integer>{ //extendemos de la interfaz, declarando la entidad que sera manejada en el repositorio, y su respectiva Primary KEY.
    Optional<Usuario> findByNombre(String nombre);
    boolean existsByNombre(String nombre);
}
```

> Un Optional es una clase que puede o no contener un valor, es decir, que se comporta como un wrapper para cualquier tipo de objeto que pueda o no ser nulo. Con el optional podemos hacer que nos devuelva una Lista(si hay mas de un usuario con el mismo nombre), o un objeto Usuario(si solo hay un usuario con el nombre proporcionado), o un nulo, ya que no hay ningun usuaro con el nombre proporcionado.

Ahora solo faltaria usarla como el resto:
```java
usuarioRepository.findByNombre("Pepe"); //returns a user which name is Pepe
usuarioRepository.existsByNombre("Pepe"); //returns a boolean if usuario with nombre="Pepe" exists
```

#### `@EntityGraph`.

Las entities graph son usadas para mejorar nuestra queries y ayudar el rendimiento de nuestra aplicación. Hasta que Enity Graph fue introducido en JPA, necesitabamos hacer uso de FetchType.LAZY o FetchType.EAGER para cargar nuestras colecciones. Esto ocasionaba que en muchas casos cuando usabamos LAZY, en la que los datos se cargan según se necesitan, tuviesemos n+1 queries. Por eso, para conseguir mejorar el rendimiento de las queries cuando tienen colecciones asociadas, fue introducida esta característica.

¡PREGUNTAR LO DEL N+1 QUERY!

> Básicamente lo que hace JPA, es cargar todo el grafo para hacer una única query y así evitar las queries de las relaciones asociadas.

Al ejecutar la misma aplicación pero con este pequeño cambio, podremos ver que el resultado es una única query que funciona como una join, con lo que hemos mejorado el tiempo y el rendimiento de la consulta sobre BBDD.

Para crear estos grafos, hay que crear un fichero en /src/main/resources/META-INF llamado `orm.xml`. Suponiendo que existen relaciones entre tablas, siendo en este caso que Usuario puede tener Experimentos:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<entity-mappings>
<!-- 	<entity class="org.thoughts.on.java.model.Author" name="Author"> -->	
		<!-- USUARIO QUERY  -->
		<entity class="com.project.example.entity.Usuario" name="usuario">
			<table name="usuario" />
			<named-query name="Usuario.findAllGraph"> <!-- Nombre de la query para el Repositorio -->
		        <query>SELECT u FROM com.project.example.entity.Usuario u </query>
		    </named-query>
            <!-- Aquí declaramos los campos que tienen relaciones con otras tablas, en este caso experimentos. -->
		    <named-entity-graph name="Usuario.ListaUsuarios">  <!-- Nombre de la query para declarar los atributos partícipes del nodo del entity graph -->
		    	<named-attribute-node name="experimentos"/>
		    </named-entity-graph>
		</entity>
		
</entity-mappings>
```

Luego de declararla, se debe de indicar en el repositorio que esta consulta debe ser usada cuando se requiera:

```java
import org.springframework.project.entity.Usuario; //Importamos la entidad declarada en el proyecto Spring.

@Repository
@Transactional
public class UsuarioRepository extends JpaRepository<Usuario, Integer>{ //extendemos de la interfaz, declarando la entidad que sera manejada en el repositorio, y su respectiva Primary KEY.
    @EntityGraph(value = "Usuario.ListaUsuarios")
    List <Usuario> findAllGraph();
}
```

Y luego apra poder usarlo:

```java
@Autowired
UsuarioRepository usuarioRepository;

@Query(name = "Usuario.findAllGraph") //valor que tiene asignado en el repositorio
public List<Usuario> findAllGraph() {
    return usuarioRepository.findAllGraph(); //llamamos a la funcion que hemos creado en el repositorio
}
```












