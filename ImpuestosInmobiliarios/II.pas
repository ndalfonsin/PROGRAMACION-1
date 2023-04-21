Program II;
(* Deuda en los ultimos 3 años
Archivo-->
ANIO
codigo deuda anioUltimoPago

leer los que no pagaron impuestos en los ultimos 3 anios, calcular e informar
    -para cada inmueble el importe original y descuento
    -codigo del inmueble con max descuento

Descuento
depende de los anios de atrazo
1--> deuda <=1000 20%  deuda > 1000 15%
2--> deuda <=1000 18%  deuda > 1000 10%
3--> deuda <=1000 12%  deuda > 1000 8%

 *)
const
    maxA=10;
type
    str4=string[4];
    Vstr= Array[1..maxA] of Str4;
    Vbt= Array[1..maxA] of byte;
    Vrl= Array[1..maxA] of real;

var 
    COD: Vstr;
    DEUDA:Vrl;
    ANT:Vbt;
    N, i:byte;
    anioA:integer;

procedure CargaDatos(var COD: Vstr; var DEUDA:Vrl; var ANT:Vbt; var N:byte; var anioA:integer);
    var 
        i:byte;
        Arch:text;
        codigo:String[4];
        importe: real;
        anio: integer;
    begin
        i:=0;
        N:=0;

        Assign(Arch, 'InmueblesD.txt');
        Reset(Arch);

        readln(Arch, anioA);

        while not EOF(Arch) do 
            begin
                readln(Arch, codigo, importe, anio);
                
                if (anioA-anio) <= 3 then
                    begin
                        COD[i]:=codigo;
                        DEUDA[i]:=importe;
                        ANT[i]:= (anioA - anio);
                        i:=i+1;
                    end;   
            end;
        
        N:=i;

        Close(Arch);
    end;

function descuento(monto:real; antiguedad:byte):real;
    const
        tope=1000;        
    var
        desc:real;
    begin
        case antiguedad of
            1:  begin
                    if monto <= tope then
                        desc:= monto*0.20
                    else
                        desc:= monto*0.15;
                end;
            2:  begin
                    if monto <= tope then
                        desc:= monto*0.18
                    else
                        desc:= monto*0.10;
                end;
            3:  begin
                    if monto <= tope then
                        desc:= monto*0.12
                    else
                        desc:= monto*0.08;
                end;
        end;

        descuento:= desc;
    end;

procedure MuestraDatos(COD:Vstr; ANT:Vbt; DEUDA:Vrl; N:byte);
    var
        i, antiguedad, maxdesc:byte;
        monto, condesc, descA, desc:real;


        
    begin
        descA:= 0;
        for i:=1 to N do
            begin
                monto:= DEUDA[i];
                antiguedad:= ANT[i];
                desc:= descuento(monto, antiguedad);
                condesc:= (monto - desc);
                writeln('Codigo de inmueble: ', COD[i]);
                writeln('Monto sin descuento: $', monto:6:2);
                writeln('Monto con descuento: $', condesc:6:2);
                writeln;

                if descA < condesc then
                    maxdesc:=i;
            end;

        writeln('El codigo con mayor descuento es: ',COD[maxdesc],' con un total de $',descuento(DEUDA[maxdesc], ANT[maxdesc]):6:2);
    end;

begin
    CargaDatos(COD, DEUDA, ANT, N, anioA);

    MuestraDatos(COD, ANT, DEUDA, N);

    readln;

end.