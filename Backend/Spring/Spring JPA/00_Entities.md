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

#### RELACIONES BBDD

Es recomendable que en Spring las relaciones de la BBDD sean bidireccionales, es decir, si la tabla X tiene `@ManyToOne` con la tabla Y, que la tabla Y tenga una relación `@OneToMany` con la tabla X.

##### `@ManyToOne`

Tipica relacion de Empleado y departamento, donde un empleado esta en un departamento, pero un departamento puede estar en mas de un empleado. Se usa uso de la anotación `@ManyToOne` en Spring.

```java
// Departamento.java
@Entity
public class Departamento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    //GET, SET for each variable.
}
```

La anotación `@ManyToOne`, puede ser usada con distintos parámetros:
 
* `optional`
    * Indica si la relación es opcional. Si el objeto que hace link en la relación puede ser nulo, es decir, si puede haber un Empleado que no pertenezca a ningun departamento. En este caso se le pone a false, ya que si o si, un empleado esta en un departamento.
* `Cascade`
    * Esta propiedad le indica que operaciones en cascada puede realizar con la Entidad relacionada. Si se borra un departamento, el usuario cuyo departamento ha sido borrado, se le borra la referencia, y ese usuario pasa a no tener departamento.
* `Fetch` 
    * se utiliza para determinar cómo debe ser cargada la entidad, los valores:
        * `EAGER` (ansioso): Indica que la relación debe de ser cargada al momento de cargar la entidad.
        * `LAZY` (perezoso): Indica que la relación solo se cargará cuando la propiedad sea leída por primera vez.

```java
// Empleado.java
@Entity
public class Empleado {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(optional = false, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name="departamento") //la columna que contiene como claves ajenas las pk de departamento, se llama departamento.
    private Departamento departamento;

    //GET, SET for each variable.
}
```

##### `@OneToMany`

En el ejemplo anterior hemos hecho una relacion la cual permite que un usuario únicamente este asignado a UN ÚNICO departamento. Pero si queremos mantener un registro en la tabla departamento, para saber que departamento esta en que usuarios, hay que realizar una relación `@OneToMany`.

La clase Empleado se mantiene de igual manera.

```java
// Departamento.java
@Entity
public class Departamento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToMany(mappedBy="departamento") //nombre de la variable creada en la otra entity?
    private Set<Empleado> empleados
    //GET, SET for each variable.
}
```

> OJO! Puede ser que cuando devuelva una respuesta JSON sobre el empleado, este resulte en un bucle infinito pues Empleado contiene departamento que tiene a Empleado que este vuelve a contener departamento. Para solucionarlo:

```java
// Departamento.java
@Entity
public class Departamento {
    //...
    @JsonManagedReference
    @OneToMany(mappedBy="departamento_id") //nombre de la variable creada en la otra entity?
    private Set<Empleado> empleados
    //...
}
```

```java
// Empleado.java
@Entity
public class Empleado {
    //...
    @JsonBackReference
    @ManyToOne(optional = false, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name="departamento_id") //la columna que contiene como claves ajenas las pk de departamento, se llama departamento_id.
    private Departamento departamento;

    //GET, SET for each variable.
}
```

##### `@OneToOne`

```java
// Departamento.java
@Entity
public class Departamento {
    //...
    @OneToOne(mappedBy="departamento_id") //nombre de la variable creada en la otra entity?
    private Empleado empleado
    //...
}
```

```java
// Empleado.java
@Entity
public class Empleado {
    //...
    @OneToOne(optional = false, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name="departamento_id") //la columna que contiene como claves ajenas las pk de departamento, se llama departamento_id.
    private Departamento departamento;

    //GET, SET for each variable.
}
```

##### `@ManyToMany`

```java
// Direccion.java
@Entity
public class Direccion {
    //...
    @ManyToMany(mappedBy="direccionesEntrega", cascade = CascadeType.ALL) //nombre de la variable creada en la otra entity que forma partícipe de la relacion
    private Set<Cliente> clientesConDireccion
    //...
}
```

```java
// Cliente.java
@Entity
public class Cliente {
    //...
    @OneToOne(optional = false, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(
        name = "direcciones_cliente",
        joinColumns = @JoinColumn(name = "cliente_id", nullable = false),
        inverseJoinColumns = @JoinColumn(name="direccion_id", nullable = false)
    )
    private Set<Direccion> direccionesEntrega

    //GET, SET for each variable.
}
```

Al ser una relacion de muchos a muchos, una nueva tabla es requerida, y con el @JoinTable se genera la tabla que relaciona tanto Cliente con direcciones.
