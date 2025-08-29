; ================================
; Definición de plantillas
; ================================
(deftemplate perfil-lector
  (slot tipo-personajes)
  (slot genero)
  (slot dificultad)
  (slot tipo-paginas))

(deftemplate recomendacion
  (slot tipo)
  (multislot contenido))

; ================================
; Regla 1: Coincidencia exacta
; ================================
(defrule recomendar-segun-perfil-completo
  (perfil-lector (tipo-personajes ?tp)
                 (genero ?g)
                 (dificultad ?d)
                 (tipo-paginas ?pg&~indiferente))
  (exists (libro (trama ?tp) (genero ?g) (dificultad ?d) (paginas ?pg)))
  =>
  (assert (recomendacion (tipo titulo)
                         (contenido "Aquí tienes un libro que coincide exactamente con tu perfil de lector:")))
  (do-for-all-facts ((?libro libro))
    (if (and (eq ?libro:trama ?tp)
             (eq ?libro:genero ?g)
             (eq ?libro:dificultad ?d)
             (eq ?libro:paginas ?pg))
    then
      (assert (recomendacion
               (tipo libro)
               (contenido (str-cat "📚 Recomendación: " ?libro:nombre " por " ?libro:autor
                                    " (Calificación " ?libro:calificacion ")")))))))

; ================================
; Regla 2: Coincidencia parcial (género + personajes)
; ================================
(defrule recomendar-alternativa-por-genero-y-personajes
  (perfil-lector (tipo-personajes ?tp)
                 (genero ?g)
                 (dificultad ?d)
                 (tipo-paginas ?pg&~indiferente))
  (not (exists (libro (trama ?tp) (genero ?g) (dificultad ?d) (paginas ?pg))))
  (exists (libro (trama ?tp) (genero ?g) (paginas ?pg)))
  =>
  (assert (recomendacion (tipo titulo)
                         (contenido "No encontramos un libro exacto, pero aquí tienes opciones del mismo género con tu preferencia de personajes y tipo de páginas:")))
  (do-for-all-facts ((?libro libro))
    (if (and (eq ?libro:trama ?tp)
             (eq ?libro:genero ?g)
             (eq ?libro:paginas ?pg))
    then
      (assert (recomendacion
               (tipo libro)
               (contenido (str-cat "📚 Recomendación: " ?libro:nombre " por " ?libro:autor
                                    " (Dificultad " ?libro:dificultad ")")))))))

; ================================
; Regla 3: Coincidencia parcial solo por personajes
; ================================
(defrule recomendar-alternativa-general
  (perfil-lector (tipo-personajes ?tp)
                 (genero ?g)
                 (dificultad ?d)
                 (tipo-paginas ?pg&~indiferente))
  (not (exists (libro (trama ?tp) (genero ?g) (paginas ?pg))))
  =>
  (assert (recomendacion (tipo titulo)
                         (contenido "No encontramos coincidencias completas, pero aquí tienes opciones basadas en tu preferencia de personajes:")))
  (do-for-all-facts ((?libro libro))
    (if (eq ?libro:trama ?tp)
    then
      (assert (recomendacion
               (tipo libro)
               (contenido (str-cat "📚 Recomendación: " ?libro:nombre " por " ?libro:autor
                                    " (" ?libro:genero " - " ?libro:dificultad ")")))))))

; ================================
; Regla 4: Coincidencia solo por género
; ================================
(defrule recomendar-por-genero
  (perfil-lector (genero ?g)
                 (tipo-paginas ?pg&~indiferente))
  (not (exists (libro (trama ?tp) (genero ?g) (paginas ?pg))))
  (exists (libro (genero ?g)))
  =>
  (assert (recomendacion (tipo titulo)
                         (contenido "No encontramos coincidencias por personajes, pero sí por género:")))
  (do-for-all-facts ((?libro libro))
    (if (eq ?libro:genero ?g)
    then
      (assert (recomendacion
               (tipo libro)
               (contenido (str-cat "📚 Recomendación: " ?libro:nombre " por " ?libro:autor
                                    " (Dificultad " ?libro:dificultad ")")))))))

; ================================
; Regla 5: Coincidencia solo por tipo de páginas
; ================================
(defrule recomendar-por-paginas
  (perfil-lector (tipo-paginas ?pg&~indiferente))
  (not (exists (libro (trama ?tp) (genero ?g) (paginas ?pg))))
  (exists (libro (paginas ?pg)))
  =>
  (assert (recomendacion (tipo titulo)
                         (contenido "No encontramos coincidencias por personajes o género, pero aquí hay libros según tu preferencia de páginas:")))
  (do-for-all-facts ((?libro libro))
    (if (eq ?libro:paginas ?pg)
    then
      (assert (recomendacion
               (tipo libro)
               (contenido (str-cat "📚 Recomendación: " ?libro:nombre " por " ?libro:autor
                                    " (" ?libro:genero " - " ?libro:dificultad ")")))))))
