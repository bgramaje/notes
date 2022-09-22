### 👨‍🏫 Express.js [:es:]
> Infraestructura web rápida, minimalista y flexible para Node.js

![Badge en Desarollo](https://img.shields.io/badge/STATUS-EN%20DESAROLLO-green)

#### :pushpin: Índice
1. [Instalación](#instalación)
2. [Estructura](#open_file_folder-estructura)
3. [:paperclip: Recursos](#paperclip-recursos)
    * [:page_facing_up: *`index.ts`*](#page_facing_up-indexts)
    * [:page_facing_up: *`server.ts`*](#page_facing_up-serverts)
    * [:page_facing_up: *`app.ts`*](#page_facing_up-appts)



#### Instalación

Para instalar la librería, se hace uso de [*`npm`*](https://www.npmjs.com/) *(node package manager)*
```bash
$ npm install express --save
```

- ##### Typescript

Para poder usar la librería de Express en Typescript hay que instalar los tipados de esta librería mediante el siguiente comando:
```bash
$ npm install --save @types/express
```

#### :open_file_folder: Estructura

```markdown
./
├── src
│   ├── api               # Api directorty
│   │   ├── config        # Config directory with specific configuration for the api
│   │   │   ├── routes.ts # File where al routes are saved in a centrralized way  
│   │   │   └── ...
│   │   ├── controllers   # Controllers directory with all controllers in the api.
│   │   │   └── ...
│   │   ├── middlewares   # Middlewares used such as routes with token authentication
│   │   │   └── ...
│   │   ├── routes        # Routes directory with all routes in the api.
│   │   │   └── ...
│   │   ├── services      # Services directory with all the services in the api.
│   │   │   └── ...
│   │   ├── utils         # Utils directory
│   │   │   └── ...
│   ├── app.ts        # app.ts file declaration where the express app is created
│   ├── index.ts      # index.ts file that works as a start-point of the app.
│   └── server.ts     # server.ts file that contains de http server wrapped with the express `app`
├── .env.pre          # Environment variables for `preproduction` stage
├── .env.prod         # Environment variables for `production` stage
├── .env.dev          # Environment variables for `development` stage
├── .env.local        # Environment variables for `local` stage
├── package.json      # package.json file
├── tsconfig.json     # tsconfig.json file with configurations to compile the .ts files into .js
├── .gitignore        # .gitignore file to ignore the folders we do not want to upload to github.
└── ...
```

#### :paperclip: Recursos

* #### :page_facing_up: *`index.ts`*

Este fichero es el *`entrypoint`* a ejecutar para levantar todo el servicio REST API que vamos a utilizar. En este fichero se levante el servidor http escuchando por el puerto que le hemos indicado.

> Aqui es donde antes de arrancar el servidor deberiamos de conectarnos a la BBDD (SQL, NoSQL, etc...) si es que usamos una. Por tal de asegurarnos de que antes de arrancar la API estamos conectados a la base de datos correspondiente para poder servir los datos solicitados.

```javascript
import server from "./server";
//obtenemos el puerto y el host a partir de las variables de entorno. Si estas no estan definidas, se obtiene por defecto el puerto 5000 y el host '0.0.0.0'
const PORT = parseInt(process.env.PORT!) || 5000;
const HOST = process.env.HOST || '0.0.0.0';
//declarada async por si necesitamos hacer la conexion a BBDD antes de arrancar el servicio REST API.
(async () => {
    //arrancamos el servidor. Cuando este arranca mostramos un mensaje por consola afirmando que ha arrancado de manera satisfactoria
    server.listen(PORT, HOST, () => {
        console.log(`Listening on http://${HOST}:${PORT}`);
    });
})();
```

* #### :page_facing_up: *`server.ts`*

El fichero contiene el servidor http generado en node conteniendo la app de express para luego cargar todo tema de rutas y controladores generados en express

```javascript
import http from 'http';
import app from './app';
//crear el servidor http contenido con la app de express importada de 'app.ts'
const server = http.createServer(app);
//exportamos el server para futuras importaciones
export default server;
```

* #### :page_facing_up: *`app.ts`*

```javascript
//importamos express
import express, { Request, Response } from "express";
//importamos las rutas de la api
import * as Routes from "./api/config/routes";
//importamos las routes de la api
import * as Routers from "./api/routes/index";
//declaramos el app con el constructor de express para poder arrancar luego el servidor.
const app = express();
//morgan middlware para loggear en consola las distintas llamadas realizadas a recursos a la API
app.use(morgan('dev'));
//ayuda a securizar nuestra aplicacion mediante distintas cabeceras HTTP
app.use(helmet());
//deshabilitamos este campo de las respuestas con cabeceras HTTP, para poder ocultar en posibles ataques, cual es la tecnología que estamos usando
//x-powered-by : express
app.disable('x-powered-by')
app.use(cors());
app.use(express.json());
//para comprimir el cuerpo de la respuesta
app.use(compression());

//declaración de endpoint en el fichero `app.ts`
//Routes.HOME es la URI con la que identificamos el recurso al que queremos acceder.
app.get(Routes.HOME, (req: Request, res: Response) => {
  res.json({
    message: "👋🌎",
  });
});

//linkeamos el router `RESOURCE` declarado de manera externa en otro fichero con la URI que hemos generado.
app.use(Routes.RESOURCE, Routers.RESOURCE);

export default app;
```

> La compresión de gzip *`app.use(compression());`* puede disminuir significativamente el tamaño del cuerpo de respuesta y, por lo tanto, aumentar la velocidad de una aplicación web. 

* #### :open_file_folder: *`api`*

    Directorio donde se almacena todo en referente el servicio *`REST API`*, donde se almacenan los *`controllers`*, *`routers`*, *`services`*, *`middlewares`*, *`utils`* y la *`config`*.

    * ##### :open_file_folder: *`config`*

        Directorio donde almacenamos toda la configuración necesaria para la API. De normal se almacenan las URI's de manera centralizada en el fichero *`routes.ts`*, las cuales identifican los recursos a los que intentamos acceder. A su vez se pueden almacenar otras configuraciones en referentes a seguridad, generacion de jsonwebtokens y demás.

        > Cuando se usan sockets, tambien se pueden guardar las URI's de estos sockets en este directorio.

        * ##### :page_facing_up: *`routes.ts`*

        Fichero donde declaramos de manera centralizada todos las URIS para poder acceder a los recursos.

        ```javascript
        export const HOME = '/'
        export const RESOURCE = '/resource'
        ```

    * ##### :open_file_folder: *`routers`*

        Directorio donde generamos y exportamos los routers. Estos son los encargados de cuando matchee la string que pasamos por URL al servidor, identificarla y ejecutar lo que queramos ejecutar dependiendo del recurso al que accedamos.

        Generamos los routers con esta nomenclatura `resource.routes.ts`  y a su vez generamos un fichero *`index.ts`*, el cual es el encargado de exportar todos los routers y poder realizar una posterior importación mas sencilla.
      
        * ##### :page_facing_up: *`resource.routes.ts`*

        Fichero donde generamos el router de un recurso en específico identificado en el nombre del fichero. En el caso de *`resource.routes.ts`* el recurso en cuestion es *`resource`*

        ```javascript
        //importamos express y los tipados de 'Response', 'Request' y 'NextFunction'
        import express, { Response, Request, NextFunction } from "express";
        //importamos el asyncHandler
        import asyncHandler from "express-async-handler";
        //importamos el controller
        import * as controller from "../cotroller/resource.controller";
        //generamos el router
        const router = express.Router();
        //declaración de endpoint en el router de resource. Hay que tener en cuenta que este router, todas los endpoints que pongamos, vienen predefinidos con el string creado en el fichero `routes.ts` identificando el recurso. En este caso en eldpoint no es solo '/get', sino '/resource/get'
        router.get('/get', asyncHandler(
            async (req: Request, res: Response, next: NextFunction): Promise<void> => {
                controller.get(req, res, next);
            }
        ));
        //exportamos el router
        export { router as RESOURCE };
        ```

        * ##### :page_facing_up: *`index.ts`*

        Fichero donde importamos todos los router para facilitar la posterior importación.

        ```javascript
        export  { RESOURCE } from ".resource.routes";
        // asi sucesivamente con todos los que hagamos...
        ```

    * ##### :open_file_folder: *`controllers`*

        Directorio donde generamos y exportamos los controllers. Estos son los encargados de llevar la lógica de aplicacion/negocio de la api y son tambien los encargados de llamar a los services para acceder a los datos alojados en base de datos

        Generamos los controllers con esta nomenclatura `resource.controller.ts` 
      
        * ##### :page_facing_up: *`resource.controller.ts`*

        Fichero donde generamos el *`controller`* de un recurso en específico identificado en el nombre del fichero. En el caso de *`resource.controller.ts`* el recurso en cuestion es *`resource`*

        ```javascript
        import * as service from "../service/resource.service";
        export const get = async (req: Request, res: Response, next: NextFunction) => {
            try {
                const data: any | null = await service.get();
                return res.status(200).send(data);
            } catch (error) {
                console.log(error)
                //next({ error: error, entity: "PANTALLA", typeRequest: req.method, method: "list" });
            }
        }
        ```

        > Capturamos el error a través de un try/catch puesto que estamos en un método asíncrono usando un await. Con esto evitamos que ante un posible error, la API no deje de dar servicio.

    * ##### :open_file_folder: *`services`*

        Directorio donde generamos y exportamos los services. Estos son los encargados de acceder a los datos almacenados en BBDD. Es decir, son encargados de hacer las llamadas pertinentes a BBDD para obtener los datos.

        Generamos los services con esta nomenclatura `resource.service.ts` 
      
        * ##### :page_facing_up: *`resource.service.ts`*

        Fichero donde generamos el *`service`* de un recurso en específico identificado en el nombre del fichero. En el caso de *`resource.service.ts`* el recurso en cuestion es *`resource`*

        ```javascript
        export const get = async (req: Request, res: Response, next: NextFunction) => {
            //listar los datos del recurso RESOURCE de BBDD.
        }
        ```

        > Capturamos el error a través de un try/catch puesto que estamos en un método asíncrono usando un await. Con esto evitamos que ante un posible error, la API no deje de dar servicio.

