#!/bin/bash

# Carpeta que contiene los archivos CSV
input_directory="/home/miguel/Escritorio/TFG/TFG Miguel/CICIoT2023/BaseDeDatos/XSS/"
output_directory="/home/miguel/Escritorio/TFG/TFG Miguel/CICIoT2023/BaseDeDatos/XSS/"

# Procesar cada archivo CSV en el directorio
for file in "$input_directory"*.csv; do
    awk -F, 'BEGIN { OFS = "," } 
        NR == 1 { 
            # Procesar la cabecera
            for (i = 1; i <= NF; i++) {
                header[i] = $i;
                # Identificar columnas a eliminar
                if ($i == "Flow ID" || $i == "Src IP" || $i == "Src Port" || 
                    $i == "Dst IP" || $i == "Dst Port" || $i == "Timestamp") {
                    delete header[i]; 
                    col_to_remove[i] = 1; 
                }
            }
            # Imprimir la cabecera sin las columnas eliminadas
            for (i = 1; i <= NF; i++) if (!(i in col_to_remove)) printf "%s%s", header[i], (i==NF ? ORS : OFS);
        } 
        NR > 1 { 
            # Para cada fila de datos
            for (i = 1; i <= NF; i++) if (!(i in col_to_remove)) printf "%s%s", $i, (i==NF ? ORS : OFS);
        }' "$file" > "$output_directory/temp.csv" && mv "$output_directory/temp.csv" "$file"
done
