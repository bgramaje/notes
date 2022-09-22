### 👨‍🏫 Express.js
> Infraestructura web rápida, minimalista y flexible para Node.js

![Badge en Desarollo](https://img.shields.io/badge/STATUS-EN%20DESAROLLO-green)

### Índice
1. [Instalación](#instalación)
2. [Estructura](#open_file_folder-estructura)
3. [Recursos](#paperclip-recursos)
    * [:page_facing_up: *`index.ts`*](#page_facing_up-index.ts)


### Instalación

Para instalar la librería, se hace uso de [*`npm`*](https://www.npmjs.com/) *(node package manager)*
```bash
$ npm install express --save
```

- #### Typescript

Para poder usar la librería de Express en Typescript hay que instalar los tipados de esta librería mediante el siguiente comando:
```bash
$ npm install --save @types/express
```

### :open_file_folder: Estructura

```bash
./
├── ...
├── api     # Api directorty
│   ├── config      # Config directory with specific configuration for the api
│   │   └── ...
│   ├── controllers # Controllers directory with all controllers in the api.
│   │   └── ...
│   ├── middlewares # Middlewares used such as routes with token authentication
│   │   └── ...
│   ├── routes      # Routes directory with all routes in the api.
│   │   └── ...
│   ├── services    # Services directory with all the services in the api.
│   │   └── ...
│   ├── utils       # Utils directory
│   │   └── ...
│   ├── app.ts      # app.ts file declaration where the express app is created
│   ├── index.ts    # index.ts file that works as a start-point of the app.
│   └── server.ts    # server.ts file that contains de http server wrapped with the express `app`
├── .env.pre        # Environment variables for `preproduction` stage
├── .env.prod       # Environment variables for `production` stage
├── .env.dev        # Environment variables for `development` stage
├── .env.local      # Environment variables for `local` stage
├── package.json    # package.json file
├── tsconfig.json   # tsconfig.json file with configurations to compile the .ts files into .js
├── .gitignore      # .gitignore file to ignore the folders we do not want to upload to github.
└── ...
```
### :paperclip: Recursos

#### :page_facing_up: *`index.ts`*

Este fichero es el *`entrypoint`* a ejecutar para levantar todo el servicio REST API que vamos a utilizar. En este fichero se levante el servidor http escuchando por el puerto que le hemos indicado.

```javascript
import server from "./server";
//obtenemos el puerto y el host a partir de las variables de entorno. Si estas no estan definidas, se obtiene por defecto el puerto 5000 y el host '0.0.0.0'
const PORT = parseInt(process.env.PORT!) || 5000;
const HOST = process.env.HOST || '0.0.0.0';

(async () => {
    //arrancamos el servidor. Cuando este arranca mostramos un mensaje por consola afirmando que ha arrancado de manera satisfactoria
    server.listen(PORT, HOST, () => {
        console.log(`Listening on http://${HOST}:${PORT}`);
    });
})();
```

#### server.ts

El fichero contiene el servidor http generado en node conteniendo la app de express para luego cargar todo tema de rutas y controladores generados en express

```javascript
import http from 'http';
import app from './app';
//crear el servidor http contenido con la app de express importada de 'app.ts'
const server = http.createServer(app);
//exportamos el server para futuras importaciones
export default server;
```

#### app.ts

```javascript
import express, { Request, Response } from "express";
//declaramos el app con el constructor de express para poder arrancar luego el servidor.
const app = express();

```