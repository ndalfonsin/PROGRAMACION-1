Program PrimerParcial;

{
En un archivo de texto, CHECKIN.TXT se encuentran detallados los pasajeros que deben realizar el checkin de un determinado tren turístico.
En la primera línea del archivo aparecen la cantidad de asientos del tren turístico (N)
Luego, agrupados por reserva, se detalla en cada línea:

RESERVA [ANU4, puede repetirse, incluyendo más de un DNI]
DNI [ANU8]
Edad
Peso Equipaje de Mano [Númerico]
El tren tiene un asiento por fila y estos están numerados del 1 a N.

Con el fin de balancear el peso del tren, se debe ubicar a los pasajeros según el criterio:

El primero que llega, debe ocupar el primer asiento y mientras el código de reserva no cambie, se siguen ubicando consecutivamente detrás de dicho pasajero.
Al cambiar el código de reserva, se deben ubicar los pasajeros al fondo del tren, desde el último asiento hacia el centro.
 Se debe continuar con esta acción llenando el tren, desde los extremos hacia el centro.
Se pide, completar el checkin del tren para luego resolver mediante un subprograma por inciso:

a) Dado un DNI, encontrar entre los asientos ocupados cuál es el nro de asiento que se le asignó. Si no existe, informar “No realizó el checkin”.
b) Para un rango de pesos P1 y P2, informar el promedio de la edad de los pasajeros cuyo equipaje de mano tiene un peso que pertenece al rango dado.
c) Informar el DNI de los 3 pasajeros que llevan mayor peso de equipaje de mano
}

Uses
    crt;

Const
    maxN = 30;

Type
    STR4 = string[4];
    STR8 = string[8];
    TVstr4 = Array[1..maxN] of STR4;
    TVstr8 = Array[1..maxN] of STR8; 
    TVbyte = Array[1..maxN] of byte;
    TVreal = Array[1..maxN] of real;

{CARGA DE DATOS}
Procedure cargaDatos(var COD:TVstr4; var DNI: TVstr8; var edad: TVbyte; var equipaje:TVreal; var N, cantAsientos: byte);
    var
        arch: text;
        aux: char;
    begin
        Assign(arch, 'CHECKIN.txt');
        Reset(arch);
        readln(arch, cantAsientos);
        N:= 1;
        while not EOF(arch) do
            begin
                readln(arch, COD[N], aux, DNI[N], edad[N], equipaje[N]);
                N:= N + 1;
            end;
        Close(arch);
    end;
{Asignacion de asientos bajo condicion de cod de reserva}
Procedure asignacionAsiento(var asiento: TVbyte; cantAsientos, N: byte; COD: TVstr4);
    var 
        i, ultCreciente, ultDecr: byte;
        reverse: boolean;
    begin
        reverse:= False;
        ultCreciente:= 1;
        ultDecr:= cantAsientos + 1;
        for i:=1 to N do
            begin
                if i = 1 then
                    asiento[i]:= 1
                else
                    begin
                        if (COD[i-1] = COD[i])and(reverse=False) then
                            begin
                                asiento[i]:= asiento[i-1] + 1;
                                ultCreciente:= asiento[i];
                            end
                        Else if (COD[i-1] = COD[i])and(reverse=True) then
                            begin
                                asiento[i]:= asiento[i-1] - 1;
                                ultDecr:= asiento[i];
                            end
                        Else if (COD[i-1] <> COD[i])and(reverse=False) then
                            begin
                                asiento[i]:= ultDecr - 1;
                                reverse:= True;
                            end
                        Else if (COD[i-1] <> COD[i])and(reverse=True) then
                            begin
                                asiento[i]:= ultCreciente + 1;
                                reverse:= False;
                            end;    
                    end;

                
            end;
    end;
{Procedimiento de comprobacion de carga de datos}
Procedure muestraAsientos(asiento: TVbyte; N:byte);
    var
        i: byte;
    begin
        for i:= 1 to N do
            writeln(asiento[i]);
    end;
{Funcion de busqueda por DNI - DEVUELVE EL INDICE DEL ARRAY}
Function buscaXDNI(busqueda: STR8; DNI: TVstr8; N:byte):byte;
    var
        i: byte;

    begin
        i:= 1;

        while (DNI[i]<>busqueda)and(i<=N) do
            i:= i + 1;

        if i = N+1 then
            buscaXDNI:= 0
        else
            buscaXDNI:= i;    
    end;
{Procedimiento de muestra de asiento segun el DNI}
Procedure asientoXDni(asiento: TVbyte; DNI: TVstr8; N:byte);
    var
        busqueda: STR8;
    begin
        write('Ingrese el DNI: ');readln(busqueda);

        ClrScr;

        if buscaXDNI(busqueda, DNI, N) <> 0 then
            writeln('El DNI ',busqueda,' tiene asignado el asiento ',buscaXDNI(busqueda, DNI, N))
        else
            writeln('El DNI ingresado no es valido o no ha realizado el checkin');
    end;

{
!!!- Si voy a crear un procedimiento que necesita de una funcion para resolver datos que han de mostrarse, estas funciones las deberia
declarar dentro del procedimiento, o esta bien que cada una la modularice por su parte?
Debo modularizar mas en submodulos?

Ademas, como funciona el FORDWOARD?
}

{PROMEDIO DE EDAD SEGUN EL PESO DE SU EQUIPAJE}
Procedure muestraPromEdad(edad: TVbyte; equipaje: TVreal; N:byte);
    var
        p1, p2, promedio: real;
        cont, i: byte;
        acumEdad: integer;
    begin
        cont:= 0;
        acumEdad:= 0;

        write('Ingresa el peso piso: ');readln(p1);
        write('Ingresa el peso techo: ');readln(p2);

        for i:=1 to N do
            begin
                if (p1<equipaje[i])and(equipaje[i]<p2) then
                    begin
                        acumEdad:= acumEdad + edad[i];
                        cont:= cont + 1;
                    end;
            end;

        ClrScr;
        promedio:= acumEdad div cont;
        writeln('El promedio de edad es de ', promedio:4:2);

    end;
{PRIMERA FUNCION - Busqueda del indice con el mayor equipaje}
Function buscaMayEquipaje(equipaje: TVreal; N:byte):byte;
    var
        mayEq: real;
        i: byte;
    begin
        mayEq:= 0;
        for i:=1 to N do
            begin
                if mayEq < equipaje[i] then
                    begin
                        mayEq:= equipaje[i];
                        buscaMayEquipaje:= i;
                    end;
            end;
    end;
{SEGUNDA FUNCION - Esta funcion permite buscar el indice con el mayor equipaje despues de uno pasado como parametro}
Function buscaMayEquipajeEntreVal(equipaje: TVreal; N, eqAnt: byte):byte;
    var
        mayEq: real;
        i: byte;
    begin
        mayEq:= 0;
        for i:=1 to N do
            begin
                if (mayEq < equipaje[i])and(equipaje[i]<equipaje[eqAnt]) then
                    begin
                        mayEq:= equipaje[i];
                        buscaMayEquipajeEntreVal:= i;
                    end;
            end;
    end;
{Procedimiento para mostar los DNI de aquellos que poseen los 3 mayores equipajes}
Procedure DNImayEq(DNI: TVstr8; equipaje: TVreal; N:byte);
    var
        prim, sec, ter: byte;
    begin
        writeln('Los 3 DNI con los mayores equipajes son:');
        prim:= buscaMayEquipaje(equipaje, N);
        sec:= buscaMayEquipajeEntreVal(equipaje, N, prim);
        ter:= buscaMayEquipajeEntreVal(equipaje, N, sec);
        writeln;
        writeln(DNI[prim], ' con un peso total de ',equipaje[prim]:4:2,'kg.');
        writeln(DNI[sec], ' con un peso total de ',equipaje[sec]:4:2,'kg.');
        writeln(DNI[ter], ' con un peso total de ',equipaje[ter]:4:2,'kg.');

    end;
{MENU}
Procedure menu();
    begin
        ClrScr;
        writeln('Primer Parcial');
        writeln('1-Busqueda de asiento por DNI');
        writeln('2-Promedio de edad de pasajeros con equipajes entre P1 y P2');
        writeln('3-DNI de los 3 con mayor equipaje de mano');
        writeln('0-Salir');
    end;
{PROGRAMA PRINCIPAL}
Procedure main(var COD:TVstr4; var DNI: TVstr8; var asiento, edad: TVbyte; var equipaje:TVreal; var N, cantAsientos: byte);
    var
        op: byte;
    begin
        cargaDatos(COD, DNI, edad, equipaje, N, cantAsientos);
        asignacionAsiento(asiento, cantAsientos, N, COD);
        repeat
            menu();
            writeln;
            write('Ingrese su opcion: ');readln(op);

            ClrScr;
            Case op of 
                1: asientoXDni(asiento, DNI, N);
                2: muestraPromEdad(edad, equipaje, N);
                3: DNImayEq(DNI, equipaje, N);
            end;

            if op <> 0 then
                begin
                    writeln;
                    writeln('Presione enter para volver al menu');Readln();
                end;
        until (op = 0);
    end;
var
    COD: TVstr4;
    DNI: TVstr8;
    edad, asiento: TVbyte;
    N, cantAsientos: byte;
    equipaje: TVreal;

begin
    main(COD, DNI, asiento, edad, equipaje, N, cantAsientos);
end.