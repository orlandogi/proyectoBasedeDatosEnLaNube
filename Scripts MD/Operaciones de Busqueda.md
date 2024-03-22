# Busquedas
---

Este comando devuelve todos los documentos dentro de la coleccion, en este caso la coleccion _empleado_.

```sql
db1.empleado.find()
```

Tambien podemos ver solo ciertas columnas a este se le llaman **proyecciones**.Por ejemplo: esta consulta solo devolvera el campo _titulo_ donde el titulo sea _Don quijote_

```sql
db.libros.find({titulo:'Don quijote'},{titulo:1})
```

# Busquedas Condicionales

---

Este comando tambien devuelve todos los documentos dentro de la coleccion _empleado_.La diferencia es que se especifica un filtro vacio `{}`

```sql
db1.empleado.find({})
```

Este es un ejemplo de un filtro que se aplica a la busqueda.

- **campo:** es el nombre del campo que quieres comparar.

* **$operador:** es el operador de comparacion que especifica como comparar el campo.

* **valor:** es el valor con el que se desea comparar el campo.

```sql
db.collection.find({campo:{$oper:'valor'}})
```

A continuacion veremos algunos de estos filtros:

- **$eq:** es el operador de igual que significa **igual a**
  Esta consulta recuperara todos los documentos de la coleccion _libros_ donde el campo _editorial_ se exactamente igual a _Biblio_

```sql
db.libros.find({editorial:{$eq:"Biblio"}})
```

- **$gte:** es el operador de comparacion que significa **mayor o igual a**
  Esta consulta recuperara todos los documentos de la coleccion _libros_ donde el campo _precio_ sea mayor o igual a 20

```sql
db.libros.find({precio:{$gte:20}})
```

- **$lt:** es el operador de comparacion que significa **menor que**.
  Esta consulta recuperara todos los documentos de la coleccion _libros_ donde el campo _precio_ sea menor que 5

```sql
db.libros.find({precio:{$lt:5}})
```

- **$in:** es el operador de comparacion que significa **en**.
  Esta consulta recuperara todos los documentos de la coleccion _libros_ donde el campo _editorial_ coincida con _Biblio_ o _Planeta_

```sql
db.libros.find({editorial:{$in:['Bilio', 'Planeta']}})
```

- **$and:** este es un **operador logico** que especifica que **ambas** condiciones deben de ser **verdaderas** para que el documento sea devuelto.
  Esta consulta recuperara todos los documentos de la coleccion _libros_ donde el _precio_ sea mayor que 25 y la _cantidad_ sea menor que 15 al mismo tiempo

```sql
db.libros.find({$and: [{precio:{$gt:25}}, {cantidad:{$lt:15}}]})
```

- **$or:** este es un **operador logico** que especifica que al menos **una** de las condiciones debe ser **verdadera** para que el documento sea devuelto.
  Esta consulta recuperara todos los documentos que cumplan con al menos una de las siguientes condiciones: **(1)** la editorial es "Biblio" y el precio es mayor que 10, o **(2)** el precio es mayor que 30 y la editorial es "Planeta".

```sql
db.libros.find( { $or: [ { $and: [{ editorial: { $eq: 'Biblio' } }, { precio: { $gt: 10 } }] }, { $and: [{ precio: { $gt: 30 } }, { editorial: { $eq: 'Planeta' } }] }] })
```

- **$exists:** verifica si existe una columna en los documentos de la coleccion.
  Esta consulta buscara documentos en la coleccion que tengan el campo _autor_, idenpendientemente de su valor.

```sql
db.libros.find({$and:[{precio:{$gt:5}},{autor:{$exists:true}}]})
```

# Metodos de busqueda

---

Estas son otras maneras de recuperar datos pero mas eficientes y precisas:

- **.size():** se utiliza para obtener el numero de documentos que cumplen la condicion.
  Después de obtener los resultados, _size()_ se aplica para contar el número total de documentos que coinciden con los criterios de búsqueda y proyección especificados.

```sql
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).size()
```

- **.skip():** se utiliza para saltar un numero de documentos, resultados de una consulta.
  Después de obtener los resultados,utilizamos _skip(2)_ para omitir los primeros dos documentos de los resultados.

```sql
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).skip(2)
```

- **.limit():** se utiliza para limitar el numero de documentos devueltos por una consulta.
  Después de obtener los resultados,utilizamos _limit(2)_ para limitar el numero de documentos devueltos a solo dos.

```sql
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).limit(2)
```

- **.sort():** ordena los resultados de una consulta basandose en uno o mas campos de los documentos recuperados.
  - **1** ascendente
  - **-1** descendente
    Estamos ordenando primero por el campo _titulo_ de forma ascendente*(1)*, si hubiera titulos iguales, entonces se ordenarian por el campo _editorial_ de forma ascendente tambien.

```sql
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).limit(2)
```

Tambien podemos usar **expresiones regulares** para buscar documentos que coincidan con patrones especificos de texto.Aqui hay una forma de utilizarla, como el caso de buscar una cadena de texto que termine en _os_

```sql
db.libros.find({"titulo":/os$/})
```

# UpdateOne y UpdateMany

---

La operacion updateOne se usa para actualizar solo un documento que coincide con el filtro especificado.

Entonces aqui, buscara un documento en la colección con el titulo _JSON para todos_ y, si lo encuentra, modificará el titulo del documento a _Java el Rey_.

```sql
db.libros.updateOne({titulo:'JSON para todos'},{$set:{titulo:'Java el Rey'}})
```

La operacion updateMany se utiliza para actualizar multiples documentos que coincidenc con el filtro especificado.

En la siguiente consulta, se buscaran todos los documentos donde el _precio_ sea mayor a 9 y por cada uno de esos documentos encontrados, modificara el _precio_ a 150.

```sql
db.libros.updateMany({precio:{$gt:9}},{$set:{precio:150}})
```

# DeleteOne y DeleteMany

---

La operacion deleteOne se usa para eliminar un solo documento que coincide con el filtro epecificado.

Entonces esta consulta, buscara un documento en la coleccion con el titulo _Java el Rey_ y, si lo encuentra, lo eliminara.

```sql
db.libros.deleteOne({"titulo":'Java el Rey'})
```

Por otro lado tenemos a deleteMany, donde se usa para eliminar multiples documentos que coinciden con el filtro.

En la conuslta se buscara todos los documentos en la coleccion "libros" donde la cantidad sea mayor que 20 y, para cada uno de estos documentos encontrados, los eliminara.

```sql
db.libros.deleteMany({cantidad:{$gt:20}})
```

# DeleteOne y DeleteMany

---

replaceOne se utiliza para reemplazar un solo documento completo que coincide con el filtro.

La siguiente consulta buscara un documento con _id_ igual a 13, y si lo encuentra, lo reemplazara con el nuevo documento proporcionado.

```sql
db.libros.replaceOne({"_id":13},{"titulo":"Las patoaventuras de Ezequiel Alias Mateo"})
```
