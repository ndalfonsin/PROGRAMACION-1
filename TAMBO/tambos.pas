program tambos;

(* Una compania lactea recibe la produccion diaria de varios tambos en litros, durante varios
dias consecutivos.

datos:

A |- -codigo de tambo (cadena de 4 caracteres)
   |- -la entrega diaria en litros
    
se pide armar 3 vectores paralelos, COD TOT PROM y ademas calcular e informar:
B   -codigo del tambo que mas leche entrego a la compañia.
C   -cuantos superaron un promedio de X litros de entrega
D   -Dado un codigo, el total y el promedio diario entregado (Si Existe)
 *)

const
    Amax = 20;

type
    Str4 = string[4];
    
    Vstr = Array[1..Amax] of Str4;
    Vrl = Array[1..Amax] of real;
    Vbt = Array[1..Amax] of byte;

var
    N, s, Op, Mb, i, busca: byte;
    COD: Vstr;
    TOT: Vrl;
    ENTREGAS: Vbt;
    x:real;
    codigo:Str4;

// MENU DE OPCIONES
procedure Menu (var Op : byte);
    begin
         Writeln(' ________________________________________');
         Writeln('|      Tambo-Productos lacteos S.A       |');
         Writeln('|                                        |');
         Writeln('|            MENU DE OPCIONES            |');
         Writeln('|                                        |');
         Writeln('| 1- Cod tambo con mayor entrega         |');
         Writeln('| 2- Cantitad Mayor al promedio          |');
         Writeln('| 3- Busqueda por codigo                 |');
         Writeln('| 0- Salir                               |');
         Writeln('|________________________________________|');

         Repeat
           writeln(' ');
           Write('Ingrese su opcion:  ');
           readln(Op);
           writeln;
         until ((Op>=0)And(Op<=3));
    end;


//-----A

function busqueda(N:byte; COD:Vstr; codigo:Str4):byte;
    var 
        i:byte;
    
    begin
        i:=1;

        while (i <= N) and (COD[i] <> codigo) do
            i:= i + 1;

        
        if i <= N then
            busqueda:=i
        else
            busqueda:=0;     
    
    end;

//Carga de datos en los vectores correspondientes
procedure CargaDatos(var COD:Vstr; var TOT:Vrl; var ENTREGAS:Vbt; var N:byte);
    var
        Arch:text;
        codigo: Str4;
        dias, y: byte;
        litros: real;

    
    begin
        Assign(Arch, 'Rtamb.txt');
        reset(Arch);

        N:=0;

        while not eof(Arch) do 
            begin
                readln(Arch, codigo, dias, litros);
                y:=busqueda(N, COD, codigo);
                //Verificacion de si el codigo ya existe o no en el vector
                if y = 0 then
                    begin
                        N:= N+1;
                        COD[N]:= codigo;
                        ENTREGAS[N] := 1;
                        TOT[N] := litros;   
                    end
                else    
                    begin
                        
                        ENTREGAS[y]:=ENTREGAS[y]+1;
                        TOT[y]:= TOT[y] + litros; 
                    end;
                
            end;
        close(Arch);
    end;

//-----B

function maxBusqueda (N:byte; TOT:Vrl):byte;// Indice del codigo con mayor cantidad de entregas en litros
    var 
        maxTot:real;
        i:byte;

    begin
        maxTot:=-9999;

        for i:=1 to N do
            begin
                if TOT[i]> maxTot then
                    maxTot:= i;
            end;
        maxBusqueda:=i;
    end;

//------C

// Calculo de promedio de Litros vendidos sobre la cantidad de entregas
function promedio(N:byte; x:real; TOT:Vrl; ENTREGAS:Vbt):byte;
    var 
        acumP, i:byte;
        prom:real;
    begin
        acumP:=0;
        for i:=1 to (N) do
            begin
                prom:= (TOT[i]/ENTREGAS[i]);

                if prom >= x then
                    acumP:= acumP + 1; 
            end;           
        promedio:=acumP;
    end;

//-----D
//Busqueda de datos a partir de un codigo
procedure datCod(N:byte; COD:Vstr; TOT:Vrl; ENTREGAS:Vbt; codigo:Str4);
    var 
        i:byte;
        prom:real; 
    begin
        i:= busqueda(N, COD, codigo);
        prom:= (TOT[i]/ENTREGAS[i]);
        writeln('Codigo: ',COD[i]);
        writeln('Ventas en L: ', TOT[i]:8:2);
        writeln('El promedio de ventas es: ', prom:4:2);
        writeln;    
    end;

begin

    CargaDatos(COD, TOT, ENTREGAS, N);
    Mb:= maxBusqueda(N, TOT);
    OP:=1;
    
    writeln(maxBusqueda(N,TOT));
    writeln(N);

    for i:=1 to N do
        writeln(COD[i],' ', TOT[i]:4:2,' ', ENTREGAS[i]);

    

    While Op<>0 do
        begin
            Menu(Op);

            case Op of
                1:writeln('El tambo ', COD[Mb], ' es el tambo con mayor entregas');
                2:  begin
                        repeat
                            writeln('Ingrese el promedio medio del cual desea obtener la cantidad de tambos que lo superan: ');read(x);
                        until x>0;

                        writeln('Un total de ',promedio(N, x, TOT, ENTREGAS),' superan el promedio de entregas' );
                    end;
                3:  begin
                        writeln('Ingrese el codigo que desea buscar');read(codigo);
                        codigo:= Upcase(codigo);
                        busca:=busqueda(N, COD, codigo);
                        if busca=0 then
                            writeln('Ha ingresado un codigo incorrecto, no existe ningun tambo con el codigo ',codigo)
                        else
                            datCod(N, COD, TOT, ENTREGAS, codigo);

                        
                    end;
            end;
        end;
readln;
    
end.