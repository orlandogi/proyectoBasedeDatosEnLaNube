# Agregaciones

Las agregaciones en MongoDB permiten realizar operaciones avanzadas de procesamiento de datos en colecciones.

---

### $group
Este operador se utiliza para agrupar documentos por un campo específico y realizar operaciones de agregación en los datos agrupados, como sumas, promedios o contar el número de documentos en cada grupo.

### $set

El operador $set se utiliza para agregar nuevos campos o modificar campos existentes en documentos durante una agregación. Esto permite realizar cálculos o transformaciones en los datos antes de pasar al siguiente paso de la agregación.

### $out
El operador $out se utiliza para escribir los resultados de una operación de agregación en una nueva colección. Esto es útil cuando deseas almacenar los resultados de una operación de agregación para su uso posterior o análisis adicional.

##Ejemplos

Las siguientes agregaciones constan de dos etapas:

```json
[
  {
    "$group": {
      "_id": "$editorial",
      "Numero Documentos": {
        "$count": {}
      }
    }
  },
  {
    "$sort": {
      "Numeros Documentos": 1
    }
  }
]
```

1. **$group:** Esta etapa agrupa los documentos segun el valor del campo _editorial_ y cuenta el numero de documentos en cada grupo.

2. **$sort:** Esta etapa ordena los resultados de la etapa anterior según el número de documentos en orden ascendente.

```json
[
  {
    "$group": {
      "_id": "$editorial",
      "Numero de Documentos": {
        "$count": {}
      },
      "media": {
        "$avg": "$precio"
      },
      "Precio Maximo": {
        "$max": "$precio"
      }
    }
  },
  {
    "$sort": {
      "Precio Maximo": 1
    }
  }
]
```

1. **$group:** En esta etapa, los documentos se agrupan segun el valor del campo _editorial_. Ademas de eso, se calcula la media y el precio maximo del campo _precio_ para cada grupo.

2. **$sort:** En esta etapa, los resultados de la etapa anterior se ordenan en orden ascendente segun el valor del campo _Precio Maximo_.

En el siguiente caso aumentamos de nivel a 3 etapas:

```javascript
[
  {
    "$group": {
      "_id": "$editorial",
      "Numero": {
        "$count": {}
      },
      "media": {
        "$avg": "$precio"
      }
    }
  },
  {
    "$set": {
      "Media Total": {
        "$trunc": ["$media", 2]
      }
    }
  },
  {
    "$out": "media_editoriales"
  }
]
```

1. **$group:** En esta etapa, los documentos se agrupan segun el valor del campo _editorial_. Se cuentan los documentos en cada grupo y se calcula la media del campo _precio_ para cada grupo.

2. **$set:** En esta etapa, se calcula la media total redondeada a dos decimales y se crea un nuevo campo llamado _Media Total_.

3. **$out:** Finalmente, en esta etapa, los resultados se escriben en una nueva colección llamada _media_editoriales_.
