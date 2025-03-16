#!/usr/bin/awk -f
BEGIN {
    # Verificación de variables de entrada
    if (num_total <= 0 || num_deseado <= 0) {
        print "Error: num_total y num_deseado tienen que ser mayores que 0"
        exit 1
    }

    if (num_deseado > num_total) {
        print "Error: num_deseado no puede ser mayor que num_total"
        exit 1
    }

    # Calculamos la probabilidad de selección basada en los valores de entrada
    probabilidad = num_deseado / num_total

    # Inicializamos contadores y la variable para la cabecera
    seleccionadas = 0
    header_printed = 0
}

# Solo imprimir la cabecera del primer archivo
FNR == 1 {
    if (header_printed == 0) {
        print $0 >> "/home/miguel/Escritorio/TFG/TFG Miguel/CICIoT2023/BaseDeDatos/DDoS/DDoS4.csv"
        header_printed = 1
    }
    # Continuar con el siguiente registro si estamos en la cabecera de cualquier archivo
    next
}

# Selección aleatoria de líneas
{
    # Imprimir la línea si el valor aleatorio está dentro de la probabilidad deseada
    if (rand() < probabilidad && seleccionadas < num_deseado) {
        print $0 >> "/home/miguel/Escritorio/TFG/TFG Miguel/CICIoT2023/BaseDeDatos/DDoS/DDoS4.csv"
        seleccionadas++

        # Detener la selección si hemos alcanzado el número deseado de líneas
        if (seleccionadas >= num_deseado) {
            exit 0
        }
    }
}
