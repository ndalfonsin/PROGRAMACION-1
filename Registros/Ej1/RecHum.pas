Program RecHumanos;

{El departamento de Recursos Humanos de una empresa desea que sus empleados fraternicen y decidió cada 3 meses hacer un brindis por 
los que nacieron en esa estación del año. Se pide: 
     Leer los datos  (Nombre del empleado y Fecha de Nacimiento) 
     Informar en qué estación del año se festejan más cumpleaños
}

type
    ST20 = String[20];

    TregF = Record
        DD, MM: byte;
        AAAA: word;
    end;

    TregN = Record
        Nombre: ST20;
        Fecha: TregF;
        Estacion:byte;
    end;

    TV = Array[1..30] of TregN;
    TVEst = Array[1..4] of byte;

var
    Empleados:TV;
    N, est: byte;

Procedure cargaEmpleados(var Empleados: TV; var N: byte);
    var
        Arch : text;
        i:byte;

    begin
        Assign(Arch, 'empleados.txt');
        reset(Arch);
        N:=0;

        while not EOF(Arch) do
            begin
                N:=N+1;
                readln(Arch, Empleados[N].Nombre);
                readln(Arch, Empleados[N].Fecha.DD, Empleados[N].Fecha.MM, Empleados[N].Fecha.AAAA);
                Empleados[N].Estacion:= ((Empleados[N].Fecha.MM + 2) div 3);
            end;
    End;


Function maxEst(Empleados: TV; N:byte):byte;
    var
        i, est, estM, maxP, maxT:byte;
        Estaciones: TVEst;
        MaxEstacion: string;
        
    
    begin
        maxT:=0;
        
        for i:=1 to 4 do
            Estaciones[i]:= 0;

        for i:=1 to N do
            begin
                est:= Empleados[i].Estacion;
                Estaciones[est] := Estaciones[est] + 1;
            end;

        for i:=1 to 4 do
            begin
                maxP:= Estaciones[i];

                if maxP > maxT then
                    begin
                        maxT:=maxP;
                        estM:= Estaciones[i];
                    end;
            end;
        
        maxEst:= est;


        
    end;


begin
    cargaEmpleados(Empleados, N);

    est:= maxEst(Empleados, N);

    case est of 
        1: writeln('La estacion con mas cumpleanios es el verano');
        2: writeln('La estacion con mas cumpleanios es el otronio');
        3: writeln('La estacion con mas cumpleanios es el invierno');
        4: writeln('La estacion con mas cumpleanios es el primavera');
    end;


    readln;
    
end.