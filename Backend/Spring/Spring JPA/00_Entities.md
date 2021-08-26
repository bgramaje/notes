### 👨‍🏫 Spring JPA
> La Java Persistence API (JPA) esta diseñada para facilitar al usuario las operaciones sobre la BBDD.

### Entity

Lo primero que debemos de hacer para el uso de Spring JPA, es declarar las entities. Estas entities se mapean a la base de datos, es decir, son las tablas de la base de datos. Para hacer uso de esta propiedad, se hace uso de la anotación `@Entity`, de la siguiente manera:

```java
@Entity
public class Usuario {
    public Usuario () {}
    //...
}
```

La anotación `@Table` es opcional, si no es declarada, el nombre de la tabla en BBDD será el mismo que el nombre de la clase declarada. En el caso de que la clase se dijera usuario pero quisieramos que la tabla en BBDD se llamase persona, habría que hacer:

```java
@Entity
@Table(name="Persona")
public class Usuario {
    public Usuario () {}
    //...
}
```

A la hora de crear columnas en la tabla de BBDD, hay que generar variables dentro de la entidad.

```java
@Entity
public class Usuario {
    private Integer id;
    private String nombre;
    private String apellido;
    //..

    public Usuario () {}

    //..
    //GET, SET for each variable.
}
```

> Es recomendable hacer uso de las clases de tipos(Integer, Double, Float), y no el uso de tipos primitivos(int, double, float), pues los de la clases permite que sean nullables mientras que los tipos primitivos no admiten que sean nulables.

Por lo general los nombres de las columnas de las tablas de BBDD, son los nombres de las variables declaradas en las entidades. Si queremos que alguna columna no tenga el mismo nombre que la variable declarada, se hace uso de la anotación `@Column`.

```java
@Entity
public class Usuario {
    private Integer id;
    private String nombre;

    @Column(name="lastname")
    private String apellido;
    //..

}
```

#### Primary KEY: `@Id`, `@GeneratedValue`.

Toda tabla en la BBDD, contiene una primera key. Esta Id identifica atributos de manera única. Para indicar que campo de la bbdd es la Id, se hace uso de la anotación `@Id`. A su vez si hacemos uso de la anotación `@GeneratedValue`, Spring de manera automática crea la Id aumentando respecto a la última generada, con lo que el usuario no tiene que preocuparse por insertar la id y que esta no exista en la BBDD. Se declara la strategia de generar valores a IDENTITY, pues las Primary KEY en BBDD son únicas e identifican a cada set de la tabla.

```java
@Entity
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    public Usuario () {}

    public Usuario (Integer id) {
        this.id = id;
    }
    //..
    
    //GET, SET for each variable.
}
```
