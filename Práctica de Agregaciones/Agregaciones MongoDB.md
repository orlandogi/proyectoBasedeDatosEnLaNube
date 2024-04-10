# Agregaciones

Las agregaciones en MongoDB son una herramienta poderosa para realizar consultas complejas y análisis de datos en colecciones de MongoDB. Permiten a los desarrolladores realizar operaciones avanzadas de manipulación de datos de manera eficiente y escalable.

---


## Introducción

En la siguiente práctica de agregaciones en MongoDB, se exploraran operaciones que permiten procesar datos de manera avanzada en colecciones de MongoDB utilizando utilizando los documentos del archivo `productos.json`

### Operaciones
##### 1. Cuenta los productos de tipo “medio”, usando un método básico
###### `Consulta:` 
```javascript
db.productos.count({ "tipo": "medio" })
```
##### `Salida:`
```javascript
25
```
##### 2. Indicar con un distinct, las empresas (fabricantes) que hay en la colección
###### `Consulta:` 
```javascript
db.productos.distinct("fabricante")
```
##### `Salida:`
```javascript
[
  'A.O. Smith',
  'Alere',
  'American Tire Distributors Holdings',
  'Anthem',
  'Archrock',
  'Ascena Retail Group',
  'AutoNation',
  'Best Buy',
  'CIT Group',
  'Cabot',
  'Comcast',
  'Comerica',
  'Core-Mark Holding',
  'DST Systems',
  'Darling Ingredients',
  'Delta Air Lines',
  'Delta Tucker Holdings',
  "Dick's Sporting Goods",
  'First Solar',
  'HCA Holdings',
  'Hanesbrands',
  'Hartford Financial Services Group',
  'Hawaiian Holdings',
  'HealthSouth',
  'Hyatt Hotels',
  'Kar Auction Services',
  'Kelly Services',
  'Kemper',
  'Kimberly-Clark',
  'Lennar',
  'Mercury General',
  'Mondelez International',
  'Motorola Solutions',
  'Nasdaq OMX Group',
  'National Oilwell Varco',
  'Nordstrom',
  'OneMain Holdings',
  'Oneok',
  'Orbital ATK',
  'Pep Boys-Mann',
  'Pool',
  'Precision Castparts',
  'Primoris Services',
  'Raymond James Financial',
  'Seaboard',
  'Securian Financial Group',
  'Simon Property Group',
  'State Farm Insurance Cos.',
  'State Street Corp.',
  'SunPower',
  'TEGNA',
  'Telephone & Data Systems',
  'Total System Services',
  'Tractor Supply',
  'TransDigm Group',
  'Trinity Industries',
  'TrueBlue',
  'Universal American',
  'Universal Health Services',
  'WGL Holdings',
  "Wendy's",
  'Werner Enterprises',
  'WestRock',
  'Williams-Sonoma'
]
```

##### 3. Usando aggregate, visualizar los productos que tengan más de 80 unidades
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $match: {
                unidades: { $gt: 80 } 
            }
        },
        {
            $project: {
                _id: 0, 
                codigo: 1,
                nombre: 1,
                unidades: 1,
                precio: 1,
                fabricante: 1,
                tipo: 1
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    codigo: 2,
    nombre: 'Small Soft Fish',
    unidades: 96,
    precio: 189,
    fabricante: 'Primoris Services',
    tipo: 'medio'
  },
  {
    codigo: 0,
    nombre: 'Fantastic Wooden Fish',
    unidades: 95,
    precio: 291,
    fabricante: 'Kimberly-Clark',
    tipo: 'avanzado'
  },
  {
    codigo: 12,
    nombre: 'Refined Concrete Salad',
    unidades: 90,
    precio: 129,
    fabricante: 'Universal Health Services',
    tipo: 'avanzado'
  },
  {
    codigo: 30,
    nombre: 'Small Rubber Pants',
    unidades: 89,
    precio: 16,
    fabricante: 'Hanesbrands',
    tipo: 'basico'
  },
  {
    codigo: 33,
    nombre: 'Generic Concrete Hat',
    unidades: 82,
    precio: 70,
    fabricante: 'American Tire Distributors Holdings',
    tipo: 'basico'
  },
  {
    codigo: 53,
    nombre: 'Licensed Plastic Hat',
    unidades: 96,
    precio: 38,
    fabricante: 'Best Buy',
    tipo: 'medio'
  },
  {
    codigo: 54,
    nombre: 'Generic Metal Sausages',
    unidades: 84,
    precio: 77,
    fabricante: 'DST Systems',
    tipo: 'medio'
  },
  {
    codigo: 61,
    nombre: 'Sleek Rubber Keyboard',
    unidades: 82,
    precio: 33,
    fabricante: 'Alere',
    tipo: 'basico'
  },
  {
    codigo: 66,
    nombre: 'Incredible Concrete Fish',
    unidades: 96,
    precio: 336,
    fabricante: 'Darling Ingredients',
    tipo: 'medio'
  }
]
```
##### 4. Con $project visualizar solo el nombre, unidades y precio de los productos que tengan menos de 10 unidades
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $match: {
                unidades: { $lt: 10 } 
            }
        },
        {
            $project: {
                _id: 0,
                nombre: 1,
                unidades: 1,
                precio: 1
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  { nombre: 'Ergonomic Metal Ball', unidades: 5, precio: 246 },
  { nombre: 'Handmade Plastic Hat', unidades: 7, precio: 253 },
  { nombre: 'Ergonomic Metal Table', unidades: 0, precio: 94 },
  { nombre: 'Practical Frozen Chips', unidades: 0, precio: 305 },
  { nombre: 'Intelligent Frozen Sausages', unidades: 3, precio: 111 },
  { nombre: 'Rustic Plastic Mouse', unidades: 5, precio: 24 },
  { nombre: 'Fantastic Metal Pants', unidades: 5, precio: 129 }
]
```

##### 5. Con $project ponemos el fabricante, pero le cambiamos el nombre por “empresa".     Usamos el mismo comando anterior
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $match: {
                unidades: { $lt: 10 } 
            }
        },
        {
            $project: {
                _id: 0, 
                nombre: 1,
                unidades: 1,
                precio: 1,
                empresa: "$fabricante" 
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    nombre: 'Ergonomic Metal Ball',
    unidades: 5,
    precio: 246,
    empresa: 'Seaboard'
  },
  {
    nombre: 'Handmade Plastic Hat',
    unidades: 7,
    precio: 253,
    empresa: "Dick's Sporting Goods"
  },
  {
    nombre: 'Ergonomic Metal Table',
    unidades: 0,
    precio: 94,
    empresa: 'Kelly Services'
  },
  {
    nombre: 'Practical Frozen Chips',
    unidades: 0,
    precio: 305,
    empresa: 'Delta Air Lines'
  },
  {
    nombre: 'Intelligent Frozen Sausages',
    unidades: 3,
    precio: 111,
    empresa: 'A.O. Smith'
  },
  {
    nombre: 'Rustic Plastic Mouse',
    unidades: 5,
    precio: 24,
    empresa: 'Orbital ATK'
  },
  {
    nombre: 'Fantastic Metal Pants',
    unidades: 5,
    precio: 129,
    empresa: 'OneMain Holdings'
  }
]
```

##### 6. Añadir a la consulta anterior un campo calculado que se llame total y que multiplique precio por unidades.
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $match: {
                unidades: { $lt: 10 } 
            }
        },
        {
            $project: {
                _id: 0, 
                nombre: 1,
                unidades: 1,
                precio: 1,
                empresa: "$fabricante", 
                total: { $multiply: ["$precio", "$unidades"] } 
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    nombre: 'Ergonomic Metal Ball',
    unidades: 5,
    precio: 246,
    empresa: 'Seaboard',
    total: 1230
  },
  {
    nombre: 'Handmade Plastic Hat',
    unidades: 7,
    precio: 253,
    empresa: "Dick's Sporting Goods",
    total: 1771
  },
  {
    nombre: 'Ergonomic Metal Table',
    unidades: 0,
    precio: 94,
    empresa: 'Kelly Services',
    total: 0
  },
  {
    nombre: 'Practical Frozen Chips',
    unidades: 0,
    precio: 305,
    empresa: 'Delta Air Lines',
    total: 0
  },
  {
    nombre: 'Intelligent Frozen Sausages',
    unidades: 3,
    precio: 111,
    empresa: 'A.O. Smith',
    total: 333
  },
  {
    nombre: 'Rustic Plastic Mouse',
    unidades: 5,
    precio: 24,
    empresa: 'Orbital ATK',
    total: 120
  },
  {
    nombre: 'Fantastic Metal Pants',
    unidades: 5,
    precio: 129,
    empresa: 'OneMain Holdings',
    total: 645
  }
]
```

##### 7. Hacer que el nombre salga en mayúsculas con el operador $toUpper
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $match: {
                unidades: { $lt: 10 } 
            }
        },
        {
            $project: {
                _id: 0, 
                nombre: { $toUpper: "$nombre" }, 
                unidades: 1,
                precio: 1,
                empresa: "$fabricante", 
                total: { $multiply: ["$precio", "$unidades"] } 
            }
        }
    ])})
```
##### `Salida:`
```javascript
[
  {
    unidades: 5,
    precio: 246,
    nombre: 'ERGONOMIC METAL BALL',
    empresa: 'Seaboard',
    total: 1230
  },
  {
    unidades: 7,
    precio: 253,
    nombre: 'HANDMADE PLASTIC HAT',
    empresa: "Dick's Sporting Goods",
    total: 1771
  },
  {
    unidades: 0,
    precio: 94,
    nombre: 'ERGONOMIC METAL TABLE',
    empresa: 'Kelly Services',
    total: 0
  },
  {
    unidades: 0,
    precio: 305,
    nombre: 'PRACTICAL FROZEN CHIPS',
    empresa: 'Delta Air Lines',
    total: 0
  },
  {
    unidades: 3,
    precio: 111,
    nombre: 'INTELLIGENT FROZEN SAUSAGES',
    empresa: 'A.O. Smith',
    total: 333
  },
  {
    unidades: 5,
    precio: 24,
    nombre: 'RUSTIC PLASTIC MOUSE',
    empresa: 'Orbital ATK',
    total: 120
  },
  {
    unidades: 5,
    precio: 129,
    nombre: 'FANTASTIC METAL PANTS',
    empresa: 'OneMain Holdings',
    total: 645
  }
]
```

##### 8. Añadir un campo calculado que ponga el nombre del producto y el tipo concatenado con el operador $concat. Le llamamos al campo “completo”
###### `Consulta:` 
```javascript
 db.productos.aggregate([
        {
            $project: {
                _id: 0,
                completo: { $concat: ["$nombre", " - ", "$tipo"] }, 
                unidades: 1,
                precio: 1,
                empresa: "$fabricante",
                total: { $multiply: ["$precio", "$unidades"] }
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    unidades: 96,
    precio: 189,
    completo: 'Small Soft Fish - medio',
    empresa: 'Primoris Services',
    total: 18144
  },
  {
    unidades: 66,
    precio: 279,
    completo: 'Rustic Concrete Pants - medio',
    empresa: 'Mercury General',
    total: 18414
  },
  {
    unidades: 95,
    precio: 291,
    completo: 'Fantastic Wooden Fish - avanzado',
    empresa: 'Kimberly-Clark',
    total: 27645
  },
  {
    unidades: 45,
    precio: 37,
    completo: 'Small Steel Gloves - avanzado',
    empresa: 'TrueBlue',
    total: 1665
  },
  {
    unidades: 5,
    precio: 246,
    completo: 'Ergonomic Metal Ball - medio',
    empresa: 'Seaboard',
    total: 1230
  },
  {
    unidades: 16,
    precio: 337,
    completo: 'Handmade Steel Chair - medio',
    empresa: 'CIT Group',
    total: 5392
  },
  {
    unidades: 16,
    precio: 282,
    completo: 'Handcrafted Soft Gloves - basico',
    empresa: 'Pep Boys-Mann',
    total: 4512
  },
  {
    unidades: 63,
    precio: 238,
    completo: 'Ergonomic Wooden Shirt - avanzado',
    empresa: 'Securian Financial Group',
    total: 14994
  },
  {
    unidades: 41,
    precio: 67,
    completo: 'Practical Soft Pants - avanzado',
    empresa: 'Hyatt Hotels',
    total: 2747
  },
  {
    unidades: 49,
    precio: 265,
    completo: 'Fantastic Concrete Salad - basico',
    empresa: 'Kar Auction Services',
    total: 12985
  },
  {
    unidades: 7,
    precio: 253,
    completo: 'Handmade Plastic Hat - medio',
    empresa: "Dick's Sporting Goods",
    total: 1771
  },
  {
    unidades: 53,
    precio: 178,
    completo: 'Unbranded Soft Fish - basico',
    empresa: 'Total System Services',
    total: 9434
  },
  {
    unidades: 40,
    precio: 126,
    completo: 'Small Concrete Fish - medio',
    empresa: 'Precision Castparts',
    total: 5040
  },
  {
    unidades: 90,
    precio: 129,
    completo: 'Refined Concrete Salad - avanzado',
    empresa: 'Universal Health Services',
    total: 11610
  },
  {
    unidades: 15,
    precio: 180,
    completo: 'Refined Concrete Bike - basico',
    empresa: 'Trinity Industries',
    total: 2700
  },
  {
    unidades: 68,
    precio: 52,
    completo: 'Tasty Cotton Pants - basico',
    empresa: 'Cabot',
    total: 3536
  },
  {
    unidades: 71,
    precio: 290,
    completo: 'Incredible Granite Gloves - avanzado',
    empresa: 'Oneok',
    total: 20590
  },
  {
    unidades: 35,
    precio: 190,
    completo: 'Practical Metal Mouse - basico',
    empresa: 'National Oilwell Varco',
    total: 6650
  },
  {
    unidades: 55,
    precio: 113,
    completo: 'Handcrafted Steel Chicken - medio',
    empresa: 'State Street Corp.',
    total: 6215
  },
  {
    unidades: 40,
    precio: 212,
    completo: 'Refined Wooden Tuna - avanzado',
    empresa: 'WGL Holdings',
    total: 8480
  },
  {
    unidades: 0,
    precio: 94,
    completo: 'Ergonomic Metal Table - avanzado',
    empresa: 'Kelly Services',
    total: 0
  },
  {
    unidades: 18,
    precio: 76,
    completo: 'Tasty Wooden Ball - basico',
    empresa: 'State Farm Insurance Cos.',
    total: 1368
  },
  {
    unidades: 65,
    precio: 233,
    completo: 'Licensed Fresh Chicken - basico',
    empresa: 'Kemper',
    total: 15145
  },
  {
    unidades: 37,
    precio: 173,
    completo: 'Incredible Frozen Shirt - basico',
    empresa: 'Hawaiian Holdings',
    total: 6401
  },
  {
    unidades: 39,
    precio: 241,
    completo: 'Intelligent Plastic Bike - medio',
    empresa: 'Tractor Supply',
    total: 9399
  },
  {
    unidades: 47,
    precio: 131,
    completo: 'Sleek Steel Chicken - avanzado',
    empresa: 'Mondelez International',
    total: 6157
  },
  {
    unidades: 27,
    precio: 304,
    completo: 'Handcrafted Granite Cheese - medio',
    empresa: 'Lennar',
    total: 8208
  },
  {
    unidades: 33,
    precio: 69,
    completo: 'Unbranded Soft Computer - medio',
    empresa: 'Delta Tucker Holdings',
    total: 2277
  },
  {
    unidades: 41,
    precio: 284,
    completo: 'Unbranded Soft Table - avanzado',
    empresa: 'Motorola Solutions',
    total: 11644
  },
  {
    unidades: 63,
    precio: 320,
    completo: 'Handcrafted Metal Tuna - medio',
    empresa: 'Williams-Sonoma',
    total: 20160
  },
  {
    unidades: 68,
    precio: 68,
    completo: 'Sleek Soft Towels - medio',
    empresa: 'Alere',
    total: 4624
  },
  {
    unidades: 43,
    precio: 25,
    completo: 'Practical Cotton Keyboard - medio',
    empresa: 'AutoNation',
    total: 1075
  },
  {
    unidades: 89,
    precio: 16,
    completo: 'Small Rubber Pants - basico',
    empresa: 'Hanesbrands',
    total: 1424
  },
  {
    unidades: 82,
    precio: 70,
    completo: 'Generic Concrete Hat - basico',
    empresa: 'American Tire Distributors Holdings',
    total: 5740
  },
  {
    unidades: 40,
    precio: 110,
    completo: 'Sleek Frozen Hat - basico',
    empresa: 'Pool',
    total: 4400
  },
  {
    unidades: 73,
    precio: 331,
    completo: 'Rustic Soft Table - medio',
    empresa: 'Werner Enterprises',
    total: 24163
  },
  {
    unidades: 35,
    precio: 18,
    completo: 'Awesome Soft Gloves - avanzado',
    empresa: 'Anthem',
    total: 630
  },
  {
    unidades: 69,
    precio: 16,
    completo: 'Generic Fresh Keyboard - medio',
    empresa: 'WestRock',
    total: 1104
  },
  {
    unidades: 39,
    precio: 257,
    completo: 'Rustic Steel Shoes - basico',
    empresa: 'Universal American',
    total: 10023
  },
  {
    unidades: 56,
    precio: 208,
    completo: 'Handmade Soft Chips - medio',
    empresa: 'State Farm Insurance Cos.',
    total: 11648
  },
  {
    unidades: 74,
    precio: 92,
    completo: 'Licensed Granite Ball - medio',
    empresa: 'SunPower',
    total: 6808
  },
  {
    unidades: 36,
    precio: 236,
    completo: 'Sleek Steel Ball - avanzado',
    empresa: 'TransDigm Group',
    total: 8496
  },
  {
    unidades: 50,
    precio: 77,
    completo: 'Sleek Frozen Table - avanzado',
    empresa: 'Archrock',
    total: 3850
  },
  {
    unidades: 78,
    precio: 103,
    completo: 'Fantastic Soft Pants - basico',
    empresa: 'TEGNA',
    total: 8034
  },
  {
    unidades: 56,
    precio: 277,
    completo: 'Awesome Cotton Cheese - basico',
    empresa: 'HealthSouth',
    total: 15512
  },
  {
    unidades: 16,
    precio: 141,
    completo: 'Intelligent Metal Bike - avanzado',
    empresa: 'Core-Mark Holding',
    total: 2256
  },
  {
    unidades: 52,
    precio: 81,
    completo: 'Refined Plastic Hat - basico',
    empresa: "Wendy's",
    total: 4212
  },
  {
    unidades: 21,
    precio: 68,
    completo: 'Licensed Concrete Soap - basico',
    empresa: 'First Solar',
    total: 1428
  },
  {
    unidades: 0,
    precio: 305,
    completo: 'Practical Frozen Chips - medio',
    empresa: 'Delta Air Lines',
    total: 0
  },
  {
    unidades: 13,
    precio: 85,
    completo: 'Handmade Frozen Salad - medio',
    empresa: 'Nordstrom',
    total: 1105
  },
  {
    unidades: 96,
    precio: 38,
    completo: 'Licensed Plastic Hat - medio',
    empresa: 'Best Buy',
    total: 3648
  },
  {
    unidades: 25,
    precio: 85,
    completo: 'Ergonomic Metal Hat - basico',
    empresa: 'Kar Auction Services',
    total: 2125
  },
  {
    unidades: 33,
    precio: 125,
    completo: 'Awesome Frozen Shoes - medio',
    empresa: 'Comerica',
    total: 4125
  },
  {
    unidades: 46,
    precio: 43,
    completo: 'Small Metal Tuna - medio',
    empresa: 'Raymond James Financial',
    total: 1978
  },
  {
    unidades: 3,
    precio: 111,
    completo: 'Intelligent Frozen Sausages - basico',
    empresa: 'A.O. Smith',
    total: 333
  },
  {
    unidades: 84,
    precio: 77,
    completo: 'Generic Metal Sausages - medio',
    empresa: 'DST Systems',
    total: 6468
  },
  {
    unidades: 69,
    precio: 331,
    completo: 'Practical Fresh Fish - avanzado',
    empresa: 'Hartford Financial Services Group',
    total: 22839
  },
  {
    unidades: 57,
    precio: 49,
    completo: 'Refined Concrete Shirt - basico',
    empresa: 'Simon Property Group',
    total: 2793
  },
  {
    unidades: 43,
    precio: 250,
    completo: 'Practical Frozen Salad - basico',
    empresa: 'Nasdaq OMX Group',
    total: 10750
  },
  {
    unidades: 82,
    precio: 33,
    completo: 'Sleek Rubber Keyboard - basico',
    empresa: 'Alere',
    total: 2706
  },
  {
    unidades: 10,
    precio: 94,
    completo: 'Ergonomic Steel Fish - avanzado',
    empresa: 'HCA Holdings',
    total: 940
  },
  {
    unidades: 5,
    precio: 24,
    completo: 'Rustic Plastic Mouse - avanzado',
    empresa: 'Orbital ATK',
    total: 120
  },
  {
    unidades: 39,
    precio: 285,
    completo: 'Awesome Cotton Mouse - basico',
    empresa: 'Telephone & Data Systems',
    total: 11115
  },
  {
    unidades: 19,
    precio: 93,
    completo: 'Intelligent Soft Towels - avanzado',
    empresa: 'Ascena Retail Group',
    total: 1767
  },
  {
    unidades: 96,
    precio: 336,
    completo: 'Incredible Concrete Fish - medio',
    empresa: 'Darling Ingredients',
    total: 32256
  },
  {
    unidades: 5,
    precio: 129,
    completo: 'Fantastic Metal Pants - basico',
    empresa: 'OneMain Holdings',
    total: 645
  },
  {
    unidades: 26,
    precio: 164,
    completo: 'Handcrafted Granite Chicken - medio',
    empresa: 'Comcast',
    total: 4264
  }
]
```

##### 9. Ordena el resultado por el campo “total”
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $project: {
                _id: 0,
                completo: { $concat: ["$nombre", " - ", "$tipo"] },
                unidades: 1,
                precio: 1,
                empresa: "$fabricante",
                total: { $multiply: ["$precio", "$unidades"] }
            }
        },
        {
            $sort: { total: 1 } 
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    unidades: 0,
    precio: 94,
    completo: 'Ergonomic Metal Table - avanzado',
    empresa: 'Kelly Services',
    total: 0
  },
  {
    unidades: 0,
    precio: 305,
    completo: 'Practical Frozen Chips - medio',
    empresa: 'Delta Air Lines',
    total: 0
  },
  {
    unidades: 5,
    precio: 24,
    completo: 'Rustic Plastic Mouse - avanzado',
    empresa: 'Orbital ATK',
    total: 120
  },
  {
    unidades: 3,
    precio: 111,
    completo: 'Intelligent Frozen Sausages - basico',
    empresa: 'A.O. Smith',
    total: 333
  },
  {
    unidades: 35,
    precio: 18,
    completo: 'Awesome Soft Gloves - avanzado',
    empresa: 'Anthem',
    total: 630
  },
  {
    unidades: 5,
    precio: 129,
    completo: 'Fantastic Metal Pants - basico',
    empresa: 'OneMain Holdings',
    total: 645
  },
  {
    unidades: 10,
    precio: 94,
    completo: 'Ergonomic Steel Fish - avanzado',
    empresa: 'HCA Holdings',
    total: 940
  },
  {
    unidades: 43,
    precio: 25,
    completo: 'Practical Cotton Keyboard - medio',
    empresa: 'AutoNation',
    total: 1075
  },
  {
    unidades: 69,
    precio: 16,
    completo: 'Generic Fresh Keyboard - medio',
    empresa: 'WestRock',
    total: 1104
  },
  {
    unidades: 13,
    precio: 85,
    completo: 'Handmade Frozen Salad - medio',
    empresa: 'Nordstrom',
    total: 1105
  },
  {
    unidades: 5,
    precio: 246,
    completo: 'Ergonomic Metal Ball - medio',
    empresa: 'Seaboard',
    total: 1230
  },
  {
    unidades: 18,
    precio: 76,
    completo: 'Tasty Wooden Ball - basico',
    empresa: 'State Farm Insurance Cos.',
    total: 1368
  },
  {
    unidades: 89,
    precio: 16,
    completo: 'Small Rubber Pants - basico',
    empresa: 'Hanesbrands',
    total: 1424
  },
  {
    unidades: 21,
    precio: 68,
    completo: 'Licensed Concrete Soap - basico',
    empresa: 'First Solar',
    total: 1428
  },
  {
    unidades: 45,
    precio: 37,
    completo: 'Small Steel Gloves - avanzado',
    empresa: 'TrueBlue',
    total: 1665
  },
  {
    unidades: 19,
    precio: 93,
    completo: 'Intelligent Soft Towels - avanzado',
    empresa: 'Ascena Retail Group',
    total: 1767
  },
  {
    unidades: 7,
    precio: 253,
    completo: 'Handmade Plastic Hat - medio',
    empresa: "Dick's Sporting Goods",
    total: 1771
  },
  {
    unidades: 46,
    precio: 43,
    completo: 'Small Metal Tuna - medio',
    empresa: 'Raymond James Financial',
    total: 1978
  },
  {
    unidades: 25,
    precio: 85,
    completo: 'Ergonomic Metal Hat - basico',
    empresa: 'Kar Auction Services',
    total: 2125
  },
  {
    unidades: 16,
    precio: 141,
    completo: 'Intelligent Metal Bike - avanzado',
    empresa: 'Core-Mark Holding',
    total: 2256
  },
  {
    unidades: 33,
    precio: 69,
    completo: 'Unbranded Soft Computer - medio',
    empresa: 'Delta Tucker Holdings',
    total: 2277
  },
  {
    unidades: 15,
    precio: 180,
    completo: 'Refined Concrete Bike - basico',
    empresa: 'Trinity Industries',
    total: 2700
  },
  {
    unidades: 82,
    precio: 33,
    completo: 'Sleek Rubber Keyboard - basico',
    empresa: 'Alere',
    total: 2706
  },
  {
    unidades: 41,
    precio: 67,
    completo: 'Practical Soft Pants - avanzado',
    empresa: 'Hyatt Hotels',
    total: 2747
  },
  {
    unidades: 57,
    precio: 49,
    completo: 'Refined Concrete Shirt - basico',
    empresa: 'Simon Property Group',
    total: 2793
  },
  {
    unidades: 68,
    precio: 52,
    completo: 'Tasty Cotton Pants - basico',
    empresa: 'Cabot',
    total: 3536
  },
  {
    unidades: 96,
    precio: 38,
    completo: 'Licensed Plastic Hat - medio',
    empresa: 'Best Buy',
    total: 3648
  },
  {
    unidades: 50,
    precio: 77,
    completo: 'Sleek Frozen Table - avanzado',
    empresa: 'Archrock',
    total: 3850
  },
  {
    unidades: 33,
    precio: 125,
    completo: 'Awesome Frozen Shoes - medio',
    empresa: 'Comerica',
    total: 4125
  },
  {
    unidades: 52,
    precio: 81,
    completo: 'Refined Plastic Hat - basico',
    empresa: "Wendy's",
    total: 4212
  },
  {
    unidades: 26,
    precio: 164,
    completo: 'Handcrafted Granite Chicken - medio',
    empresa: 'Comcast',
    total: 4264
  },
  {
    unidades: 40,
    precio: 110,
    completo: 'Sleek Frozen Hat - basico',
    empresa: 'Pool',
    total: 4400
  },
  {
    unidades: 16,
    precio: 282,
    completo: 'Handcrafted Soft Gloves - basico',
    empresa: 'Pep Boys-Mann',
    total: 4512
  },
  {
    unidades: 68,
    precio: 68,
    completo: 'Sleek Soft Towels - medio',
    empresa: 'Alere',
    total: 4624
  },
  {
    unidades: 40,
    precio: 126,
    completo: 'Small Concrete Fish - medio',
    empresa: 'Precision Castparts',
    total: 5040
  },
  {
    unidades: 16,
    precio: 337,
    completo: 'Handmade Steel Chair - medio',
    empresa: 'CIT Group',
    total: 5392
  },
  {
    unidades: 82,
    precio: 70,
    completo: 'Generic Concrete Hat - basico',
    empresa: 'American Tire Distributors Holdings',
    total: 5740
  },
  {
    unidades: 47,
    precio: 131,
    completo: 'Sleek Steel Chicken - avanzado',
    empresa: 'Mondelez International',
    total: 6157
  },
  {
    unidades: 55,
    precio: 113,
    completo: 'Handcrafted Steel Chicken - medio',
    empresa: 'State Street Corp.',
    total: 6215
  },
  {
    unidades: 37,
    precio: 173,
    completo: 'Incredible Frozen Shirt - basico',
    empresa: 'Hawaiian Holdings',
    total: 6401
  },
  {
    unidades: 84,
    precio: 77,
    completo: 'Generic Metal Sausages - medio',
    empresa: 'DST Systems',
    total: 6468
  },
  {
    unidades: 35,
    precio: 190,
    completo: 'Practical Metal Mouse - basico',
    empresa: 'National Oilwell Varco',
    total: 6650
  },
  {
    unidades: 74,
    precio: 92,
    completo: 'Licensed Granite Ball - medio',
    empresa: 'SunPower',
    total: 6808
  },
  {
    unidades: 78,
    precio: 103,
    completo: 'Fantastic Soft Pants - basico',
    empresa: 'TEGNA',
    total: 8034
  },
  {
    unidades: 27,
    precio: 304,
    completo: 'Handcrafted Granite Cheese - medio',
    empresa: 'Lennar',
    total: 8208
  },
  {
    unidades: 40,
    precio: 212,
    completo: 'Refined Wooden Tuna - avanzado',
    empresa: 'WGL Holdings',
    total: 8480
  },
  {
    unidades: 36,
    precio: 236,
    completo: 'Sleek Steel Ball - avanzado',
    empresa: 'TransDigm Group',
    total: 8496
  },
  {
    unidades: 39,
    precio: 241,
    completo: 'Intelligent Plastic Bike - medio',
    empresa: 'Tractor Supply',
    total: 9399
  },
  {
    unidades: 53,
    precio: 178,
    completo: 'Unbranded Soft Fish - basico',
    empresa: 'Total System Services',
    total: 9434
  },
  {
    unidades: 39,
    precio: 257,
    completo: 'Rustic Steel Shoes - basico',
    empresa: 'Universal American',
    total: 10023
  },
  {
    unidades: 43,
    precio: 250,
    completo: 'Practical Frozen Salad - basico',
    empresa: 'Nasdaq OMX Group',
    total: 10750
  },
  {
    unidades: 39,
    precio: 285,
    completo: 'Awesome Cotton Mouse - basico',
    empresa: 'Telephone & Data Systems',
    total: 11115
  },
  {
    unidades: 90,
    precio: 129,
    completo: 'Refined Concrete Salad - avanzado',
    empresa: 'Universal Health Services',
    total: 11610
  },
  {
    unidades: 41,
    precio: 284,
    completo: 'Unbranded Soft Table - avanzado',
    empresa: 'Motorola Solutions',
    total: 11644
  },
  {
    unidades: 56,
    precio: 208,
    completo: 'Handmade Soft Chips - medio',
    empresa: 'State Farm Insurance Cos.',
    total: 11648
  },
  {
    unidades: 49,
    precio: 265,
    completo: 'Fantastic Concrete Salad - basico',
    empresa: 'Kar Auction Services',
    total: 12985
  },
  {
    unidades: 63,
    precio: 238,
    completo: 'Ergonomic Wooden Shirt - avanzado',
    empresa: 'Securian Financial Group',
    total: 14994
  },
  {
    unidades: 65,
    precio: 233,
    completo: 'Licensed Fresh Chicken - basico',
    empresa: 'Kemper',
    total: 15145
  },
  {
    unidades: 56,
    precio: 277,
    completo: 'Awesome Cotton Cheese - basico',
    empresa: 'HealthSouth',
    total: 15512
  },
  {
    unidades: 96,
    precio: 189,
    completo: 'Small Soft Fish - medio',
    empresa: 'Primoris Services',
    total: 18144
  },
  {
    unidades: 66,
    precio: 279,
    completo: 'Rustic Concrete Pants - medio',
    empresa: 'Mercury General',
    total: 18414
  },
  {
    unidades: 63,
    precio: 320,
    completo: 'Handcrafted Metal Tuna - medio',
    empresa: 'Williams-Sonoma',
    total: 20160
  },
  {
    unidades: 71,
    precio: 290,
    completo: 'Incredible Granite Gloves - avanzado',
    empresa: 'Oneok',
    total: 20590
  },
  {
    unidades: 69,
    precio: 331,
    completo: 'Practical Fresh Fish - avanzado',
    empresa: 'Hartford Financial Services Group',
    total: 22839
  },
  {
    unidades: 73,
    precio: 331,
    completo: 'Rustic Soft Table - medio',
    empresa: 'Werner Enterprises',
    total: 24163
  },
  {
    unidades: 95,
    precio: 291,
    completo: 'Fantastic Wooden Fish - avanzado',
    empresa: 'Kimberly-Clark',
    total: 27645
  },
  {
    unidades: 96,
    precio: 336,
    completo: 'Incredible Concrete Fish - medio',
    empresa: 'Darling Ingredients',
    total: 32256
  }
]
```

##### 10. Haciendo una nueva consulta, averiguar el numero de productos por tipo de producto
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $group: {
                _id: "$tipo",
                totalProductos: { $sum: 1 }
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  { _id: 'basico', totalProductos: 24 },
  { _id: 'avanzado', totalProductos: 18 },
  { _id: 'medio', totalProductos: 25 }
]
```

##### 11. Añadir el valor mayor y el menor
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $group: {
                _id: "$tipo",
                totalProductos: { $sum: 1 },
                maxProductos: { $max: "$unidades" },
                minProductos: { $min: "$unidades" }
            }
        },
        {
            $project: {
                _id: 0,
                tipo: "$_id",
                totalProductos: 1,
                maxProductos: 1,
                minProductos: 1
            }
        }
    ])
```
##### `Salida:`
```javascript
db.productos.aggregate([
        {
            $group: {
                _id: "$tipo",
                totalProductos: { $sum: 1 },
                maxProductos: { $max: "$unidades" },
                minProductos: { $min: "$unidades" }
            }
        },
        {
            $project: {
                _id: 0,
                tipo: "$_id",
                totalProductos: 1,
                maxProductos: 1,
                minProductos: 1
            }
        }
    ])
```

##### 12. CAñade el total de unidades por cada tipo
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
            $group: {
                _id: "$tipo",
                totalProductos: { $sum: 1 },
                totalUnidades: { $sum: "$unidades" },
                maxProductos: { $max: "$unidades" },
                minProductos: { $min: "$unidades" }
            }
        },
        {
            $project: {
                _id: 0,
                tipo: "$_id",
                totalProductos: 1,
                totalUnidades: 1,
                maxProductos: 1,
                minProductos: 1
            }
        }
    ])
```
##### `Salida:`
```javascript
[
  {
    totalProductos: 25,
    totalUnidades: 1224,
    maxProductos: 96,
    minProductos: 0,
    tipo: 'medio'
  },
  {
    totalProductos: 18,
    totalUnidades: 773,
    maxProductos: 95,
    minProductos: 0,
    tipo: 'avanzado'
  },
  {
    totalProductos: 24,
    totalUnidades: 1067,
    maxProductos: 89,
    minProductos: 3,
    tipo: 'basico'
  }
]
```

##### 13. Con el operador $set y el operador “$substr” visualiza todos los datos del producto "Small Metal Tuna" y los primeros 5 caracteres del nombre
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
          $match: {
            nombre: "Small Metal Tuna"
          }
        },
        {
          $set: {
            primeros_5_caracteres_nombre: { $substr: ["$nombre", 0, 5] }
          }
        }
      ])
```
##### `Salida:`
```javascript
[
  {
    _id: ObjectId('66161a80528a3931e07583c1'),
    codigo: 55,
    nombre: 'Small Metal Tuna',
    unidades: 46,
    precio: 43,
    fabricante: 'Raymond James Financial',
    tipo: 'medio',
    primeros_5_caracteres_nombre: 'Small'
  }
]
```

##### 14. Creamos una salida que tenga el nombre del articulo y el total (precio por unidades) y lo guardamos en una colección denominada productos2
###### `Consulta:` 
```javascript
db.productos.aggregate([
        {
          $project: {
            nombre: 1,
            total: { $multiply: ["$precio", "$unidades"] }
          }
        },
        {
          $out: "productos2"
        }
      ])
```
##### `Salida:`
```javascript

```
##### 15. Comprobamos que se ha creado
###### `Consulta:` 
```javascript
show collections
```
##### `Salida:`
```javascript
productos
productos2
```
##### 16. Hacemos un find para comprobar el resultado
###### `Consulta:` 
```javascript
db.productos2.find()
```
##### `Salida:`
```javascript
[
  {
    _id: ObjectId('66161a80528a3931e075838c'),
    nombre: 'Small Soft Fish',
    total: 18144
  },
  {
    _id: ObjectId('66161a80528a3931e075838d'),
    nombre: 'Rustic Concrete Pants',
    total: 18414
  },
  {
    _id: ObjectId('66161a80528a3931e075838e'),
    nombre: 'Fantastic Wooden Fish',
    total: 27645
  },
  {
    _id: ObjectId('66161a80528a3931e075838f'),
    nombre: 'Small Steel Gloves',
    total: 1665
  },
  {
    _id: ObjectId('66161a80528a3931e0758390'),
    nombre: 'Ergonomic Metal Ball',
    total: 1230
  },
  {
    _id: ObjectId('66161a80528a3931e0758391'),
    nombre: 'Handmade Steel Chair',
    total: 5392
  },
  {
    _id: ObjectId('66161a80528a3931e0758392'),
    nombre: 'Handcrafted Soft Gloves',
    total: 4512
  },
  {
    _id: ObjectId('66161a80528a3931e0758393'),
    nombre: 'Ergonomic Wooden Shirt',
    total: 14994
  },
  {
    _id: ObjectId('66161a80528a3931e0758394'),
    nombre: 'Practical Soft Pants',
    total: 2747
  },
  {
    _id: ObjectId('66161a80528a3931e0758395'),
    nombre: 'Fantastic Concrete Salad',
    total: 12985
  },
  {
    _id: ObjectId('66161a80528a3931e0758396'),
    nombre: 'Handmade Plastic Hat',
    total: 1771
  },
  {
    _id: ObjectId('66161a80528a3931e0758397'),
    nombre: 'Unbranded Soft Fish',
    total: 9434
  },
  {
    _id: ObjectId('66161a80528a3931e0758398'),
    nombre: 'Small Concrete Fish',
    total: 5040
  },
  {
    _id: ObjectId('66161a80528a3931e0758399'),
    nombre: 'Refined Concrete Salad',
    total: 11610
  },
  {
    _id: ObjectId('66161a80528a3931e075839a'),
    nombre: 'Refined Concrete Bike',
    total: 2700
  },
  {
    _id: ObjectId('66161a80528a3931e075839b'),
    nombre: 'Tasty Cotton Pants',
    total: 3536
  },
  {
    _id: ObjectId('66161a80528a3931e075839c'),
    nombre: 'Incredible Granite Gloves',
    total: 20590
  },
  {
    _id: ObjectId('66161a80528a3931e075839d'),
    nombre: 'Practical Metal Mouse',
    total: 6650
  },
  {
    _id: ObjectId('66161a80528a3931e075839e'),
    nombre: 'Handcrafted Steel Chicken',
    total: 6215
  },
  {
    _id: ObjectId('66161a80528a3931e075839f'),
    nombre: 'Refined Wooden Tuna',
    total: 8480
  },
  {
    _id: ObjectId('66161a80528a3931e07583a0'),
    nombre: 'Ergonomic Metal Table',
    total: 0
  },
  {
    _id: ObjectId('66161a80528a3931e07583a1'),
    nombre: 'Tasty Wooden Ball',
    total: 1368
  },
  {
    _id: ObjectId('66161a80528a3931e07583a2'),
    nombre: 'Licensed Fresh Chicken',
    total: 15145
  },
  {
    _id: ObjectId('66161a80528a3931e07583a3'),
    nombre: 'Incredible Frozen Shirt',
    total: 6401
  },
  {
    _id: ObjectId('66161a80528a3931e07583a4'),
    nombre: 'Intelligent Plastic Bike',
    total: 9399
  },
  {
    _id: ObjectId('66161a80528a3931e07583a5'),
    nombre: 'Sleek Steel Chicken',
    total: 6157
  },
  {
    _id: ObjectId('66161a80528a3931e07583a6'),
    nombre: 'Handcrafted Granite Cheese',
    total: 8208
  },
  {
    _id: ObjectId('66161a80528a3931e07583a7'),
    nombre: 'Unbranded Soft Computer',
    total: 2277
  },
  {
    _id: ObjectId('66161a80528a3931e07583a8'),
    nombre: 'Unbranded Soft Table',
    total: 11644
  },
  {
    _id: ObjectId('66161a80528a3931e07583a9'),
    nombre: 'Handcrafted Metal Tuna',
    total: 20160
  },
  {
    _id: ObjectId('66161a80528a3931e07583aa'),
    nombre: 'Sleek Soft Towels',
    total: 4624
  },
  {
    _id: ObjectId('66161a80528a3931e07583ab'),
    nombre: 'Practical Cotton Keyboard',
    total: 1075
  },
  {
    _id: ObjectId('66161a80528a3931e07583ac'),
    nombre: 'Small Rubber Pants',
    total: 1424
  },
  {
    _id: ObjectId('66161a80528a3931e07583ad'),
    nombre: 'Generic Concrete Hat',
    total: 5740
  },
  {
    _id: ObjectId('66161a80528a3931e07583ae'),
    nombre: 'Sleek Frozen Hat',
    total: 4400
  },
  {
    _id: ObjectId('66161a80528a3931e07583af'),
    nombre: 'Rustic Soft Table',
    total: 24163
  },
  {
    _id: ObjectId('66161a80528a3931e07583b0'),
    nombre: 'Awesome Soft Gloves',
    total: 630
  },
  {
    _id: ObjectId('66161a80528a3931e07583b1'),
    nombre: 'Generic Fresh Keyboard',
    total: 1104
  },
  {
    _id: ObjectId('66161a80528a3931e07583b2'),
    nombre: 'Rustic Steel Shoes',
    total: 10023
  },
  {
    _id: ObjectId('66161a80528a3931e07583b3'),
    nombre: 'Handmade Soft Chips',
    total: 11648
  },
  {
    _id: ObjectId('66161a80528a3931e07583b4'),
    nombre: 'Licensed Granite Ball',
    total: 6808
  },
  {
    _id: ObjectId('66161a80528a3931e07583b5'),
    nombre: 'Sleek Steel Ball',
    total: 8496
  },
  {
    _id: ObjectId('66161a80528a3931e07583b6'),
    nombre: 'Sleek Frozen Table',
    total: 3850
  },
  {
    _id: ObjectId('66161a80528a3931e07583b7'),
    nombre: 'Fantastic Soft Pants',
    total: 8034
  },
  {
    _id: ObjectId('66161a80528a3931e07583b8'),
    nombre: 'Awesome Cotton Cheese',
    total: 15512
  },
  {
    _id: ObjectId('66161a80528a3931e07583b9'),
    nombre: 'Intelligent Metal Bike',
    total: 2256
  },
  {
    _id: ObjectId('66161a80528a3931e07583ba'),
    nombre: 'Refined Plastic Hat',
    total: 4212
  },
  {
    _id: ObjectId('66161a80528a3931e07583bb'),
    nombre: 'Licensed Concrete Soap',
    total: 1428
  },
  {
    _id: ObjectId('66161a80528a3931e07583bc'),
    nombre: 'Practical Frozen Chips',
    total: 0
  },
  {
    _id: ObjectId('66161a80528a3931e07583bd'),
    nombre: 'Handmade Frozen Salad',
    total: 1105
  },
  {
    _id: ObjectId('66161a80528a3931e07583be'),
    nombre: 'Licensed Plastic Hat',
    total: 3648
  },
  {
    _id: ObjectId('66161a80528a3931e07583bf'),
    nombre: 'Ergonomic Metal Hat',
    total: 2125
  },
  {
    _id: ObjectId('66161a80528a3931e07583c0'),
    nombre: 'Awesome Frozen Shoes',
    total: 4125
  },
  {
    _id: ObjectId('66161a80528a3931e07583c1'),
    nombre: 'Small Metal Tuna',
    total: 1978
  },
  {
    _id: ObjectId('66161a80528a3931e07583c2'),
    nombre: 'Intelligent Frozen Sausages',
    total: 333
  },
  {
    _id: ObjectId('66161a80528a3931e07583c3'),
    nombre: 'Generic Metal Sausages',
    total: 6468
  },
  {
    _id: ObjectId('66161a80528a3931e07583c4'),
    nombre: 'Practical Fresh Fish',
    total: 22839
  },
  {
    _id: ObjectId('66161a80528a3931e07583c5'),
    nombre: 'Refined Concrete Shirt',
    total: 2793
  },
  {
    _id: ObjectId('66161a80528a3931e07583c6'),
    nombre: 'Practical Frozen Salad',
    total: 10750
  },
  {
    _id: ObjectId('66161a80528a3931e07583c7'),
    nombre: 'Sleek Rubber Keyboard',
    total: 2706
  },
  {
    _id: ObjectId('66161a80528a3931e07583c8'),
    nombre: 'Ergonomic Steel Fish',
    total: 940
  },
  {
    _id: ObjectId('66161a80528a3931e07583c9'),
    nombre: 'Rustic Plastic Mouse',
    total: 120
  },
  {
    _id: ObjectId('66161a80528a3931e07583ca'),
    nombre: 'Awesome Cotton Mouse',
    total: 11115
  },
  {
    _id: ObjectId('66161a80528a3931e07583cb'),
    nombre: 'Intelligent Soft Towels',
    total: 1767
  },
  {
    _id: ObjectId('66161a80528a3931e07583cc'),
    nombre: 'Incredible Concrete Fish',
    total: 32256
  },
  {
    _id: ObjectId('66161a80528a3931e07583cd'),
    nombre: 'Fantastic Metal Pants',
    total: 645
  },
  {
    _id: ObjectId('66161a80528a3931e07583ce'),
    nombre: 'Handcrafted Granite Chicken',
    total: 4264
  }
]
```
