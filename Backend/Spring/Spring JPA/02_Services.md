### 👨‍🏫 Spring JPA
> La Java Persistence API (JPA) esta diseñada para facilitar al usuario las operaciones sobre la BBDD.

### Service

Los servicios son componenetes en Spring que indican que son portadores de la capa de negocio de la app. En la capa de negocio se reciben las peticiones del usuario y se envían las respuestas. Esta capa se comunica con el `@Controller`, para recibir las solicitudes y presentar los resultados, y con el `@Repository`, para solicitar al gestor de base de datos almacenar o recuperar datos de él.

> We mark beans with @Service to indicate that they're holding the business logic. Besides being used in the service layer, there isn't any other special use for this annotation.

Un service se declara en Spring de la siguiente manera:

```java
@Service
public class UsuarioService {
    //...
}
```

Y como bien se ha comentado, hace uso del la capa de datos para poder solicitar estos. Con lo que hay que crear un objeto repositorio en el servicio.

```java
@Service
public class UsuarioService {
    @Autowired
    UsuarioRepository usuarioRepository;
    //...
}
```

Finalmente se declaran los metodos que van a ser llamados desde el controlador, que son los encargados de producir la respuesta a una petición enviada por el usuario.

```java
@Service
public class UsuarioService {
    @Autowired
    UsuarioRepository usuarioRepository;
    
    public Optional<Usuario> getOne(int id){
        return usuarioRepository.findById(id);
    }
        
    public Optional<Usuario> getByNombre(String nombre){
        return usuarioRepository.findByNombre(nombre);
    }

    public void save(Usuario usuario){
        usuarioRepository.save(usuario);
    }

    public void delete(int id) {
        usuarioRepository.deleteById(id);
    }
    
    @Query(name = "Usuario.findAllGraph")   //En el caso de lo de EntityGraph habría que hacerlo de esta manera
    public List<Usuario> findAllGraph(){
        return usuarioRepository.findAllGraph();
    }
    //...
}
```

> Un Optional es una clase que puede o no contener un valor, es decir, que se comporta como un wrapper para cualquier tipo de objeto que pueda o no ser nulo. Con el optional podemos hacer que nos devuelva una Lista(si hay mas de un usuario con el mismo parámetro), o un objeto Usuario(si solo hay un usuario con el parámetro proporcionado), o un nulo, ya que no hay ningun usuario con el parámetro proporcionado.

