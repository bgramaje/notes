### 👨‍🏫 Express.js 
> Infraestructura web rápida, minimalista y flexible para Node.js

### Instalación

Para instalar la librería, se hace uso de [*`npm`*](https://www.npmjs.com/) *(node package manager)*
```bash
$ npm install express --save
```

#### Typescript

Para poder usara la librería de Express en Typescript hay que instalar los tipados de esta librería mediante el siguiente comando:
```bash
$ npm install --save @types/express
```

#### :evergreen_tree: Folder tree

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
├── .env.pre        # Environment variables for `preproduction` stage
├── .env.prod       # Environment variables for `production` stage
├── .env.dev        # Environment variables for `development` stage
├── .env.local      # Environment variables for `local` stage
├── package.json    # package.json file
├── tsconfig.json   # tsconfig.json file with configurations to compile the .ts files into .js
├── .gitignore      # .gitignore file to ignore the folders we do not want to upload to github.
└── ...
```

####  