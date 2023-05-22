Program SegundoParcial;

{Dada una matriz de NxM, cuyos elementos son letras mayúsculas o minúsculas. Se desea conocer el
top 3 de las columnas con mayor porcentaje de mayúsculas sobre el total de elementos de la
columna.Mostrar por pantalla los resultados

- Calcular cantidad de mayúsculasen una columna
- Mostrar un arreglo
- Determinar la posición donde corresponda insertar un elemento en un arreglo
}

type 
    TM = Array[1..10,1..10] of char;
   

    TregResult = record
        cantColum : byte;
        Porc : real;
    end;

    TV = Array[1..10] of TregResult;

//---- Carga matriz

Procedure cargaMatriz(var Matriz: TM; var N, M: byte);
    var
        i,j: byte;
        Arch: text;
    begin
        Assign(Arch, 'matriz.txt');
        reset(Arch);

        readln(Arch, N);
        readln(Arch, M);

        for i:=1 to N do
            begin
                for j:=1 to M do
                    begin
                        readln(Arch, Matriz[i,j]);
                        write(Matriz[i,j], ' ');
                    end;
                writeln;
            end;
        
    end;

//-----A

function cantMayus(Matriz: TM; colum, N: byte):byte;
    var
        cont: byte;

    begin
        if N > 1 then
            begin
                cont:= cantMayus(Matriz, colum, N-1);
                if Matriz[N, colum] = upcase(Matriz[N, colum]) then
                    cont:= cont + 1;
            end;
        if N = 1 then
            begin
                if Matriz[N, colum] = upcase(Matriz[N, colum]) then
                    cont:= 1
                else
                    cont:= 0;
            end;

        cantMayus:= cont;
    end;

//----- B 

procedure cargaVec(var result: TV; N,M: byte; Matriz: TM);
    var
        i:byte;
    begin
        for i:=1 to M do
            begin
                result[i].cantColum := i;
                //write(result[i].cantColum, ' ');
                result[i].Porc := (cantMayus(Matriz, i, N)/N) * 100;
                //rite(result[i].Porc:2:2);
                //writeln;
            end;
    end;

//----- C 

procedure masPorc(result: TV; M:byte);
    var

        

    begin
       
   
    end;

//------ PROGRAMA PRINCIPAL

var 
    Matriz : TM;
    N, M: byte;
    result : TV;
    
begin
    cargaMatriz(Matriz, N, M);

    //A
    writeln('La columna 1 tiene ',cantMayus(Matriz, 1, N),' mayusculas');
    writeln('La columna 2 tiene ',cantMayus(Matriz, 2, N),' mayusculas');
    writeln('La columna 3 tiene ',cantMayus(Matriz, 3, N),' mayusculas');
    writeln('La columna 4 tiene ',cantMayus(Matriz, 4, N),' mayusculas');
    writeln('La columna 5 tiene ',cantMayus(Matriz, 5, N),' mayusculas');

    //B
    cargaVec(result, N, M, Matriz);
    readln;
end.