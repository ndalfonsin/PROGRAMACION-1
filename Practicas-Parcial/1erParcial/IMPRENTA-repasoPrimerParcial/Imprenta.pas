program Imprenta;


(*Una imprenta realiza folletos y su costo depende de la cantidad de palabras, del tipo y tamaño de letra.
    Archivo de texto --> Tipo (A,B,C), luego un blanco, el tamaño (1,2), blanco, secuencia de caracteres finalizadas con punto.
                A 2 xxxxxx xxxxxxxx x xx xxxxxx.
                
Generar 3 arreglos Costo, CantPal y MasLarga, contendran de cada folleto su costo, la cantidad de palabras y la cantidad de 
caracteres de la palabra mas larga.

costo--> se calcula de la siguiente manera : $1 la palabra, dependiendo del tipo A (duplica el importe), B (triplica), C (quintuplica).
 Si el tamaño es 2 tiene un costo adicional del 50%
 
 -Indicar el costo del folleto que contenga la palabra mas larga, si hay mas de uno el  costo promedio de los mismos.
 -Para un entero N que ingresa por teclado,  buscar  el primer folleto que contenga exactamente N palabras y mostrar  
 su costo. (considerar que puede no existir) 
*)
const 
    maxA=20;
    X=1;

type
    Vrl = Array[1..maxA] of real;
    Vbt = Array[1..maxA] of byte;

var
    MasLarga,CantPal:Vbt;
    Costo:Vrl;
    tam, N, i, MaxL, Y, busq: byte;
    importe:real;



function cost(cantP,tam:byte; tipo:char):real;
    begin
        importe:=cantP*X;

        case tipo of
            'A': importe:= importe*2;//duplica
            'B': importe:= importe*3;//triplica
            'C': importe:= importe*5;//quintuplica
        end;

        if tam = 2 then
            importe:= importe*1.5;

        cost:=importe;
    end;

function maxTam(MasLarga:Vbt; N:byte):byte;
var
  i, max, Z: byte;
begin
  max := 0;
  Z := 0;
  
  for i := 1 to N do 
  begin
    if MasLarga[i] > max then
    begin
      max := MasLarga[i];
      Z := i;
    end;
  end;

  maxTam := Z;
end;


function promedio(importe:real; cant:byte):real;
    var
        prom:real;
    
    begin
        prom:= importe/cant;
        promedio:= prom;
    end;

function busqueda(N:byte; CantPal:Vbt; Costo:Vrl; Y:byte):byte;
    var 
        i:byte;
    
    begin
        i:=1;

        while (i <= N) and (CantPal[i] <> Y) do
            i:= i + 1;

        
        if i <= N then
            busqueda:=i
        else
            busqueda:=0;     
    
    end;

procedure cargaDatos(var CantPal, MasLarga: Vbt; var Costo:Vrl; var N:byte);
    var
        i, cantLetras,cantLetrasA, cantP, tam:byte;
        ch, tipo:char;
        Arch:text;

    begin
        Assign(Arch, 'frasesFolleto.txt');
        Reset(Arch);
        i:=1;

        while not EOF(Arch) do
            begin
                cantLetras:=0;
                cantLetrasA:=0;
                cantP:=0;

                read(Arch, tipo, tam, ch, ch);
               
                
                
                while ch<>'.' do
                    begin
                        while (ch <> ' ')and(ch<>'.' ) do
                            begin
                                cantLetras:= cantLetras + 1;
                                read(Arch, ch);                                          
                            end;     
                        cantP:= cantP + 1;
                        

                        if cantLetras > cantLetrasA then
                            cantLetrasA:=cantLetras;
                        if (ch<>'.') then
                            read(Arch, ch);
                    end;
                readln(Arch);
                CantPal[i]:= cantP;
                MasLarga[i]:=cantLetrasA;
                Costo[i]:= cost(cantP, tam, tipo);
                N:=i;
                i:=i+1;
                
            end;
        Close(Arch);


    end;

begin
    cargaDatos(CantPal, MasLarga, Costo, N );

    MaxL:= maxTam(MasLarga, N);

    Writeln('El costo de la frase con la palabra mas larga de todas (',MasLarga[MaxL],') es de $',Costo[MaxL]:4:2);

    Writeln('Ingresame el numero de palabras para obtener su costo: ');
    readln(Y);
    busq:=busqueda(N, cantPal, Costo, Y);

    if (busq=0) then
        writeln('No se ha encontrado un resultado')
    else    
        writeln('Costo: $', Costo[busq]:4:2);

    readln;



end.