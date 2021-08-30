### 👨‍🏫 Spring JPA
> La Java Persistence API (JPA) esta diseñada para facilitar al usuario las operaciones sobre la BBDD.

### DTO (Data Transfer Objects)

Los DTO's son usados como objectos que son enviados al usuario como respuesta de información. Es decir, en el caso de cuando devolvemos los usuarios, nosotros para definir un usuario en el modelo de datos de Spring, creamos un Entity, con unos determinados campos Todos estos campos no son necesarios que sean devueltos al usuario cuando hace una peticion sobre la entidad, vease el ejemplo de la password. No es seguro devolver toda el objecto con toda la información de la entidad de usuario para evitar fallas de seguridad como con las password. Para eso estan los DTOs.

El objetivo de los DTOs son clases Java con los atributos que nosotros queremos enviar. Por ejemplo, partiendo de la entidad usuario que tenemos de ejemplo: 

```java
public class UsuarioDto {
    /* no hace falta ya que no estamos declarando entidad.
    //@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    */
    //private Integer id;
    private String name;
    private String lastname

    public UsuarioDto () {}

    public UsuarioDto (String name, String lastname) {
        this.name = name;
        this.lastname = lastname;
    }
    //..
    
    //GET, SET for each variable.
}
```

```java
@Entity
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
    private String lastname
    private String password;

    public Usuario () {}

    public Usuario (Integer id, String name, String lastname, String password) {
        this.id = id;
        this.name = name;
        this.lastname = lastname;
        this.password = password;
    }
    //..
    
    //GET, SET for each variable.
}
```

La principal diferencia entre ambos es que Usuario es la entidad que modela la tabla usuario en la BBDD con sus respectivos campos, y UsuarioDto, es una simple clase Java que usaremos para convertir de Usuario a UsuarioDto, para poder controlar que campos queremos enviar a la respuesta. En este ejemplo, Usuario tiene su Id y password, pero estos campos no aparecen en UsuarioDto ni en su constructor, con lo que a la hora de mapear/convertir de Usuario a UsuarioDto y enviar este como respuesta, el cliente nunca verá los campos Id ni password del Usuario que hace referencia el UsuarioDto.

Para poder transformar de UsuarioDto a Usuario; Usuario a UsuarioDto, se hacen uso de los mappers.