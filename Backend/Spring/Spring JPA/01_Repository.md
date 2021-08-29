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










