import streamlit as st
from clips import Environment
import io
import sys
import unicodedata

# ==================================
# Función para normalizar texto
# ==================================
def normalize_text(text):
    """
    Convierte texto a minúsculas, sin tildes y con guiones en vez de espacios.
    Ejemplo: "Ciencia Ficción" -> "ciencia-ficcion"
    """
    text = text.strip().lower()
    text = unicodedata.normalize("NFD", text)
    text = text.encode("ascii", "ignore").decode("utf-8")
    return text.replace(" ", "-")

# ==================================
# Configuración del entorno CLIPS
# ==================================
@st.cache_resource
def load_clips_environment():
    env = Environment()
    env.clear()
    try:
        env.load("Libros.clp")
        env.load("reglas.clp")
        env.reset()
    except Exception as e:
        st.error(f"Error cargando archivos CLP: {e}")
        return None
    return env

env = load_clips_environment()

# ==================================
# Configuración de página
# ==================================
st.set_page_config(page_title="Recomendador de Libros", layout="centered")
st.title("Sistema Experto de Recomendación de Libros 📚")
st.write("Construye tu perfil de lector y te recomendaremos un libro.")

# ==================================
# Entrada del usuario
# ==================================
st.markdown("---")
st.subheader("Tu perfil de lector")

personajes_opcion = st.selectbox(
    "¿Te gustan los libros con muchos personajes o pocos?",
    ["", "Muchos", "Pocos"]
)

genero_opcion = st.selectbox(
    "Selecciona tu género favorito:",
    ["", "fantasia", "ciencia-ficcion", "misterio", "fantasia-oscura",
     "thriller", "drama", "realismo-magico", "ficcion-clasica", "terror",
     "ficcion-absurda", "romance-historico", "ficcion-filosofica"]
)

dificultad_opcion = st.selectbox(
    "Selecciona la dificultad de lectura que prefieres:",
    ["", "Baja", "Media", "Alta"]
)

# NUEVA PREGUNTA: Preferencia de páginas
paginas_opcion = st.radio(
    "¿Prefieres libros con muchas páginas o pocas páginas?",
    ["Indiferente", "Pocas", "Muchas"]
)

# ==================================
# Procesar recomendación
# ==================================
if st.button("Obtener recomendación") and personajes_opcion and genero_opcion and dificultad_opcion:
    if env is None:
        st.stop()

    env.reset()

    # Normalización de entradas
    tipo_personajes_clp = "muchos-personajes" if personajes_opcion == "Muchos" else "pocos-personajes"
    genero_clp = normalize_text(genero_opcion)
    dificultad_clp = normalize_text(dificultad_opcion)
    paginas_clp = "indiferente" if paginas_opcion == "Indiferente" else normalize_text(paginas_opcion)

    # Asertar hecho perfil-lector con tipo-paginas incluido
    env.assert_string(
        f'(perfil-lector (tipo-personajes {tipo_personajes_clp}) '
        f'(genero {genero_clp}) '
        f'(dificultad {dificultad_clp}) '
        f'(tipo-paginas {paginas_clp}))'
    )

    # Capturar salida de CLIPS
    old_stdout = sys.stdout
    sys.stdout = captured_output = io.StringIO()
    env.run()
    sys.stdout = old_stdout

    # ==================================
    # Mostrar recomendaciones
    # ==================================
    st.markdown("---")
    st.subheader("Tu recomendación")

    recomendaciones = [fact for fact in env.facts() if fact.template.name == 'recomendacion']

    if not recomendaciones:
        st.warning("⚠️ No se encontraron recomendaciones con los criterios seleccionados.")
    else:
        st.subheader("📚 Recomendaciones encontradas:")
        for rec in recomendaciones:
            contenido = ' '.join(map(str, rec['contenido']))
            if 'tipo' in rec and rec['tipo'] == 'titulo':
                st.info(f"📖 **{contenido}**")
            else:
                st.success(f"✨ {contenido}")

    # ==================================
    # Sección de depuración
    # ==================================
    with st.expander("🔍 Ver estado del motor de CLIPS"):
        st.write("### Hechos en memoria:")
        st.code('\n'.join([str(fact) for fact in env.facts()]))
        st.write("### Reglas activadas:")
        st.code(captured_output.getvalue())
