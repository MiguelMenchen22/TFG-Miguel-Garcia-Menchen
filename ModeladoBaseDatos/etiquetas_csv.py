import os
import pandas as pd

carpeta_csvs = "/home/miguel/Escritorio/TFG/TFG Miguel/CICIoT2023/BaseDeDatos/XSS"
nombre_ataque = "XSS"


def procesar_csv(ruta_csv):
    df = pd.read_csv(ruta_csv)
    
    if 'Label' in df.columns:

        df['Label'] = df['Label'].replace('NeedManualLabel', nombre_ataque)
        
        #Guardo el archivo modificado
        df.to_csv(ruta_csv, index=False) 
        print(f"Procesado: {ruta_csv}")
    else:
        print(f"El archivo {ruta_csv} no contiene una columna 'Label'.")

for archivo in os.listdir(carpeta_csvs):
    if archivo.endswith(".csv"):
        ruta_completa = os.path.join(carpeta_csvs, archivo)
        procesar_csv(ruta_completa)

print("Todos los archivos han sido procesados.")