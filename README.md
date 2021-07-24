## 👨‍🏫
> Basic template to get your project started from scratch!


👨🏻‍💻 Hey coder! In this repository you will find a basic schema structure to start your own REST API. 👨🏻‍💻
This schema is made by some best practices I encountered and think they are pretty usefull to make your code nicer and organized.

### Built with 🛠️

_The following dependecies are used in the project_

_Dependencies:_
* [cors](https://www.npmjs.com/package/cors) - Node.js CORS middleware
* [dotenv](https://www.npmjs.com/package/dotenv) - Loads environment variables from .env file
* [express](https://www.npmjs.com/package/express) - Fast, unopinionated, minimalist web framework
* [helmet](https://www.npmjs.com/package/helmet) - Help secure Express/Connect apps with various HTTP headers
* [jsonwebtoken](https://www.npmjs.com/package/jsonwebtoken) - JSON Web Token implementation (symmetric and asymmet
* [morgan](https://www.npmjs.com/package/morgan) - HTTP request logger middleware for node.js
* [cookie-parser](https://www.npmjs.com/package/cookie-parser) - Parse HTTP request cookies
* [compression](https://www.npmjs.com/package/compression) - Node.js compression middleware
* [express-async-handler](https://www.npmjs.com/package/express-async-handler) - Express Error Handler for Async Functions

_Developer dependencies:_
* [eslint](https://www.npmjs.com/package/eslint) - An AST-based pattern checker for JavaScript.
* [eslint-config-airbnb-base](https://www.npmjs.com/package/eslint-config-airbnb-base) - Airbnb's base JS ESLint config, following our styleguide
* [eslint-plugin-import](https://www.npmjs.com/package/eslint-plugin-import) - Import with sanity.
* [mocha](https://www.npmjs.com/package/mocha) - Simple, flexible, fun test framework
* [nodemon](https://www.npmjs.com/package/nodemon) - Simple monitor script for use during development of a node.js app.
* [supertest](https://www.npmjs.com/package/supertest) - SuperAgent driven library for testing HTTP servers
* [babel](https://babeljs.io/) - The compiler for next generation JavaScript

### Installation
1. Clone the repository
```sh
git clone https://github.com/boralbgra/express-api-template.git
```
2. Install dependecies
```sh
npm install
```
3. Run it!
```sh
npm run dev
```
### /.src Folder
```bash
.
├── ...
├── src         # Source files 
│   ├── api         # api directory including all default shcema
│   │   ├── controllers          # express routes functions 
│   │   ├── db                   # functions that works over the DDBB (updates, deletes, lists..)
│   │   ├── middlewares          # express middlewares (jsonwebtoken...)
│   │   ├── routes               # express routes declaration
│   │   └── scripts              # backend scripts
│   ├── config      # config file
│   │   ├── db          # contains all DDBB config files
│   │   ├── routes          # exports all routes globally
│   ├── app.js      # express app server
│   └── index.js    # starts the server (app.js) in the port established or in a default port      
├── test        # Test files (alternatively `spec` or `tests`)
└── ...
```

> In each folder of the api, there is an index file. In that file all elements are imported and exported, in order to make easier the import list, as an only import instead of X different imports.

```bash
.
├── api        # api directory including all default shcema
│   ├── controllers          
│   │   └── index.js        # all controllers imported and exported as one object
│   ├── db                   
│   │   └── index.js                 # all db imported and exported as one object
│   ├── middlewares          
│   │   └── index.js        # all middlewares imported and exported as one object  
│   ├── routes           
│   │   └── index.js             # all routes imported and exported as one object  
│   └── scripts              
│       └── index.js            # all scripts imported and exported as one object  
└── ...
```

### /.test Folder
```bash
.
├── ...
├── src         # Source files 
├── test        # Test files (alternatively `spec` or `tests`)
│   ├── app.test.js              # Unit tests for app.js
│   └── hello.routes.test.js     # Unit tests for hello.routes.js
└── ...
```

### Release History
* 1.0.4
    * Renamed all index files to `index.js` for import purposes, and updated `config` folder
* 1.0.3
    * Added `express-async-handler` and `compression` packages
* 1.0.2
    * Add `README.md`
* 1.0.1
    * The first proper release
* 1.0.0
    * Work in progress

### Mentions

A mention to [CJ R.](https://github.com/w3cj), for the following [repository](https://github.com/w3cj/express-api-starter) as a guidance for doing the base of this template. 


### License

Distributed under the MIT license. See ``LICENSE`` for more information.
