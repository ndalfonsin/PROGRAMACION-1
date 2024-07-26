Program matrices;
{
Sea Mat una matriz entera, de NxN desarrollar una función recursiva entera que devuelva la cantidad de veces que el elemento de la Diagonal Principal es mayor 
que el de la Diagonal Secundaria ubicado en la misma fila. Mostrar la declaración de variables del programa invocante y los parámetros actuales de la invocación. 
Ejemplo N = 5
}

type
    TM = array[1..10 , 1..10] of integer;

Procedure CargaMatriz(var matriz:TM; var N: byte);
    var
        i, j: byte;
        arch:text;
    begin
        Assign(arch, 'matriz.txt');
        Reset(arch);
        readln(arch, N);
        i:=0;
        while not EOF(arch) do
            begin
                i:= i + 1;
                for j:=1 to N do
                    begin
                        read(arch, matriz[i,j]);
                        write(matriz[i,j], ' ');
                    end;
                writeln();
                readln(arch);
            end;
        Close(arch);
    end;

Function CuentaMayorDiag(matriz: TM; i, N: byte):byte;
    begin
        if i > N then
            CuentaMayorDiag:= 0
        else
            begin
                if matriz[i,i] > matriz[i, (N-i+1)] then
                    CuentaMayorDiag:= CuentaMayorDiag(matriz, i+1, N) + 1
                else
                    CuentaMayorDiag:= CuentaMayorDiag(matriz, i+1, N);
            end;
    end;

var
    matriz: TM;
    N: byte;
begin
    CargaMatriz(matriz, N);
    writeln(CuentaMayorDiag(matriz, 1, N));
end.

