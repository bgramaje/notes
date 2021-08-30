### 👨‍🏫 Spring JPA
> La Java Persistence API (JPA) esta diseñada para facilitar al usuario las operaciones sobre la BBDD.

### Controller

Tras habler implementado la capa de acceso a datos, `@Repository`, y la capa de servicios, `@Service`, únicamente resta la implementacón de la capa de presentación, es decir el controlador. Este se encarga de por asi decir enrutar las peticiones que realiza el usuario a las distintas funcionalidades que esta implementadas en a capa de negocios/servicio, es decir en el `@Service` creado anteriormente.

Para crear un controller, se hace uso de la anotación `@Controller`:

```java
@Controller
public class UsuarioController {
    //...
}
```

Y para implementar un servicio REST, se hace uso de la anotación `@RestController`

> El `@RestController` es una forma de crear un bean en vez de usar `@Controller`, al ser una forma especializada de esta. Esta anotación, automaticamente realiza la conversión de datos a JSON y se encarga de manejar las peticiones y respuestas REST.

```java
@RestController
public class UsuarioController {
    //...
}
```

Este controlador hará uso de la capa de negocio y su lógica, que esta se encuentra en el `@Service` implementado anteriormente, con lo que hará falta crear una instacia de servicio en el controlador.

```java
@RestController
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;
    //...
}
```

#### Mapeo de rutas

Para realizar el mapeo de rutas, se realiza con la anotación `@GetMapping("/")`, si es una peticion GET o con `@RequestMapping(method=RequestMethod.GET, value="/")`. Lo mismo para las operaciones POST, PUT, DELETE.

Si queremos que el controlador de usuarios opere sobre un enlace (string) previamente definido, es decir, que todas las operaciones sobre usuarios, dicho enlace vaya precedido por un string común, por ejemplo: http://localhost:4200/usuarios/list o http://localhost:4200/usuarios/create. Que ese http://localhost:4200/usuarios/ sea el que indique que tiene que ir al controlador de usuarios y no a otro, se hace uso de la anotación `@RequestMapping`

```java
@RestController
@RequestMapping('/usuarios')
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;
    //...
}
```

Si queremos realizar la ruta PUT para generar un nuevo usuario, deberiamos de hacer lo siguiente:

```java
@RestController
@RequestMapping('/usuarios')
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;

    @PostMapping("/create") //http://localhost:4200/usuarios/create
    public ResponseEntity<Mensaje> create(@RequestBody Usuario usuario){
        usuarioService.save(usuario);
        return new ResponseEntity(new Mensaje("User created"), HttpStatus.OK);
    }
    //...
}
```

El metodo generado anteriormente, para operar sobre el, habrá que realizar una operacion PUT a la URL: `http://localhost:4200/usuarios/create`. En este caso se ha genereado un metodo que devuleve una respuesta `ResponseEntity`, y se le ha indicado que esta respuesta es de tipo `Mensaje`, `ResponseEntity<Mensaje>`. Como se puede observar en la devolución de la función `return`, se devuelva una `ResponseEntity` y se crea un mensaje en esta con el contrutor de la clase `Mensaje`, y se le pasa un código de estado HTTP, en este caso si se crea correctamente se le pasa OK.

Si quisieramos controlar que el usuario no este ya en BBDD (su username), ya que el usermane es único:


```java
@RestController
@RequestMapping('/usuarios')
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;

    @PostMapping("/create") //http://localhost:4200/usuarios/create
    public ResponseEntity<Mensaje> create(@RequestBody Usuario usuario){
        if(usuarioService.existsByUsername(usuario.getUsername())) { //getter de la clase Usuario, puesto usuario es una instancia de la clase Usuario.
			return new ResponseEntity(new Mensaje("User already in DDBB"), HttpStatus.BAD_REQUEST);
		}
        usuarioService.save(usuario);
        return new ResponseEntity(new Mensaje("User created"), HttpStatus.OK);
    }
    //...
}
```

#### Parámetros dinámicos/parametrizables

Supongamos que queramos una operacion REST, que nos devuelva el usuario por Id, es decir, que el usuario le pase un Id al server, y este le responda con el usuario asociado a esa Id. Con lo que la ruta quedaria una cosa tal que `http://localhost:4200/usuarios/detail/{id}`, con lo que se haría uso de la siguiente manera:

Para obtener el usuario con Id uno, se deberia de hacer una operacion `GET` sobre la URL: `http://localhost:4200/usuarios/detail/1`

```java
@RestController
@RequestMapping('/usuarios')
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;

    @GetMapping("/detail/{id}")
	public ResponseEntity<?> getById(@PathVariable("id") int id){		
		if(!usuarioService.existsById(id)) {
			return new ResponseEntity(new Mensaje("User NOT found"), HttpStatus.NOT_FOUND);
		}
		Usuario usuario = usuarioService.getOne(id).get();
		return new ResponseEntity(usuario, HttpStatus.OK);
	}
    //...
}
```

Esta vez en la ResponseEntity, le indicamos que se le devolverá cualquier cosa, en este caso, se le puede devolver un usuario si este se encuentra con la Id que se le ha pasado, o se le puede devolver un mensaje si el usuario con esa Id no se encuentra, con lo que `ResponseEntity<?>`

Si enviamos las peticiones por query params, la anotación a usar es la de `@RequestParam`

Ver como en angular hace esa peticion para ver si es query params.


