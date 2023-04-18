program tambos;

(* Una compania lactea recibe la produccion diaria de varios tambos en litros, durante varios
dias consecutivos.

datos:

    -codigo de tambo (cadena de 4 caracteres)
    -la entrega diaria en litros
    
se pide armar 3 vectores paralelos, COD TOT PROM y ademas calcular e informar:
    -codigo del tambo que mas leche entrego a la compañia.
    -cuantos superaron un promedio de X litros de entrega
    -Dado un codigo, el total y el promedio diario entregado (Si Existe)
 *)

const
    Amax = 20;

type
    Str4 = string[4];
    
    Vstr = Array[1..Amax] of Str4;
    Vrl = Array[1..Amax] of real;
    Vbt = Array[1..Amax] of byte;

var
    N, s: byte;
    COD: Vstr;
    TOT: Vrl;
    ENTREGAS: Vbt;

function busqueda(N:byte; COD:Vstr; codigo:Str4):byte;
    var 
        i:byte;
    
    begin
        i:=1;

        while (i <= N) and (COD[i] <> codigo) do
            i:= i + 1;

        
        if N<=i then
            busqueda:=0
        else
            busqueda:=i;     
    
    end;

procedure CargaDatos(var COD:Vstr; var TOT:Vrl; var ENTREGAS:Vbt; var N:byte);
    var
        Arch:text;
        codigo: Str4;
        dias, y: byte;
        litros: real;

    
    begin
        Assign(Arch, 'Rtamb.txt');
        reset(Arch);

        N:=1;

        while not eof(Arch) do 
            begin
                readln(Arch, codigo, dias, litros);
                y:=busqueda(N, COD, codigo);

                if y = 0 then
                    begin
                        COD[N]:= codigo;
                        ENTREGAS[N] := 1;
                        TOT[N] := litros; 
                        N:= N+1;
                    end
                else    
                    begin
                        
                        ENTREGAS[y]:=ENTREGAS[y]+1;
                        TOT[y]:= TOT[y] + litros; 
                    end;
                
            end;

    end;


begin

    N:=1;
    CargaDatos(COD, TOT, ENTREGAS, N);
    

    for s:=1 to 4 do
        writeln(COD[s]);
    
    readln;
end.