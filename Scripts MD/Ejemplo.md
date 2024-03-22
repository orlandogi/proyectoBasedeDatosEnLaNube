# Primeros comandos

---

#### Mostrar(_show_) y crear base de datos(_use_)

Muestra una lista de las bases de datos presentes en el servidor MongoDB

```sql
show dbs
```

El comando `use` se utiliza para cambiar a una base de datos especifica, pero no la crea automaticamente.**La base de datos se crea solo al agregar el primer documento a una coleccion dentro de ella**

```sql
use db1
```

---

#### Mostrar(_show_) y crear colecciones(_create_)

El primer comando crea una nueva coleccion en la base de datos en esta caso llamada _db1_.

```json
db1.createCollection("nombre coleccion")
db1.show.Collections
```

El segundo comando es utilizado para obtener una lista de todas las colecciones dentro de la base de datos _db1_

```json
db1.show.Collections
```

---

#### InsertOne y InsertMany

Este codigo inserta un nuevo documento en la coleccion _empleados_ dentro de la base de datos _db1_

```sql
db1.empleado.insertOne({nombre:'ramon',edad:'Lopez'})
```

Este comando se utiliza para insertar varios documentos a la vez en una coleccion especifica. Por ejemplo insertamos multiples documentos en la coleccion _empleado_ dentro de la base de datos _db1_

```sql
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
