Program ej2;
{
Un Banco registra en TARJETAS.DAT el movimiento de las tarjetas de crédito de sus usuarios.
# NUMERO de TARJETA (1er campo de secuencia, clave primaria)
# NOMBRE del PROPIETARIO
# TOPE
# GASTO del MES (hasta el momento)
Además, se van ingresando (desde teclado ó archivo de texto) las compras con los siguientes datos:
- Número de Tarjeta (puede repetirse)
- Monto
- Código de operación
Procesar los datos, actualizando los gastos del mes, siempre que no supere el monto tope, en caso
contrario, rechazarlo y grabar en un archivo RECHAZADOS.DAT con la siguiente información:
# NUMERO de TARJETA
# CODIGO DE OPERACION
# MONTO
Sugerencia: para obtener la dirección relativa y acceder en forma directa al archivo TARJETAS, descargar
del mismo los números de tarjeta sobre un arreglo (tabla).
}
type
    codTar = string[19]; //XXXX XXXX XXXX XXXX

    tRTar = record
        Num_tar: codTar;
        Prop: string;
        tope, conMes: real;
    end;

    tRMov = record
        Num_tar: codTar;
        codOP: string;
        monto: real;
    end;

    tATar = file of tRTar;
    tAMov = file of tRMov;

    tVtarj = array[1..10] of codTar; //Vector para ubicar el puntero en el enfrentamiento


Procedure cargaTarjetas(var tarjetas: tATar; var vecTar:tVtarj; var N:byte);
    var
        arch: text;
        auxR: tRTar;
    begin
        Assign(arch, 'tarjetas.txt');
        Assign(tarjetas, 'tarjetas.dat');
        reset(arch);
        rewrite(tarjetas);
        N:= 0;
        while not EOF(arch) do
            begin
                N:= N+1;
                readln(arch, auxR.Num_tar);
                readln(arch, auxR.Prop);
                readln(arch, auxR.tope);
                readln(arch, auxR.conMes);
                write(tarjetas, auxR);
                vecTar[N]:= auxR.Num_tar;
            end;
        Close(arch);
        Close(tarjetas);
    end;

procedure CargaMov(var movimientos: tAMov);
    var
        arch: Text;
        auxRR: tRMov;
    begin
        Assign(arch, 'movimientos.txt');
        reset(arch);
        Assign(movimientos, 'movimientos.dat');
        rewrite(movimientos);
        while not EOF(arch) do
            begin
                readln(arch, auxRR.Num_tar); 
                readln(arch, auxRR.codOP);
                readln(arch, auxRR.monto);
                write(movimientos, auxRR);
            end;
        Close(arch); 
        Close(movimientos); 
    end;

Function Busqueda(vecTar:tVtarj; N:byte; busq: codTar):byte;
    begin
        if N > 0 then
            begin
                if busq = vecTar[N] then
                    Busqueda:= N
                else
                    Busqueda:= Busqueda(vecTar, N-1, busq);
            end
        else
            Busqueda:= 0;
    end;

Procedure enfrentamiento(var tarjetas:tATar; var movimientos, errMov: tAMov; vecTar: tVtarj; N: byte);
    var
        auxRmov: tRMov;
        auxRtar: tRTar;
    begin
        Assign(tarjetas, 'tarjetas.dat');
        Assign(movimientos, 'movimientos.dat');
        Assign(errMov, 'errMov.dat');
        
        //Vamos a iterar a travez del puntero del registro para modificarlo
        Reset(movimientos);//Es el que leemos 1 a 1
        Rewrite(errMov);//Aquellos mov que no se puedan hacer salen como error
        Reset(tarjetas);

        while not EOF(movimientos) do
            begin
                Read(movimientos, auxRmov);
                seek(tarjetas, (Busqueda(vecTar, N, auxRmov.Num_tar)-1));
                Read(tarjetas, auxRtar);

                if (auxRmov.monto + auxRtar.conMes) <= auxRtar.tope then
                    begin
                        auxRtar.conMes:= auxRtar.conMes + auxRmov.monto;
                        Seek(tarjetas, FilePos(tarjetas) - 1);
                        BlockWrite(tarjetas, auxRtar, 1);//cargo el registro en la posicion actual del puntero
                        writeln('COMPRA ACTUALIZADA PARA ',auxRtar.Num_tar);
                        writeln('Nuevo consumo: ', auxRtar.conMes:9:1);
                        writeln;
                    end
                else
                    begin
                        write(errMov, auxRmov);
                        writeln('ERROR DE MOVIMIENTO TARJETA: ', auxRtar.Num_tar);
                        writeln;
                    end;

            end;
        Close(tarjetas); 
        Close(movimientos); 
        Close(errMov); 
    end;

var
    tarjetas: tATar;
    movimientos, errMov: tAMov;
    vecTar: tVtarj;
    N: byte; //dimension del vector
begin
    cargaTarjetas(tarjetas, vecTar, N);
    CargaMov(movimientos);
    enfrentamiento(tarjetas, movimientos, errMov, vecTar, N);
end.