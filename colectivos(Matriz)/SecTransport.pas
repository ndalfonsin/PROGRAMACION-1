Program Ej7;

{La Secretaría de Transporte quiere evaluar el movimiento de pasajeros en N paradas de colectivo. En cada una de ellas se detienen M líneas de colectivo.
Dispositivos electrónicos han registrado el movimiento de un día y grabado en un archivo de texto dicha información en tiempo real (desordenada).
En cada registro se expresa:
     
      Parada (1..N)   
      Línea   (1..M)  
      Cantidad de pasajeros que ascienden  
      Cantidad de pasajeros que descienden  
     
Se pide leer la información del archivo, almacenándola de forma adecuada para calcular e informar:   
     
     a) Parada con mayor cantidad de pasajeros que bajaron.  
     b) Línea con menor cantidad de pasajeros que subieron.  
     c) Cantidad de paradas en las cuales el total de personas que subieron fue menor al 40% de las que bajaron.  
     d) Cuántas líneas no registraron subida o bajada de pasajeros en alguna parada.  
Los ítems anteriores se refieren al movimiento de todo el día.   
¿Qué debería agregar/modificar si se pidiera para cada línea o parada promedio de gente que ascendió o descendió cada vez que se detuvo el colectivo}

Type 
    TM = Array[1..4,1..25] of byte;

Const
    Columnas =4;

var 
    pasajeros : TM;
    N, M, i, j, Filas: byte;

Procedure cargaDatos(var pasajeros : TM; var N, M, Filas : byte);
    var 
        arch : text;
        ParadAnt, LineaAnt, i, j : byte;
    begin
        i:=0;
        ParadAnt:=0;
        LineaAnt:=0;
        

        Assign(arch, 'pasajeros.txt');
        Reset(arch);

        while not EOF(arch) do
            begin
                i:=i+1;
                
                for j:=1 to Columnas do
                    begin
                        
                        readln(arch, pasajeros[i,j]);

                        if (j=1)and(pasajeros[i,j]<>ParadAnt) then
                            begin
                                ParadAnt:=pasajeros[i,j];
                                N := N + 1;
                            end
                        else if (j=2)and(pasajeros[i,j]<>LineaAnt) then
                            begin
                                LineaAnt:=pasajeros[i,j];
                                M := M + 1;
                            end;
                    end;
            end;
        
        Filas:=i;     
    end;

Function masDesc(pasajeros : TM; Filas : byte):byte;
    var
        i, maxD, Result : byte;

    begin
        maxD:=0;

        for i:=1 to Filas do
            begin
                if maxD < pasajeros[i,Columnas]
                    begin
                        maxD := pasajeros[i,Columnas];
                        Result := i;
                    end;
                    
            end;

        masDesc:=Result;
    end;



begin
    cargaDatos(pasajeros, N, M, Filas);

    write('La parada con mayor descensos es: ');
    write(pasajeros[1,masDesc(pasajeros, Filas)]);
    writeln;
    {
    for i:=1 to Filas do
        begin
            for j:=1 to Columnas do
                write(pasajeros[i,j], ' ');
            writeln();
        end;
    }

    readln;
end.

