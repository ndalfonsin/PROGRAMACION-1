program Notas;

//la cantidad de notas por alumno viene en la primera linea del archivo txt [M]

type
    TM = Array[1..15,1..15] of integer;
    TV = Array[1..15] of String;

var 
    VAlumno, Promocionados : TV;
    MNotas : TM;
    i, N, M: byte;

procedure cargaDatos(var VAlumno : TV; var MNotas : TM; var N, M :byte);
    var
        i, j, k : byte;
        notas: text;
        aux : char;

    begin
        i := 0;
        Assign(notas, 'alumnos-notas.txt');
        reset(notas);
        readln(notas, M);

        while not EOF(notas) do
            begin
                i:= i + 1;
                readln(notas, VAlumno[i]);
                
                for j:=1 to M do
                    read(notas, MNotas[i,j], aux);
                    
                readln(notas);
                
            end;
        
        N := i;

        writeln('Se han cargado los siguientes datos');
        writeln;

        for j:=1 to N do
            begin
                write(VAlumno[j], ' ');

                for k:=1 to M do
                    write(MNotas[j,k], ' ');
                writeln;
            end;

    end;

// Listado de los alumnos que aprobaron los k examenes

procedure Aprobados(VAlumno : TV; MNotas: TM; M, N : byte);
    var
        i, j: byte;
        VoF : boolean;

    begin
        writeln;
        writeln('Aprobados: ');
        i:=0;
        while i < N do
            begin
                i:= i + 1;

                VoF:= True;

                for j:=1 to M do
                    if MNotas[i,j]<5 then
                        VoF:= False;

                if VoF = True then 
                    writeln(VAlumno[i]);
                    
            end;
    end;

// PROMEDIO, se calcularan por fila I ingresa en el bucle en el que se llama la funcion

function Promedio(MNotas: TM; i, M:byte):real;
    var
        j, acum:byte;
        
    begin
        acum:= 0;
        for j:=1 to M do
            acum:= acum + MNotas[i,j];
        Promedio:= acum / M;
    end;

procedure sitAlumno(var Promocionados: TV; VAlumno : TV; MNotas: TM; M,N:byte);
    var
        i, k: byte;
        prom: real;

    begin
        k:= 0;

        for i:=1 to N do
            begin
                prom:= Promedio(MNotas, i, M);
                if prom >= 7 then
                    begin
                        k:= k + 1;
                        Promocionados[k]:= VAlumno[i];
                        
                        writeln(VAlumno[i], ' Promociona con promedio ',prom:2:1);
                        writeln;
                    end
                else if (5<=prom)and(prom<7) then
                    begin
                        writeln(VAlumno[i], ' Hablita con promedio ',prom:2:1);
                        writeln;
                    end
                else
                    begin
                        writeln(VAlumno[i], ' Desaprueba con promedio ',prom:2:1);
                        writeln;
                    end;
            end;

        //muestro vector de Promocionados

        for i:=1 to k do
            writeln(Promocionados[i]);
    end;

begin
    cargaDatos(VAlumno, MNotas, N, M);
    Aprobados(VAlumno, MNotas, M, N);
    writeln;
    sitAlumno(Promocionados, VAlumno, MNotas, M, N);
    readln;
end.