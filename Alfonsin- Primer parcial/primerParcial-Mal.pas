Program PrimerParcial;

(*En un archivo de texto, CHECKIN.TXT se encuentran detallados los pasajeros que deben realizar el checkin de un determinado tren turístico.
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
c) Informar el DNI de los 3 pasajeros que llevan mayor peso de equipaje de mano*)

const
  maxA = 20;

type
  Str4 = string[4];
  Str8 = string[8];
  Vstr = array[1..maxA] of Str4;
  Vstr8 = array[1..maxA] of Str8;
  Vbt = array[1..maxA] of byte;
  Vrl = array[1..maxA] of real;

var
  COD: Vstr;
  DNI: Vstr8;
  EDAD, LUGAR: Vbt;
  PESO: Vrl;
  N, i, CantLug: byte;
  codigo:Str4;
  p1, p2: real;

//se me desborda el buffer e intente solucionarlo pero no hay caso, procedo a carga manual
(*
procedure CargaDatos(var N: byte; var COD: Vstr; var DNI: Vstr8; var EDAD: Vbt; var PESO: Vrl; var CantLug: byte);
var
  Arch: text;
  i, ed: byte;
  codigo, doc: string;
  kg: real;
begin
  i := 0;
  N := 0;

  Assign(Arch, 'CHECKIN.txt');
  Reset(Arch);

  readln(Arch, CantLug);

  while not EOF(Arch)do
  begin
    i := i + 1;
    readln(Arch, codigo, doc, ed, kg);

    COD[i] := codigo;
    DNI[i] := doc;
    EDAD[i] := ed;
    PESO[i] := kg;
  end;

  Close(Arch);
  N := i;

  for i := 1 to N do
    writeln(COD[i], ' ', DNI[i], ' ', EDAD[i], ' ', PESO[i]:0:2, ' ', CantLug);
end;

*)

procedure cargaManual(var N: byte; var COD: Vstr; var DNI: Vstr8; var EDAD: Vbt; var PESO: Vrl; var CantLug: byte);
    begin
        COD[1] := 'A001';
        COD[2] := 'A001';
        COD[3] := 'A001';
        COD[4] := 'B001';
        COD[5] := 'B001';
        COD[6] := 'C001';
        COD[7] := 'D001';
        COD[8] := 'D001';
        DNI[1] := '50101001';
        DNI[2] := '50101002';
        DNI[3] := '50101003';
        DNI[4] := '50101004';
        DNI[5] := '50101005';
        DNI[6] := '50101006';
        DNI[7] := '50101007';
        DNI[8] := '50101008';
        EDAD[1] := 21;
        EDAD[2] := 22;
        EDAD[3] := 23;
        EDAD[4] := 24;
        EDAD[5] := 25;
        EDAD[6] := 26;
        EDAD[7] := 27;
        EDAD[8] := 28;
        PESO[1] := 5;
        PESO[2] := 0;
        PESO[3] := 5;
        PESO[4] := 15;
        PESO[5] := 1;
        PESO[6] := 7;
        PESO[7] := 10;
        PESO[8] := 11;
        N := 8;
        CantLug:= 20;
    end;

procedure AsignacionLugar(COD: Vstr; DNI: Vstr8; CantLug: byte; N: byte; var LUGAR:Vbt);
    var
        i, contas, contdes:byte;
        codAnt:Str4;
    begin
        codAnt:='A001';
        contas:=0;
        contdes:=CantLug;

        for i:=1 to N do
            begin
                if COD[i] = codAnt then
                    begin
                        contas:= contas + 1;
                        LUGAR[i]:= contas;
                    end
                else
                    begin
                        LUGAR[i]:= contdes;
                       contdes:= contdes - 1;
                    end;
                codAnt:= COD[i];
            end;
    end;

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

procedure BuscaLugar(codigo:Str4; COD:Vstr);
    var
        busca, lug:byte;
        codbus:Str4;

    begin
        busca:= busqueda(N, COD, codigo);

        if busca = 0 then
            writeln('El codigo ingresado no hizo el checkin')
        else
            codbus:= COD[busca];
            lug:= LUGAR[busca];
            writeln('El codigo de checkin nro ',codbus,' tiene asignado el asiento: ', lug);
        writeln;
    end;

function promedio(p1, p2:real; PESO:Vrl; EDAD:Vbt; N:byte):real;
    var
        prom, p:real;
        i, sumaed, cant:byte;
    begin
        for i:= 1 to N do
            begin
                p:= PESO[i];
                sumaed:= 0;
                cant:=0;

                if (p1<p)and(p<p2) then
                    begin
                        sumaed:= sumaed + EDAD[i];
                        cant:= cant + 1;
                    end;
            end;
            

        prom:= sumaed/cant;
        promedio:= prom;
    end;

procedure Pesos(p1, p2: real; PESO:Vrl; EDAD:Vbt; N:byte);
    var 
        prom:real;
    
    begin
        prom:= promedio(p1, p2, PESO, EDAD, N);

        writeln('El promedio de edades entre los pesos ',p1:2:2,' y ',p2:2:2,' es: ', prom:2:2);
    end;

    
begin
    cargaManual(N, COD, DNI, EDAD, PESO, CantLug);
    AsignacionLugar(COD, DNI, CantLug, N, LUGAR);
    
    writeln('Ingrese el codigo que desea buscar para obtener su lugar: ');
    readln(codigo);
    codigo:= Upcase(codigo);
    writeln;

    BuscaLugar(codigo, COD);
    writeln;

    writeln('Ingrese el peso 1: ');
    readln(p1);
    writeln('Ingrese el peso 2: ');
    readln(p2);
    writeln;

    Pesos(p1, p2, PESO, EDAD, N);
    writeln;

end.
