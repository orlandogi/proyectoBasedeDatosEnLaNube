# Comandos Iniciales

Con estos comandos iniciales, puedes comenzar a interactuar con MongoDB, crear bases de datos, colecciones y agregar datos.

---


### show dbs

Este comando te permite mostrar una lista de todas las bases de datos presentes en el servidor de MongoDB.
```javascript
show dbs
```

### use
El comando `use` se utiliza para cambiar a una base de datos específica. **Si la base de datos no existe, se creará automáticamente.** 
```javascript
use db1
```

### db.createCollection

Esta instrucción se utiliza para crear una nueva colección en la base de datos actualmente seleccionada.
```javascript
db1.createCollection("nombre coleccion")
```
### show collections

Después de seleccionar una base de datos específica con el comando `use`, puedes utilizar este comando para mostrar todas las colecciones presentes en esa base de datos. 
```javascript
db1.show.Collections
```

### insertOne 

Este comando se utiliza para insertar un solo documento en la colección.
```javascript
db1.empleado.insertOne({nombre:'ramon',edad:'Lopez'})
```
### insertMany

Este comando utiliza para insertar múltiples documentos a la vez. 

```javascript
db1.empleado.insertMany([
    {
     nombre:'Hermeregildo',
     edad:67
    },
     {
       nombre:'Soy la vaca del corral',
       edad:14,
       sexo:'Mujer'
     },
     {
        nombre:'Romulo',
        edad:40,
        nacionalidad:'Nigeriano'
     },
     {
        nombre:'Cristian Andres',
        localidad:'San Miguel de las Piedras',
        nacionalidad:'Aleman',
        edad:'Esta morro',
}])
```
```
