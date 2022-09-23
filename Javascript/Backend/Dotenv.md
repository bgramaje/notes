### 👨‍🏫 Environment variables 

>  Dotenv is a zero-dependency module that loads environment variables from a .env file into process.env

Las variables de entorno son aquellas variables guardadas en el sistema/máquina que no queremos que estén de manera hard-coded en el código y a la cual desde el código accedemos a ellas. Normalmente en estas variables guardamos direcciones URL's donde apuntamos a API's, URI's de conexión a BBDD y demás

* ##### Instalación

    ```bash
    # install locally (recommended)
    npm install dotenv --save
    # typescript
    npm install @types/dotenv --save
    ```

* ##### Entornos

    Esto ya es recomendación mía y luego hay que tener en cuenta el despliegue de esto, pero yo recomiendo 4 entornos.
    1. *`local`*, entorno el cual nosotros estamos programando en nuestro equipo de uso diario.
    2. *`development`*, entorno el cual el equipo sube el código de todos y se comprueba el correcto funcionamiento
    3. *`preproduction`*, entorno previo al de producción donde se le indica al cliente que es un entorno de pruebas, para que pueda sobre una base de datos de pruebas, probar el producto, si satisface sus necesidades y requerimientos.
    4. *`production`*, entorno final de producción, donde todo el software ha sido validado y dado el OK a su despliegue.
        
    <br/>

    ```markdown
    .
    ├── ...
    ├── .env.pre          # Environment variables for `preproduction` stage
    ├── .env.prod         # Environment variables for `production` stage
    ├── .env.dev          # Environment variables for `development` stage
    ├── .env.local        # Environment variables for `local` stage
    └── ...
    ```

* ##### Acceder a datos del dotenv en el código

    Para acceder a los datos almacenados en los ficheros de entorno, únicamente nos basta con llamarlos como `process.env.DATABASE_URI`, si quisieramos obtener el valor de `DATABASE_URI`. Este debe de estar generado en todos los .env de los distintos entornos sino podría saltar una excepción de `undefined`.

    Cada fichero del entorno puede apuntar a una `DATABASE_URI`distinta. De ahí la gracia de tener distintos entornos.

    Para que nuestro programa lo reconozca el `process.env.DATABASE_URI`, tenemos que lanzar la siguiente secuencia de comandos cuando arrancamos la api, que veremos en la seccion de 'scripts'

* ##### Scripts

    Para poder ejecutar bien los distintos entornos que tenemos, necesitamos una librería y los siguientes comandos declarados en el *`package.json`*
        
    ```bash
    # install locally (recommended)
    npm install dotenv-cli
    ```

    Luego en el *`package.json`* declararemos los siguientes comandos en la sección de `scripts`.

    ```json
    scripts": {
        "build": "rimraf ./build && tsc",
        "local": "dotenv -e .env.local -- nodemon -r dotenv/config src/index.ts",
        "{{ ENV }}": "dotenv -e .env.{{ ENV }} -- node -r dotenv/config build/index.js",
        "start": "npm run local"
    },
    ```

    > "{{ ENV }}" Este comando es sustituido por el nombre de la rama que creamos en gitlab | github. Estos nombres de rama coinciden con la extensión final de los ficheros (pre, prod, dev). Con lo que con un comando y haciendo la sustitución del contenido posteriormente en una pipeline, podemos tener para todas las ramas el comando exclusivo de estas `npm run pre` || `npm run prod` || `npm run dev`

    Sino la otra manera sería hacer lo siguiente:

    ```json
    scripts": {
        "build": "rimraf ./build && tsc",
        "local": "dotenv -e .env.local -- nodemon -r dotenv/config src/index.ts",
        "dev": "dotenv -e .env.dev -- node -r dotenv/config build/index.js",
        "pre": "dotenv -e .env.pre -- node -r dotenv/config build/index.js",
        "prod": "dotenv -e .env.prod -- node -r dotenv/config build/index.js",
        "start": "npm run local"
    },
    ```
    Estos comandos lo que hacen es arrancar el servicio API, pero pillando como variable de entornos el fichero en específico de su stage.

    También hay que observar la diferencia entre el comando `local` con los otros 3. El local ejecuta la versión typescript sin compilar de nuestro código que estamos programando. Mientras que los otros comandos de los distintos entornos ejecutan el javascript compilado que proviene del typescript. Es decir, despues de hacer el `npm run build` podemos ejecutar los comandos `npm run pre` || `npm run prod` || `npm run dev`.

    > En la versión local hacemos uso de la librería *`nodemon`*, se trata de una librería que nos permice hacer `hot reload`, es decir cada vez que nosotros añadimos codigo y lo guardamos el fichero, este nos re-arranca la api sin la necesidad de nosotros tener que parar la API y volver a arrancarla.

