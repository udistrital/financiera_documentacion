## Prueba unitarias con Jest en Angular 8.

**Por que jest en lugar de karma?**

jest permire la ejecucion de tests sin necesidad de usar un navegador para visualizar los tests, entiende la misma estructura de karma por enede los test ya tealizados aun sirven en jest, adicional jest incluye varias funciones extras.

jest provee una descripcion de errores de test aun mas detallada y se puede visualizar por consola, facilitando incluso en CI su integracion.

### Como instalar y configurar Jest en Angular 8

- #### instalar jest
  ```bash
  npm install jest @types/jest jest-preset-angular --save-dev
  ```
- #### desinstalar karma
  ```bash
  npm uninstall karma karma-chrome-launcher karma-coverage-istanbul-reporter karma-jasmine karma-jasmine-html-reporter @types/jasmine @types/jasminewd2 jasmine-core jasmine-spec-reporter
  ```
- #### Remover seccion de jest del archivo `angular.json`
  la seccion puede lucir asi:

  ```json
    "test": {
            "builder": "@angular-devkit/build-angular:karma",
            "options": {
                "main": "src/test.ts",
                "polyfills": "src/polyfills.ts",
                "tsConfig": "tsconfig.spec.json",
                "karmaConfig": "karma.conf.js",
                "assets": [
                "src/favicon.ico",
                "src/assets"
                ],
                "styles": [
                "src/styles.scss"
                ],
                "scripts": []
            }
            },
  ```
- #### Eliminar los archivos `karma.conf.js` and `src/test.ts`

- #### Crear el archivo `/src/setupJest.ts`
    este archivo debera de tener el siguiente contenido:

    ```typescript
    import 'jest-preset-angular';
    ```
- #### Modificar el archivo `/src/tsconfig.spec.json`
    deberia de tener un estilo similar a este

    ```json
    {
    "extends": "../tsconfig.json",
    "compilerOptions": {
        "outDir": "../out-tsc/spec",
        "types": [
        "jest",
        "node"
        ]
    },
    "files": [
        "src/test.ts",
        "src/polyfills.ts"
    ],
    "include": [
        "src/**/*.spec.ts",
        "src/**/*.d.ts"
    ]
    }
    ```

- ### modificar el archivo `package.json`

    modificar los comandos de npm n el archivo de la siguiente manera
    ```json
    "test": "jest",
    "test:coverage": "jest --coverage",
    ```
    y añadir el final del archivo lo siguente
    ```json
    "jest": {
    "preset": "jest-preset-angular",
    "setupFilesAfterEnv": [
        "<rootDir>/src/setupJest.ts"
    ],
    "testPathIgnorePatterns": [
        "<rootDir>/node_modules/",
        "<rootDir>/dist/",
        "<rootDir>/src/test.ts"
    ],
    "moduleNameMapper": {
        "^@/(.*)$'": "<rootDir>/src/$1"
    },
    "globals": {
        "ts-jest": {
        "tsConfig": "<rootDir>/src/tsconfig.spec.json",
        "stringifyContentPathRegex": "\\.html$"
        }
    }
    }
    ```