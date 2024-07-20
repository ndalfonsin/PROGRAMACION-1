Program ej1;

{ Una empresa de transporte de encomiendas tiene un registro de los paquetes a transportar en un
archivo PAQUETES.DAT, de cada uno se conoce:
# CODIGO de PAQUETE
# PESO
# CODIGO de DESTINO (1..30)
# MONTO ASEGURADO
Por otro lado se cuenta con un archivo DESTINO.DAT que contiene:
# CODIGO de DESTINO (1..30, desordenado)
# DESCRIPCION (cadena de 15)
Se desea saber:
a) El peso promedio de los paquetes.
b) Total del monto asegurado de la carga a transportar.
c) Al finalizar el proceso armar el siguiente listado:
Destino Cantidad de Paquetes
Xxxxxxxxxxxxxxxx 99
. . . . . .
TOTAL}

Type
    Str5 = String[5];
    TRPaq = record 
        primary_key: Str5;
        peso: real;
        codDest: byte;
        monto: real;
    end; 

    TRDes = record
        codDest: byte;
        desctip: string;
    end;

    TAPaq = file of TRPaq;
    TADes = file of TRDes;

Procedure CargaPaq(var paquetes:TAPaq);
    var
        paqInfo: text;
        info: TRPaq;

    begin
        Assign(paqInfo, 'paquetes.txt');
        reset(paqInfo);
        Assign(paquetes, 'paquetes.dat');
        rewrite(paquetes);
        readln(paqInfo, info.primary_key, info.peso, info.codDest, info.monto);
        while not EOF(paqInfo) do
            begin
                write(paquetes, info);
                readln(paqInfo, info.primary_key, info.peso, info.codDest, info.monto);
            end;
        close(paqInfo);
        close(paquetes);
    end;

Procedure CargaDest(var destinos:TADes);
    var
        desInfo: text;
        info: TRdes;

    begin
        Assign(desInfo, 'destinos.txt');
        reset(desInfo);
        Assign(destinos, 'destinos.dat');
        rewrite(destinos);
        readln(desInfo, info.codDest, info.desctip);
        while not EOF(desInfo) do
            begin
                write(destinos, info);
                readln(desInfo, info.codDest, info.desctip);
            end;
        close(desInfo);
        close(destinos);
    end;

Procedure promPeso(var paquetes:TAPaq); {NUNCA PUEDE SER UNA FUNCION CON UN ARCHIVO DE REGISTROS}
    var
        acum: real;
        cont: byte;
        auxR: TRPaq;
        montoacum: real;
    begin
        Assign(paquetes, 'paquetes.dat');
        reset(paquetes);
        acum:= 0;
        cont:= 0;
        montoacum:= 0;

        while not EOF(paquetes) do
            begin
                read(paquetes, auxR);
                acum:= acum + auxR.peso;
                cont:= cont + 1;
                montoacum:= montoacum + auxR.monto;
            end;

        writeln('El promedio es: ', acum/cont:3:2);
        writeln('El monto acumulado es: ',montoacum:3:2);
        close(paquetes);

    end;

Procedure listado(var paquetes: TAPaq; var destinos: TADes);
    var
        acumP, acumT:word;
        auxRp: TRPaq;
        auxRd: TRDes;
    begin
        Assign(paquetes, 'paquetes.dat');
        Assign(destinos, 'destinos.dat');
        Reset(destinos);
        acumT:= 0;

        writeln('Destino Cantidad de Paquetes');

        while not EOF(destinos) do
            begin
                Reset(paquetes);
                read(destinos, auxRd);
                acumP:= 0;
                while not EOF(paquetes) do
                    begin
                        read(paquetes, auxRp);
                    
                        if auxRd.codDest = auxRp.codDest then
                            begin
                                acumP:= acumP + 1;
                                acumT:= acumT + 1;
                            end;
                    end;
                writeln('-> ', auxRd.desctip, ' ', acumP);
            end;
        writeln('TOTAL: ', acumT);
        Close(paquetes);
        Close(destinos);
    end;

var
    paquetes: TAPaq;
    destinos: TADes;

Begin
    CargaPaq(paquetes);
    CargaDest(destinos);
    promPeso(paquetes);
    writeln;
    listado(paquetes, destinos);
end.
