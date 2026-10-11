# Proyecto Machine Learning: Predicción de Éxito Musical en Spotify

Proyecto educativo de Machine Learning que analiza un catálogo de **114.000 canciones de Spotify** para identificar qué factores impulsan la popularidad de una pista. El objetivo final es desarrollar un modelo capaz de predecir la popularidad (`popularity`) a partir de características acústicas (`danceability`, `energy`, `acousticness`, etc.) y metadatos.

El proyecto se desarrolla por fases metodológicas (comprensión del negocio, comprensión de datos, preparación, modelado y evaluación), y cada entrega —taller o evaluación— se organiza en su propia carpeta.

## Integrantes

- Emmanuel Chavero
- Benjamin Figueroa
- Daniel Vidal

## Estructura del proyecto

```
Proyecto Maching Learning/
├── iniciar_proyecto.bat          # Script de un click: crea el entorno, instala dependencias y abre JupyterLab
├── requirements.txt              # Dependencias de Python
├── Spotify_Dataset/
│   └── Spotify_Tracks_Dataset.csv    # Dataset original
├── taller_3/
│   ├── Taller_3.ipynb            # Notebook del taller 3 (EDA - Fases 1 y 2)
│   └── Spotify_Tracks_Dataset.csv    # Copia del dataset para este taller
└── taller_4/
    ├── Taller_4.ipynb            # Notebook del taller 4
    └── Spotify_Tracks_Dataset.csv    # Copia del dataset para este taller
```

> Cada carpeta de taller/evaluación es autocontenida: incluye su notebook y el CSV que este necesita, ya que los notebooks cargan los datos con ruta relativa (`pd.read_csv("Spotify_Tracks_Dataset.csv")`).

## Requisitos previos

- **Python 3.11 o superior** instalado desde [python.org](https://www.python.org/downloads/)
  - Durante la instalación, marcar la casilla **"Add python.exe to PATH"**

No es necesario instalar nada más: el script de inicio crea el entorno virtual e instala todas las dependencias automáticamente.

## Cómo ejecutar el proyecto

### Opción 1: Un click (recomendada)

1. Doble click en **`iniciar_proyecto.bat`**
2. El script verifica Python, crea el entorno virtual `.venv` si no existe, instala las dependencias faltantes y abre **JupyterLab** en el navegador
3. En JupyterLab, navega a la carpeta del taller (ej. `taller_4/`) y abre el `.ipynb`
4. Verifica que el kernel sea **Python 3 (ipykernel)** y ejecuta las celdas con `Shift+Enter` o **Run → Run All Cells**
5. Para detener el servidor: `Ctrl+C` en la ventana de consola

### Opción 2: Manual (terminal)

```bash
# Crear el entorno virtual (solo la primera vez)
py -3 -m venv .venv

# Activarlo
.venv\Scripts\activate          # cmd
# .venv\Scripts\Activate.ps1    # PowerShell

# Instalar dependencias (solo la primera vez, o si cambia requirements.txt)
pip install -r requirements.txt

# Levantar JupyterLab
jupyter lab
```

Luego abrir `http://localhost:8888/lab` en el navegador.

## Dependencias

Definidas en `requirements.txt`:

| Librería      | Uso                                         |
|---------------|---------------------------------------------|
| pandas        | Carga y manipulación del dataset            |
| matplotlib    | Gráficos base                               |
| seaborn       | Visualizaciones estadísticas                |
| scikit-learn  | Modelos de Machine Learning (fases futuras) |
| jupyter       | Servidor JupyterLab                         |
| ipykernel     | Kernel de Python para los notebooks         |

## Dataset

**Spotify Tracks Dataset** (~20 MB, 114.000 registros × 21 columnas). Incluye características acústicas (`danceability`, `energy`, `tempo`, `valence`, etc.), metadatos (`artists`, `album_name`, `track_genre`, `explicit`) y la variable objetivo `popularity` (0–100).

Cada carpeta de taller contiene su propia copia del CSV para que los notebooks funcionen sin modificar rutas.
