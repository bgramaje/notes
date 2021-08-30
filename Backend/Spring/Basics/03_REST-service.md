### 👨‍🏫 Spring Framework
> The Spring framework is an open-source Java application framework, which is based on two key principles: dependency injection and Inversion of Control.

### Spring Boot

Es una manera de inicializar proyectos Spring, sin tener que calentarnos la cabeza, entre versiones de distintos frameworks que se usan y demás. La manera mas facil de inicializar un proyecto es a través de `Spring Initializr`, el cual se encuentra [aqui](https://start.spring.io/). 

###  REST Service

Para realizar una API REST, en el `Spring Initializr`, añadiremos la dependencia de *`Spring Web`*. Esta dependencia incluye multiples dependecias que nos evita el tener que instalarlas de manera manual, y tener que ver las versiones de todas las dependecias que componen Spring Web si son compatibles o no.

> Las dependecias que incluyen son `jackson-databind`, `tomcat`, `spring-webmvc`, and `json`

#### `@RestController`

El `@RestController` es una forma de crear un bean en vez de usar `@Controller`, al ser una forma especializada de esta. Esta anotación, automaticamente realiza la conversión de datos a JSON y se encarga de manejar las peticiones y respuestas REST.

#### Mapeo de rutas

Para realizar el mapeo de rutas, se realiza con la anotacióm `@GetMapping("/hello)`, si es una peticion GET o con `@RequestMapping(method=RequestMethod.GET, value="/hello")`. Lo mismo para las operaciones POST, PUT, DELETE.

```java
//HelloController.java
@RestController
public class HelloController {
    //@RequestMapping(method=RequestMethod.GET, value="/hello")
    //OR
    @GetMapping("/hello")
    public String getHello() {
        return "Hello World!"
    }
}
```

> Tomcat server is autoconfigured in our application. There is no need to download and install the server. 

In the `HelloController` class, we are returning an string back which is automatically converted into a `JSON` response. The `starter-json` dependency causes the JSON binding.

Para poner el modo debug en una API REST en Spring, cambiar lo siguiente del fichero de `application.properties`:

```bash
logging..org.springframework = DEBUG
```

