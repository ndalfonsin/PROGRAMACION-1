Program SegundoParcial;

{Una Universidad registra los datos de los inscriptos a una carrera a distancia en un archivo de texto 
INSCRIPTOS.TXT, un inscripto por línea y ordenado por orden de inscripción. Cada línea contiene los siguientes 
datos: 
    • DNI (cadena de 8) 
    • Edad (menor a 100) 
    • Código Provincia (cadena de 2) 

Además se cuenta con el archivo PROVINCIAS.TXT que posee los siguientes datos en cada línea: 
    • Código (cadena de 2) 
    • Nombre(cadena de 30) 
    • Distancia de la capital de la provincia hasta la sede de la Universidad (en km) 

Se pide leer los datos de los archivos y almacenarlos en las estructuras necesarias para obtener información 
resumida por provincia y rangos etarios agrupados de a 10 años (por ejemplo: el primer rango de los 10 contiene 
a las personas con edades de 10 a 19 y el último rango de los 90, a las personas de 90 a 99). Luego, en base a esas 
estructuras, informar: 
    a) Dado un código de provincia X, ingresado por teclado (puede no existir), cantidad de rangos etarios 
    sin inscriptos en X. 
    b) La provincia con menos cantidad total de inscriptos en los rangos etarios ubicados entre el rango R y 
    el rango T (R <= T) ingresados por teclado (se ingresa la edad de inicio del rango: por ej. 30 para el 
    rango 30-39). Si hubiera más de una, mostrar la primera. 
    c) Generar un arreglo con los pares provincia-rango etario (poner en el arreglo, para el rango, la edad de 
    inicio) que superen el 10% del total de inscriptos en la carrera. Luego mostrar el arreglo generado. 

Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), necesarios 
para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
    - Buscar la provincia de nombre X (para el inciso a) 
    - Calcular el total de inscriptos (para el inciso c) 

Nota: No resolver de manera recursiva ningún otro subprograma que no sean los especificados.
}

type
    str2 = string[2];
    str30 = string[30];
    str8 = string[8];
    
    datosProv = record
        cod: str2;
        nombre: str30;
    end;

    vec = Array[1..10] of datosProv;

    mat = Array[1..10, 1..10] of byte;
    matRE = Array[1..10, 1..10] of real;

const
    M = 9; {cantidad de rangos ectarios}

Procedure cargaProv(var vecProv: vec; var N: byte);
    var
        arch: text;
        aux: char;
        auxNombre: str30;
    
    begin
        Assign(arch, 'provincias.txt');
        Reset(arch);
        N:= 0;

        while not EOF(arch) do
            begin
                N:= N + 1;
                read(arch, vecProv[N].cod, aux);
                auxNombre:= '';

                read(arch, aux);

                while not ((aux > '0') and (aux < '9')) do
                    begin
                        
                        if not ((aux > '0') and (aux < '9')) then
                            auxNombre:= auxNombre + aux;

                        read(arch, aux)
                    end;
                vecProv[N].nombre:= auxNombre;
                readln(arch, auxNombre);
            end;
        Close(arch);
    end;

{Inicializo la matriz en 0- CANTIDAD DE FILAS VA A SER N (una fila por provincia) y la cantidad de columnas (rango ectario 1..9)}

Procedure IncioMatriz(var matInsc: mat; N, M: byte);
    var
        i, j: byte;
    begin
        for i:= 1 to N do
            begin
                for j:=1 to M do
                    begin
                        matInsc[i,j] := 0;
                    end;
                writeln;
            end;
    end;

Function BusqRec(vecProv: vec; N:byte; cd: str2):byte;
    begin
        if N = 0 then
            BusqRec:= 0
        else
            begin
                if vecProv[N].cod = cd then
                    BusqRec:= N
                else
                    BusqRec:= BusqRec(vecProv, N-1, cd);
            end;
    end;

Procedure cargaMatInsc(var matInsc: mat; vecProv:vec; var N, cont:byte);
    var
        arch: text;
        auxDNI: str8;
        aux: char;
        edad: byte;
        codProv: str2;
        i, j: byte;

    begin
        Assign(arch, 'inscriptos.txt');
        Reset(arch);
        cont:= 0;

        while not EOF(arch) do
            begin
                readln(arch, auxDNI, edad, aux, codProv);
                cont:= cont + 1;

                i:= BusqRec(vecProv, N, codProv);
                j:= edad div 10;

                matInsc[i,j]:= matInsc[i,j] + 1;
            end;
        Close(arch);
    end;

Procedure muestraMatriz(matInsc: mat; N, M: byte);
    var
        i, j: byte;
    begin
        for i:= 1 to N do
            begin
                for j:=1 to M do
                    begin
                        write(matInsc[i,j], ' ');
                    end;
                writeln;
            end;
    end;


function incisoA(fila, M: byte; matInsc: mat): byte;    
    begin
        if M > 0 then
            begin
                incisoA:= incisoA(fila, M-1, matInsc);
                if matInsc[fila, M] = 0 then
                    incisoA:= incisoA + 1;
            end
        else
            incisoA:= 0;
    end;

Procedure muestraInciso(vecProv: vec; N, M: byte; matInsc: mat);
    var
        prov : string;
        cant, busq: byte;

    begin
        repeat
            writeln('Provincias: [BA]Buenos Aires [ME]Mendoza [CH]Chubut [RN]Rio Negro [ER]Entre Rios');
            write('Ingrese el codigo de provincia que desea buscar: '); readln(prov);
            prov:= upcase(prov);
            busq:= BusqRec(vecProv, N, prov)
        until (busq<>0);

        cant:= incisoA(busq, M, matInsc);

        writeln('la cantidad de rangos ectarios no inscriptos en ',vecProv[busq].nombre, 'es ', cant);

    end;

procedure CargaMatPorc(var matPorc: matRE; matInsc: mat; N, M, cont: byte);
    var
        i, j: byte;
    begin
        for i:=1 to N do
            begin
                for j:=1 to M do
                    begin
                        matPorc[i,j]:= (matInsc[i, j] / 18)*100;
                        write(matPorc[i,j]:2:0, ' ');
                    end;
                writeln;
            end;
    end;

Procedure incisoC(vecProv: vec; N, M, aux: byte; matPorc:matRE);
    begin 
        if N > 0 then
            begin
                if M = 1 then
                    begin
                        incisoC(vecProv, N - 1, aux, aux, matPorc);
                        write(vecProv[N].nombre,' ');
                    end
                else
                    incisoC(vecProv, N, M - 1, aux, matPorc);
                
                if M = aux then
                    writeln;

                if matPorc[N, M] > 10 then
                    write(M*10, ' ');
            end;
        

    end;

{}

var
    vecProv: vec;
    N, cont, aux: byte;
    matInsc: mat;
    matPorc: matRE;

begin
    cargaProv(vecProv, N);
    IncioMatriz(matInsc, N, M);
    cargaMatInsc(matInsc, vecProv, N, cont);
    muestraInciso(vecProv, N, M, matInsc);
    CargaMatPorc(matPorc, matInsc, N, M, cont);
    aux:= M;
    incisoC(vecProv, N, M, aux, matPorc);
   
end.
