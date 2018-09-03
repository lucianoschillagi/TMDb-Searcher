## Capas de la aplicación

### Networking

**TMDBClient**

*Responsabilidad:* 
Agrupar los métodos para solicitar los datos (a la API de TMDb) que conformarán el Modelo. 


### Model

**TMDbMovie**

*Responsabilidad:* 
Recibir los valores necesarios a utilizarse para construir la lógica de la aplicación. (los datos sobre las películas)


### View
**MovieTheme**

*Responsabilidad:*
Extender la clase ´UIColor´ y preconfigurar un color determinado.


### Controller
**MovieListViewContoller**

*Responsabilidad:*
Mostrar el listado de películas adecuado de acuerdo a las interacciones del usuario.


**MovieDetailViewContoller**

*Responsabilidad:*
Mostrar el detalle de la película seleccionada en la pantalla anterior.

**MovieTrailerViewContoller**

*Responsabilidad:*
Mostrar el trailer de la película seleccionada.



## En qué consiste el principio de responsabilidad única? 

El principio de responsabilidad única u SRP (siglas del inglés (Single Responsibility Principle) en ingeniería de software establece que **cada módulo o clase debe tener responsabilidad sobre una sola parte de la funcionalidad proporcionada por el software** y esta responsabilidad debe estar encapsulada en su totalidad por la clase.

## Cuál es su propósito?

* Mantener una **alta cohesión**, es decir, mantener ‘unidas’ funcionalidades que estén relacionadas entre sí y mantener fuera aquello que no esté relacionado. El objetivo es aumentar la cohesión entre las cosas que cambian por las mismas razones.

* Mantener un **bajo acoplamiento**, es decir, reducir al máximo posible el grado de la relación de un clase o módulo con el resto, para favorecer crear código más fácilmente mantenible, extensible y testeable. El objetivo es disminuir el acoplamiento entre aquellas cosas que cambian de forma diferente.

Estos dos aspectos favorecerán un código con funcionalidades más concretas y mejor especificadas.

En definitiva: la idea es reunir la cosas que cambian por las mismas razones y separar las cosas que cambian por diferentes razones.

## Características de un buen código

1- No te repitas (DRY: Don’t repeat yourself).
2- Legible
3- Organizado
4- Bien documentado
5- Asignar la responsabilidad correcta a cada clase
6- Usar nombres descriptivos para las clases, métodos y variables



