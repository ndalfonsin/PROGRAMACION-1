Program MatRec;
{Como es una matriz NXN solo pido el valor de N}
type
    TM = array[1..10 , 1..10] of real;

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
                        write(matriz[i,j]:2:1, ' ');
                    end;
                writeln();
                readln(arch);
            end;
        Close(arch);
    end;

{Lectura desde arriba a abajo}
function MayDiag(matriz: TM; i, j, N:byte):boolean;
    begin
        if i > N then {caso base, me pase de filas}
            MayDiag:= true {significa que todo se viene cumpliendo}
        else if j > N then {si ya lei todas las columnas, paso a la siguiente fila}
            MayDiag:= MayDiag(matriz, i+1 , 1, N)
        else if (i < j) and (matriz[i,j] <= matriz[i,i]) then {reviso solo aquellas columnas que sean menores que el numero de fila y comparo con mat[i,i]}
            MayDiag:= False
        else
            MayDiag:= MayDiag(matriz, i, j+1, N); {verifico la columna siguiente}
    end;
var
    matriz: TM;
    N: byte;
begin
    CargaMatriz(matriz, N);
    
    if MayDiag(matriz, 1, 1, N) then
        writeln('es verdadero')
    else
        writeln('es falso');

end.