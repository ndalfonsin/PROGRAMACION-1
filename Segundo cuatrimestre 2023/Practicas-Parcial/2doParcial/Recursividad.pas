Program FuncionesRecursivas;
type
    vector = Array[1..10] of byte;
    matriz = Array[1..10,1..10] of byte;

{Procedimiento que muestre una secuencia de numeros}

{ 4 3 2 1}

Procedure Cuenta(N:integer);
    begin
        write(N, ' ');
        if N>0 then
            Cuenta(N-1);
    end;

Procedure CuentaVuelta(N:integer);
    begin
        if N>0 then
            CuentaVuelta(N-1);
        write(N, ' ');
    end;

Function Fibo(N:byte):word;
    begin
        if (N=1)or(N=2) then
            Fibo:=1
        else
            Fibo:= Fibo(N-1) + Fibo(N-2);
    end;
{Sumar ciertos valores hasta un N}

Procedure suma(N: word; var res: word);
    begin
        if N>0 then
            begin
                res:= res + N;
                Suma(N-1, res);
            end;
    end;

Procedure Suma2(N:word; var res1:word);
    begin
        if N>0 then
            begin
                Suma(N-1, res1);
                res1:= res1 + N;
            end
        else
            res1:= 0;
    end;

Function Suma3(N:word):word;
    begin
        if (N=0) then
            Suma3:= N
        else
            Suma3:= N + Suma3(N-1);
    end;

{Busqueda recursiva en vectores}
Function Busqueda(vec: vector; N,X:byte):boolean;
    begin
        if N > 0 then
            begin
                if vec[N] = X then
                    Busqueda:= True
                else
                    Busqueda:= Busqueda(vec, N-1, X);
            end
        else
            Busqueda:= False;
    end;

Function BusqMat(mat:matriz; X, i, i2, j:byte):boolean;
    begin
        if j = 0 then
            BusqMat:= False
        else
            begin
                if mat[i,j] = X then
                    BusqMat:= True
                else
                    begin
                        if i > 1 then {analizamos la misma fila}
                            BusqMat:= BusqMat(mat, X, i-1, i2, j)
                        else
                            BusqMat:= BusqMat(mat, X, i2, i2, j-1);
                    end;
            end;
                
    end;


var
    res, res1: word;
    vec: vector;
    mat: matriz;

begin
    Cuenta(4);
    writeln;
    CuentaVuelta(4);
    writeln;
    writeln(Fibo(5));
    res:= 0;
    suma(6, res);
    writeln(res);
    suma2(6, res1);
    writeln(res1);
    writeln(Suma3(7));

    for res:=1 to 11 do
        begin
            vec[res]:= res;
            writeln(vec[res]);
        end;

    writeln(Busqueda(vec, 10, 46));

    for res:=1 to 11 do
        begin
            for res1:=1 to 11 do
                begin
                    mat[res, res1]:= res + res1;
                    write(mat[res, res1], ' ');
                end;
            writeln;
        end;

    writeln(BusqMat(mat, 20, 10, 10, 10));

    
end.