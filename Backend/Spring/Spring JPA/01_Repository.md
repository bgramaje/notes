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







