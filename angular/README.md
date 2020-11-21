# README 

### NgRx Framework:

Ngrx Framework nos permite usar el patron Redux en los proyectos de angular CLI. Para poder usarse se deben instalar las siguientes librerias:

```bash
$ ng add @ngrx/store
$ ng add @ngrx/store-devtools
$ ng add @ngrx/schematics
```

con estas librerias se podra:

- Crear y configurar Store a travez de Angular CLI
- Revisar y depurar el store con ayuda de plugins (Redux DevTools)
- Hacer uso del store en la aplicacion
 
una vez instalado, para generar un store general y registrarlo en el modulo principal:

```bash
$ ng generate store State --root --module app.module.ts
```

para generar un nuevo feature (seccion nueva del store) y registrarlo en un modulo nuevo llamado planes con todos los archivos correspondientes (actions, selectors, reducers, effects):

```bash
ng generate module pages/planes --routing=true
ng generate feature pages/planes/Planes -m pages/planes/planes.module.ts --group
```

##### Ejemplos Store

###### Feature

Ejemplo de Feature creado para nuevo modulo llamado planes generado con el script anterior:

```typescript
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { StoreModule } from '@ngrx/store';
import * as fromPlanes from './reducers/planes.reducer';
import { EffectsModule } from '@ngrx/effects';
import { PlanesEffects } from './effects/planes.effects';

@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    StoreModule.forFeature(fromPlanes.planesFeatureKey, fromPlanes.reducer),
    EffectsModule.forFeature([PlanesEffects]),
  ]
})
export class PlanesModule { }

```

###### Actions

Ejemplo de actions con y sin propiedades

```typescript
import { createAction, props } from '@ngrx/store';

// Sin propiedades
export const loadPlaness = createAction(
  '[Planes] Load Planess'
);

// Con Propiedades
export const CatchError = createAction(
  '[Planes] Catch Error',
  props()
);
```

###### Reducers 

Ejemplo de reducers para Feature Planes

```typescript
import { Action, createReducer, on } from '@ngrx/store';
import * as PlanesActions from '../actions/planes.actions';

// Llave del Feature (usada en la declaracion en el modulo)
export const planesFeatureKey = 'planes';

// Declaracion de la seccion del store
export interface State {
  Planes: any;
  PlanSeleccionado: any;
}

// Declaracion del Estado Inicial de la seccion del store
export const initialState: State = {
  Planes: [],
  PlanSeleccionado: null,
};

// Declaracion del Reducer con Estado inicial y posibles acciones recibidas
const planesReducer = createReducer(
  initialState,

  // Accion Sin Cambios en el store
  on(PlanesActions.loadPlaness, state => state),
  
  // Acciones con Cambios en la seccion del store
  on(PlanesActions.SeleccionarPlan, (state, action) => ({
    ...state, PlanSeleccionado: state.PlanSeleccionado = action
  })),
  on(PlanesActions.CargarPlanes, (state, action) => ({
    ...state, Planes: state.Planes = action
  })),
);
// Creacion del Reducer
export function reducer(state: State | undefined, action: Action) {
  return planesReducer(state, action);
}
```

###### Selectors

```typescript
import { createFeatureSelector, createSelector } from '@ngrx/store';
import * as fromPlanes from '../reducers/planes.reducer';

// Asociando llave de Reducer para la creacion de selectors 
export const selectPlanesState = createFeatureSelector<fromPlanes.State>(
  fromPlanes.planesFeatureKey
);

// declaracion de selector para las propiedades del store correspondientes
export const getPlanSeleccionado = createSelector(
  selectPlanesState,
  (state: fromPlanes.State) => state.PlanSeleccionado
);

export const getPlanes = createSelector(
  selectPlanesState,
  (state: fromPlanes.State) => state.Planes
);
```

###### Effects 

```typescript
import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { concatMap } from 'rxjs/operators';
import { EMPTY } from 'rxjs';
import * as PlanesActions from '../actions/planes.actions';

@Injectable()
export class PlanesEffects {

//Inyeccion de Actions y servicios
  constructor(
    private actions$: Actions,
    private planesService: PlanesService,
  ) { }
  
  loadPlaness$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(PlanesActions.loadPlaness),
      /** EMPTY observable
      concatMap(() => EMPTY)
    );
  });
  // Ejemplo para consultar plan desde base de datos
  GetMeta$ = createEffect(() => {
    return this.actions$.pipe(
      ofType(PlanesActions.ConsultarPlan), // captura la accion
      mergeMap((opciones: any) =>
        this.planesService.getPlan(  // consulta informacion a travez de un servicio
          opciones.Id,
        ).pipe(
          map(data => {
            return PlanesActions.SeleccionarPlan(data);  // acciones de respuesta satisfactoria
          }),
          catchError(data => {
            this.popupManager.showAlert('error', data.status, data.statusText);
            return of(MetasActions.CatchError(data)); // acciones de respuesta erronea
          }))
      )
    );
  });
}

```

### Angular Routing Lazy Loading

Es necesario crear un modulo que cotendra los distintos componentes dentro de el

```bash
ng generate module pages/primer-modulo --routing=true
```

para poder trabajar con la carga lenta de modulos a travez de angular routing, es necesario hacer el siguiente cambio en los archivos de routing en el modulo:



```typescript
import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';
import { CustomModule } from 'path';

import { PagesComponent } from './pages.component';

const routes: Routes = [{
  path: '',
  component: PagesComponent,
  children: [
    {
      path: 'prueba',
      loadChildren: () => import('./primer-modulo/primer-modulo.module')
      .then(m => m.PrimerModuloModule),
      // Lazy Loading Angular 8+
    },
    {
      path: 'prueba2',
      loadChildren: 'src/app/path/to/your/module/custom.module#CustomModule',
      // Lazy Loading Angular 7 o menor
    },
    {
      path: 'prueba3',
      loadChildren: () => CustomModule,
      // Lazy Loading Angular 7 o menor
    },
    {
      path: '',
      redirectTo: 'prueba',
      pathMatch: 'full',
    },
    {
      path: '**',
      redirectTo: 'prueba',
      pathMatch: 'full',
    },
  ],
}];

```

para crear componentes para ese modulo

```bash
ng g c pages/primer-modulo/compoentes/[nombre del componente]
```