Program censo;
{En el último censo del 2022 se guardaron los datos en un archivo de texto CENSO.TXT con el siguiente 
contenido: 
    ● Código Comprobante de Censo (AN8, los últimos dos caracteres corresponden a la provincia) 
    ● Se realizó digitalmente (S/N) 
    ● Cantidad de habitantes de la vivienda 
    ● Ingreso total en $ de los habitantes de la vivienda (en miles) 
    ● Alquila (S/N) 
Adicionalmente, se dispone de otro archivo de PROVINCIAS.TXT con los siguientes datos clasificados en 3 
regiones dentro del país 
    ● Código Provincia (AN2) 
    ● Nombre Provincia (AN30) 
    ● Código de Región (C-Centro; N-Norte; S-Sur) 
    ● Cantidad de habitantes en 2010 
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde los archivos la información 
almacenando sólo la que sea relevante para este problema en las estructuras que corresponda, sólo si 
corresponde a censos digitales.
Hallar y mostrar: 
    a) Cantidad de habitantes censados en cada región. 
    b) Nombre de la Provincia con mayor ingreso promedio por vivienda (si se repite el ingreso total tomar 
la primera). 
    c) Importe total de subsidios de un código de provincia ingresado por teclado (puede no existir). 
Considerando que el subsidio es el 10% del ingreso total de las viviendas, si la cantidad censada de la 
provincia supera la cantidad de habitantes del 2010, de lo contrario no tiene subsidio
}
const
    max = 50;

type
    Str8 = string[8];
    Str2 = string[2];
    Str30 = string[30];
    TVstr8 = array[1..max] of Str8;
    TVstr2 = array[1..max] of Str2;
    TVstr30 = array[1..max] of Str30;
    TVchar = array[1..max] of char;
    TVbyte = array[1..max] of byte;
    TVreal = array[1..max] of real;

Procedure CargaDatosCenso(var COD: TVstr8; var dig, alquila: TVchar; var ingresos: TVreal; var cantAct: TVbyte; var N: byte);
    var
        arch: text;
        aux: char;
    begin
        Assign(arch, 'censo.txt');
        Reset(arch);
        N:= 0;
        
        while not EOF(arch) do
            begin
                N:= N + 1;
                readln(arch, COD[N], aux, dig[N], cantAct[N], ingresos[N], aux, alquila[N]);
            end;

        Close(arch);
    end;

Procedure CargaDatosProvincias(var codProv: TVstr2; var prov: TVstr30; var codReg: TVchar; var canthab: TVbyte; var J: byte);
    var
        arch: text;
        aux, lec: char;
        provincia: Str30;
    begin
        Assign(arch, 'provincias.txt');
        Reset(arch);
        J:= 0;
        
        while not EOF(arch) do
            begin
                J:= J + 1;
                provincia:= '';
                
                read(arch, codProv[J], aux);
                aux:= '*';
                while aux <> ' ' do
                    begin
                        read(arch, lec);
                        provincia:= provincia + lec;
                        if lec = ' ' then
                            begin
                                read(arch, lec);
                                read(arch, aux);
                                if aux <> ' ' then
                                    provincia:= provincia + lec + aux;
                            end;
                        
                    end;
                prov[J]:= provincia; 
                codReg[J]:= lec;
                read(arch, canthab[J]);
                readln(arch);
            end;

        Close(arch);
    end;


Function BusquedaCodProv(codProv: TVstr2; J:byte; busqueda: Str2):byte;
    var
        i: byte;
    begin
        i:= 1;
        while (codProv[i] <> busqueda)and(i<=J+1) do
            begin
                i:= i + 1;
            end;
        
        if i=J+1 then
            BusquedaCodProv:= 0
        else
            BusquedaCodProv:= i;
    end;

Procedure CantHabXReg(COD: TVstr8; cantAct: TVbyte; N, J:byte; codProv: TVstr2; codReg: TVchar);
    var
        i, k: byte;
        aux: char;
        cantC, cantS, cantN: integer;
        codAux: Str2;
    begin
        cantN:= 0;
        cantC:= 0;
        cantS:= 0;
        for i:= 1 to N do
            begin
                codAux:= Copy(COD[i], 7, 2);
                aux:= codReg[BusquedaCodProv(codProv, J, codAux)]; 
                case aux of
                    'C': cantC:= cantC + cantAct[i];
                    'S': cantS:= cantS + cantAct[i];
                    'N': cantN:= cantN + cantAct[i];
                end; 
            end;
        writeln('La cantidad de habitantes en la region C es: ',cantC);
        writeln('La cantidad de habitantes en la region N es: ',cantN);
        writeln('La cantidad de habitantes en la region S es: ',cantS);
    end;

Function ProvMaxIngresos(ingresos: TVreal; COD: TVstr8; prov: TVstr30; codProv: TVstr2; N, J:byte):Str30;
    var
        i: byte;
        maxIng: real;
        codBusq: Str2;
    begin
        maxIng:= 0;

        for i:= 1 to N do
            begin
                if ingresos[i] > maxIng then
                    begin
                        maxIng:= ingresos[i];
                        codBusq:= copy(COD[i], 7, 2);
                    end;
            end;
        ProvMaxIngresos:= prov[BusquedaCodProv(codProv, J, codBusq)];
    end;

Procedure MuestraSubsidio(COD: TVstr8; codProv: TVstr2; J,N:byte; cantAct, canthab: TVbyte; ingresos: TVreal);
    var
        i: byte;
        cont, acum: byte;
        prom, acumIng: real;
        busqUser: string;
    begin
        repeat
            write('Ingrese un codigo de provincia: ');readln(busqUser);
        until (BusquedaCodProv(codProv, J, busqUser)<>0);
        cont:= 0;
        acum:= 0;
        acumIng:= 0;
        for i:=1 to N do
            begin
                if copy(COD[i], 7, 2) = busqUser then
                    begin
                        cont:= cont + 1;
                        acum:= acum + cantAct[i];
                        acumIng:= acumIng + ingresos[i];
                    end;
            end;
        prom:= acum div cont;
        acumIng:= acumIng*1000;

        if canthab[BusquedaCodProv(codProv, J, busqUser)] < prom then
            writeln('El total subsidiado es de $',(acumIng*0.10):4:2)
        else
            writeln('La provincia no recibe subsidio');
    end;
var
    {2 tipos de vectores paralelos, N -> censo.txt; J -> provincias.txt}
    COD: TVstr8;
    codProv: TVstr2;
    prov: TVstr30;
    dig, alquila, codReg: TVchar;
    cantAct, canthab: TVbyte;
    ingresos: TVreal;
    N, J: byte;
begin
    CargaDatosCenso(COD, dig, alquila, ingresos, cantAct, N);
    CargaDatosProvincias(codProv, prov, codReg, canthab, J);
    CantHabXReg(COD, cantAct, N, J, codProv, codReg);
    writeln('La provincia con el mayor ingreso es: ', ProvMaxIngresos(ingresos, COD, prov, codProv, N, J));
    MuestraSubsidio(COD, codProv, J, N, cantAct, canthab, ingresos);

    readln();
end.
    
