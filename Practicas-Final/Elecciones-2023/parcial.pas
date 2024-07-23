Program Elecciones;
{
En las ultimas elecciones se almaceno en dos archivos votos_acum.dat y votos_parcial.dat la siguiente informacion (ambos archivos tienen centinela)
    votos_acum
    # Nro de distrito (entero) (campo de secuencia, clave primaria)
    # Partidos (arreglo de 5 elementos, contiene en la posicion i los votos acumulados del partido i)

    votos_parcial
    # Nro de distrito (campo de secuencia, clave secundaria)
    # Nro de partido
    # cant de votos

    Se cuenta ademas con un archivo Distrito.dat (max 50):
    # Nro distrito
    # Nombre (cadena de 15)

se pide definit tipos y
    a) Obtener un archivo votos_acum actualizado, informando el ganador en cada distrito
        Nombre de distrito y partido ganador
    b) Mostrar el siguiente listado solo para aquellos que superaron con mas de X votos
        TOTALES GENERALES POR PARTIDO
        Partido     Totales
        1           999
        2           999
}

type

    TV = array[1..5] of word;


    TRAcum = record
        nro_dis: byte; {1..50 campo de secuencia}
        partidos: TV;
    end;

    TRPar = record
        nro_dis: byte; {campo de secuencia}
        nro_partido: byte;
        votos: word;
    end;

    TRdis = record
        nro_dis: byte; {1..50}
        nombre: string;
    end;

    {No necesito crear un vector para ubicar las posiciones en el registro para el
    enfrentamiento ya que el puntero va a ser el numero de distrito - 1}

    TAACum = file of TRAcum;
    TAPar = file of TRPar;
    TADis = file of TRdis;

procedure cargaAcum(var v_acum: TAACum);
    var
        arch:text;
        auxR: TRAcum;
        i: byte;
    begin
        Assign(arch, 'votos_acum.txt');
        Assign(v_acum, 'votos_acum.dat');
        Reset(arch);
        Rewrite(v_acum);

        while not EOF(arch) do
            begin
                readln(arch, auxR.nro_dis);
                for i:=1 to 5 do
                    read(arch, auxR.partidos[i]);
                readln(arch);
                // writeln(auxR.nro_dis);
                Write(v_acum, auxR);
            end;
        Close(arch);
        Close(v_acum);
    end;

procedure cargaPar(var v_par: TAPar);
    var
        arch: text;
        auxR: TRPar;
    begin
        Assign(arch, 'votos_par.txt');
        Assign(v_par, 'votos_par.dat');
        Reset(arch);
        Rewrite(v_par);

        while not EOF(arch) do
            begin
                readln(arch, auxR.nro_dis);
                readln(arch, auxR.nro_partido);
                readln(arch, auxR.votos);

                Write(v_par, auxR);
            end;
        Close(arch);
        Close(v_par);
    end;

Procedure cargaDis(var distritos: TADis);
    var
        auxR: TRdis;
        arch: text;
    begin
        Assign(arch, 'distritos.txt');
        Assign(distritos, 'distritos.dat');
        Reset(arch);
        Rewrite(distritos);

        while not EOF(arch) do
            begin
                readln(arch, auxR.nro_dis);
                readln(arch, auxR.nombre);
                Write(distritos, auxR);
            end;
        Close(arch);
        Close(distritos);
    end;

Procedure enfrentamiento(var v_acum: TAACum; var v_par: TAPar);
    var
        auxRA: TRAcum;
        auxRP: TRPar;
    begin
        Assign(v_acum, 'votos_acum.dat');
        Assign(v_par, 'votos_par.dat');
        Reset(v_acum);
        Reset(v_par);
        {primero actualizo el archivo mediante el enfrentamiento de v_acum y v_par}
        while not EOF(v_par) do
            begin
                read(v_par, auxRP); {leo el registro con la info para actualizar}
                Seek(v_acum, auxRP.nro_dis - 1); {porque el puntero del arch arranca en 0}
                read(v_acum, auxRA);{leo el registro a actualizar}
                auxRA.partidos[auxRP.nro_partido]:= auxRA.partidos[auxRP.nro_partido] + auxRP.votos;
                Seek(v_acum, (auxRP.nro_dis - 1)); {ES NECESARIO VOLVER A LLAMAR PORQUE ANTERIORMENTE LEIMOS}
                Blockwrite(v_acum, auxRA, 1);{archivo a actualizar, registro actualizado, pos 1}
            end;
        Close(v_par);
        Close(v_acum);
    end;

function BusqMasGrande(arreglo: TV; N: byte):byte;
    var
        aux: word;
        i: byte;
    begin
        aux:= 0;

        while N > 0 do
            begin
                if arreglo[N] > aux then
                    begin
                        aux:= arreglo[N];
                        i:= N
                    end;
                N:= N-1;
            end;

        BusqMasGrande:= i;
    end;

Procedure listadoGanadores(var v_acum: TAACum; var distritos: TADis);
    var
        auxRA: TRAcum;
        auxRD: TRdis;
    begin
        Assign(v_acum, 'votos_acum.dat');
        Assign(distritos, 'distritos.dat');
        Reset(v_acum);
        Reset(distritos);

        {son archivos con los registros en paralelo, por ende no debo comparar si se trata del mismo registro o no, ya que comparten primary key}
        writeln('LISTADO DE GANADORES POR DISTRITO:');
        while not EOF(v_acum) do
            begin
                read(v_acum, auxRA);
                read(distritos, auxRD);
                writeln(auxRA.nro_dis,'- ',auxRD.nombre, ' || Nro: ', BusqMasGrande(auxRA.partidos, 5));
            end;
        Close(v_acum);
        Close(distritos);
    end;

var
    v_acum: TAACum;
    v_par: TAPar;
    distritos: TADis;
begin
    cargaAcum(v_acum);
    cargaPar(v_par);
    cargaDis(distritos);
    enfrentamiento(v_acum, v_par);
    listadoGanadores(v_acum, distritos);
end.
