program punto1;
{
Una plataforma de musica mantiene informacion de los temas musicales que han tenido y tienen,
disponibles para la reproduccion de los interpretes contratados en TEMAS.DAT

ARCHIVO TEMAS.DAT con la siguiente informacion y diseño:
    IDINTERPRETE Cadena de 6 (campo de secuencia, clave secundaria)
    GENEROMUSICAL (1..5)
    NOMBRE_TEMA Cadena de 30
    DISPONIBLE S/N
    CANTMG (cantidad de mg del tema)

Por otro lado estan los interpretes en la industria musical INTERPRETES.DAT con la siguiente informacion
y diseño
    IDINTERPRETE Cadena de 6 (campo de secuencia, clave primaria)
    NOMBRE Cadena de 30
    CATEGORIA (1..3, se clasifican segun reproducciones mensuales)

Se pide:
    Para cada interprete contratado de la categoria X, su nombre y los temas musicales disponibles del
    genero Y (si los hubiera, sino informarlo), informando ademas la cantidad de promedio de mg en 
    los temas listados

    Al Final del listado la cantidad de interpretes que no tienen contrato y si se ha detectado algun caso
    de un interprete contratado que no figure en INTERPRETES.DAT


}

type
    TID = string[6];
    TNomb = string[30];

    trTemas = record
        IDINTERPRETE: TID;
        GENERO: byte;
        NOMBRE: TNomb;
        DISP: boolean;
        MG: word;
    end;

    trInterpretes = record
        IDINTERPRETE: TID;
        INTERPRETE: TNomb;
        CATEGORIA: byte;
    end;

    TATemas = file of trTemas;
    TAInt = file of trInterpretes;

Procedure cargaTemas(var temas: TATemas);
    var
        arch: text;
        auxR: trTemas;
        aux: byte; {por como esta armado el archivo}
    begin
        Assign(arch, 'temas.txt');
        Assign(temas, 'temas.dat');
        Reset(arch);
        Rewrite(temas);

        while not EOF(arch) do
            begin
                readln(arch, auxR.IDINTERPRETE, auxR.GENERO);
                readln(arch, auxR.NOMBRE);
                readln(arch, aux, auxR.MG);

                if aux <> 0 then
                    auxR.DISP:= False
                else
                    auxR.DISP:= True;
                
                write(temas, auxR);
            end;

        Close(arch);
        Close(temas);
    end;

Procedure cargaInterpretes(var interpretes: TAInt);
    var
        arch: text;
        auxR: trInterpretes;
    begin
        Assign(arch, 'interpretes.txt');
        Assign(interpretes, 'interpretes.dat');
        Reset(arch);
        Rewrite(interpretes);

        while not EOF(arch) do
            begin
                readln(arch, auxR.IDINTERPRETE, auxR.CATEGORIA);
                readln(arch, auxR.INTERPRETE);

                write(interpretes, auxR);
            end;

        Close(interpretes);   
        Close(arch);   
    end;

Procedure Enfrentamiento(var temas: TATemas; var interpretes: TAInt);
var
    auxRT: trTemas;
    auxRI: trInterpretes;
    catAnalisis, genAnalisis, i, j, contratos: byte;
    acumMG: word;
begin
    Assign(temas, 'temas.dat');
    Assign(interpretes, 'interpretes.dat');
    Reset(temas);
    Reset(interpretes);

    writeln('-------------------------------------------------------');
    writeln('Ingrese la categoria a analizar: (1..3) 0 para salir');
    readln(catAnalisis);

    while catAnalisis <> 0 do
        begin
            writeln('Ingrese el genero a analizar: (1..5) ');
            readln(genAnalisis);
            writeln('-------------------------------------------------------');
            writeln;
            contratos:= 0;

            // Leer todos los registros de interpretes
            while not Eof(interpretes) do
                begin
                    read(interpretes, auxRI);
                    
                    if auxRI.CATEGORIA = catAnalisis then
                        begin
                            writeln('Nombre Interprete: ',auxRI.INTERPRETE);
                            Seek(temas, 0);
                            i := 0;
                            j:= 1;
                            acumMG:= 0;
                            
                            // Leer todos los registros de temas para encontrar coincidencias
                            while not Eof(temas) do
                                begin
                                    read(temas, auxRT);
                                    
                                    if auxRT.IDINTERPRETE = auxRI.IDINTERPRETE then
                                        begin
                                            if auxRT.GENERO = genAnalisis then
                                                begin
                                                    writeln('    ',j,'-', auxRT.NOMBRE);
                                                    j:= j + 1;
                                                    acumMG:= acumMG + auxRT.MG;
                                                end;                                               
                                            
                                            i := 1; // Marcar que se encontró al menos una coincidencia
                                        end;
                                    

                                end;
                            
                            if i = 0 then
                                begin
                                    writeln('NO TIENE CONTRATO');
                                    contratos:= contratos + 1;
                                end
                            else
                                if j = 1 then
                                    writeln('No tiene canciones del genero ', genAnalisis)
                                else
                                    writeln('Promedio de MG:', acumMG/j:4:2);
                            writeln;
                        end;
                    
                end;
            writeln('Interpretes sin contrato: ', contratos);
            writeln();
            // Volver a reiniciar el archivo de interpretes para la siguiente iteración
            Reset(interpretes);
            writeln('-------------------------------------------------------');
            writeln('Ingrese la categoria a analizar: (1..3) 0 para salir');
            readln(catAnalisis);
        end;

    Close(temas);
    Close(interpretes);
end;

var
    temas: TATemas;
    interpretes: TAInt;

begin
    cargaTemas(temas);
    cargaInterpretes(interpretes);
    Enfrentamiento(temas, interpretes);
end.