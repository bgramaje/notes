### 👨‍🏫 SPRING FRAMEWORK
> The Spring framework is an open-source Java application framework, which is based on two key principles: dependency injection and Inversion of Control.

### Using an External Property File

Siempre se puede hacer un archivo de propiedades tipo `.env` con distintas variables de entorno, para parámetros de conexión a BBDD y demás. Para hcarlo, se crea un archivo llamado `app.properties` en `src/main/resources`. Y se crea un archivo de tipo key:value, de la siguiente manera: 

```xml
plantas.prueba = Sunflower
```

Luego donde queramos usarlo para que lea los parámetros, lo indicaremos de esta manera:

```java
//Experimento.java
@Value("${plantas.prueba : Sunflower}")
public class Plantas extends Categoria {
    String prueba;
    //...
}
```

Se pone en @Value antes de los :, la key con el valor definido en el archivo, y posteriormente se le pone un valor por defecto por si no se ha declarado nada en el fichero externo. Sino se hace eso, Spring lanzará un error cuando vaya a buscar la key en el fichero y no encuentre nada.

Finalmente donde el main de la aplicacion, donde se declara el `@SpringBootApplication` hay que poner lo siguiente:

```java
@SpringBootApplication
@PropertySource("classpath:app.properties")
public class MovieRecommenderSystemApplication {
    public static void main(String[] args) {
        //...
    }
}
```
