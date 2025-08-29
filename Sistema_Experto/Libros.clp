(deftemplate libro
  (slot nombre)
  (slot autor)
  (slot genero)
  (slot dificultad)
  (slot anio)
  (slot calificacion)
  (slot trama)
  (slot paginas) ; nuevo slot: pocas o muchas
)

(deffacts libros-base
  (libro (nombre "El Hobbit") (autor "J.R.R. Tolkien") (genero fantasia) (dificultad media)
         (anio 1937) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "Sherlock Holmes") (autor "Arthur Conan Doyle") (genero misterio) (dificultad media)
         (anio 1887) (calificacion 8) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "El Principito") (autor "Antoine de Saint-Exupery") (genero fantasia) (dificultad baja)
         (anio 1943) (calificacion 10) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "Cien Anos de Soledad") (autor "Gabriel Garcia Marquez") (genero realismo-magico) (dificultad alta)
         (anio 1967) (calificacion 10) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "La Sombra del Viento") (autor "Carlos Ruiz Zafon") (genero misterio) (dificultad alta)
         (anio 2001) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "Harry Potter y la piedra filosofal") (autor "J.K. Rowling") (genero fantasia) (dificultad baja)
         (anio 1997) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "Don Quijote de la Mancha") (autor "Miguel de Cervantes") (genero ficcion-clasica) (dificultad alta)
         (anio 1605) (calificacion 10) (trama pocos-personajes) (paginas muchas))

  (libro (nombre "Un Mundo Feliz") (autor "Aldous Huxley") (genero ciencia-ficcion) (dificultad media)
         (anio 1932) (calificacion 9) (trama muchos-personajes) (paginas pocas))

  (libro (nombre "1984") (autor "George Orwell") (genero ciencia-ficcion) (dificultad alta)
         (anio 1949) (calificacion 10) (trama pocos-personajes) (paginas muchas))

  (libro (nombre "Frankenstein") (autor "Mary Shelley") (genero terror) (dificultad media)
         (anio 1818) (calificacion 8) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "El Amor en los Tiempos del Colera") (autor "Gabriel Garcia Marquez") (genero realismo-magico) (dificultad alta)
         (anio 1985) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "La metamorfosis") (autor "Franz Kafka") (genero ficcion-absurda) (dificultad media)
         (anio 1915) (calificacion 8) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "Orgullo y Prejuicio") (autor "Jane Austen") (genero romance-historico) (dificultad baja)
         (anio 1813) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "Dune") (autor "Frank Herbert") (genero ciencia-ficcion) (dificultad alta)
         (anio 1965) (calificacion 9) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "El misterio del cuarto amarillo") (autor "Gaston Leroux") (genero misterio) (dificultad baja)
         (anio 1907) (calificacion 7) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "Los juegos del hambre") (autor "Suzanne Collins") (genero ciencia-ficcion) (dificultad baja)
         (anio 2008) (calificacion 8) (trama muchos-personajes) (paginas muchas))

  (libro (nombre "Siddhartha") (autor "Hermann Hesse") (genero ficcion-filosofica) (dificultad media)
         (anio 1922) (calificacion 9) (trama pocos-personajes) (paginas pocas))

  (libro (nombre "Fahrenheit 451") (autor "Ray Bradbury") (genero ciencia-ficcion) (dificultad media)
         (anio 1953) (calificacion 9) (trama pocos-personajes) (paginas pocas))
)
