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
  EDAD: Vbt;
  PESO: Vrl;
  N, CantLug: byte;

procedure CargaDatos(var N: byte; var COD: Vstr; var DNI: Vstr8; var EDAD: Vbt; var PESO: Vrl; var CantLug: byte);
var
  Arch: text;
  i, ed: byte;
  codigo, doc: string;
  kg: real;
  b:char;
begin
  i := 0;
  N := 0;

  Assign(Arch, 'CHECKIN.txt');
  Reset(Arch);

  readln(Arch, CantLug);

  while not EOF(Arch) do
  begin
    i := i + 1;
    readln(Arch, codigo,b, doc, ed, kg);

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

begin
  CargaDatos(N, COD, DNI, EDAD, PESO, CantLug);
end.