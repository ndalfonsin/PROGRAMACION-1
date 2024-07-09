Program atletismo;

Uses
    crt;

Const
    max = 10;

Type
    string10 = String[10];
    TVstring = Array[1..max] of string10;
    TVreal = Array[1..max] of real;

Procedure cargaDatos(var nombre: TVstring; var lanz1, lanz2: TVreal; var N:byte);
    var
        arch: text;
        aux: char;
    begin
        Assign(arch, 'lanzamientos.txt');
        Reset(arch);
        N:= 0;

        while not EOF(arch) do
            begin
                N:= N + 1;
                readln(arch, nombre[N], lanz1[N], lanz2[N]);
            end;
        Close(arch);
    end;

Procedure recorreArrayString(nombre: TVstring; N:byte);
    var
        i: byte;
    begin
        for i:=1 to N do
            writeln(nombre[i]);
    end;

Function superacion(lanz1, lanz2: TVreal; N:byte):byte;
    var
        i: byte;
    begin
        superacion:= 0;

        for i:=1 to N do
            begin
                if (lanz2[i] > lanz1[i]) then
                    superacion:= superacion + 1; 
            end;
    end;

Function promedio(lanz1, lanz2: real):real;
    begin
        promedio:= (lanz1 + lanz2)/2;
    end;

Function mejorMarca(lanz1, lanz2: TVreal; N:byte):byte;
    var
        i: byte;
        aux: real;
    begin
        aux:= 0.0;
        for i:=1 to N do
            begin
                if aux < promedio(lanz1[i],lanz2[i]) then
                    begin
                        mejorMarca:= i;
                        aux:= promedio(lanz1[i],lanz2[i]);
                    end;
            end;
    end;

Function borraEspacios(str:string):string;
    var
        ch: char;
        i: byte;
    begin
        borraEspacios:= '';
        for i:= 1 to Length(str) do
            begin
                
                ch:= str[i];

                if ch <> ' ' then
                    borraEspacios:= borraEspacios + ch;
            end;
    end;

Function buscaXnombre(nombre: TVstring; busqueda:string; N:byte):byte;
    var
        i:byte;
    begin
        i:= 1;
        while (busqueda <> borraEspacios(nombre[i]))and(i<=N) do
            i:= i + 1;

        if i=N+1 then
            buscaXnombre:= 0
        else
            buscaXnombre:= i;
    end;

Procedure datosXnombre(nombre: TVstring; lanz1, lanz2:TVreal; N:byte);
    var
        busqueda: string;
        indice: byte;
    begin
        write('Ingrese el nombre que desea buscar: ');readln(busqueda);
        indice:= buscaXnombre(nombre, busqueda, N);
        if indice <> 0 then
            begin
                writeln('Primer lanzamiento ',lanz1[indice]:4:2);
                writeln('Segundo lanzamiento ',lanz2[indice]:4:2);
            end
        else
            writeln('No se ha encontrado un competidor con ese nombre');    
    end;

Procedure menu();
    begin
        ClrScr;
        writeln('Competencia de atletismo');
        writeln('1-Cantidad de competidores que superaron el 1er lanzamiento con el 2do');
        writeln('2-Atleta con mejor marca');
        writeln('3-Busca x Nombre');
        writeln('4-Muestra semifinalistas');
        writeln('0-Salir');
    end;

Procedure main(var nombre: TVstring; var lanz1, lanz2: TVreal; var N:byte);
    var
        op: byte;
    begin
        cargaDatos(nombre, lanz1, lanz2, N);
        repeat
            menu();
            writeln;
            write('Ingrese su opcion: ');readln(op);

            ClrScr;
            Case op of 
                1: writeln('La cantidad de atletas que superaron el primer lanzamiento con el segundo son: ',superacion(lanz1,lanz2,N));
                2: writeln('El participante ganador es: ',nombre[mejorMarca(lanz1, lanz2, N)]);
                3: datosXnombre(nombre, lanz1, lanz2, N);
                4: ;
            end;

            if op <> 0 then
                begin
                    writeln('Presione enter para volver al menu');Readln();
                end;
        until (op = 0);
    end;

Var
    nombre: TVstring;
    lanz1, lanz2: TVreal;
    N: byte;

Begin 
    main(nombre, lanz1, lanz2, N);
End.
