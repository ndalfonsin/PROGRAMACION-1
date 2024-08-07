Program Final;

type
    str4 = string[4];
    str10 = string[10];
    str15 = string[15];
    str8 = string[8];

    TRP = record
        codPractica: str4;
        descripcion: str10;
        costo: real;
    end;

    TRC = record
        nombreCliente: str10;
        telefono: str15;
        cant_masc: byte;
    end;

    TRV = record
        nombreCliente, nombreMascota: str10;
        codPractica: str4;
        fecha: str8;
        alta: char;
    end;

    TRInfo_masc = record
        nombreMascota: str10;
        mesultP: string;
        total: real;
        alta: char;
    end;


    TRprac = record
        codPractica: str4;
        practico: byte;
    end;        

    TVP = array[1..100] of TRprac;
    TVC = array[1..40] of str10;
    TAP = file of TRP;
    TAC = file of TRC;
    TAV = file of TRV;

var
    practicas: TAP;
    clientes: TAC;
    veterinaria: TAV;
    vP: TVP;
    vC: TVC;
    N, M: byte;

Procedure cargaVet(var veterinaria: TAV);
    var
        arch:text;
        auxR: TRV;
    begin
        Assign(arch, 'veterinaria.txt');
        Rewrite(veterinaria);
        Reset(arch);

        while not EOF(arch) do
            begin
                readln(arch, auxR.nombreCliente);
                readln(arch, auxR.nombreMascota);
                readln(arch, auxR.codPractica);
                readln(arch, auxR.fecha);
                readln(arch, auxR.alta);
                writeln(auxR.alta);
                write(veterinaria, auxR);
            end;
        
        Close(arch);
        Close(veterinaria);
    end;

Procedure cargaPrac(var practicas: TAP);
    var
        arch:text;
        auxR: TRP;
    begin
        Assign(arch, 'practicas.txt');
        Rewrite(practicas);
        Reset(arch);

        while not EOF(arch) do
            begin
                readln(arch, auxR.codPractica, auxR.descripcion);
                readln(arch, auxR.costo);
                write(practicas, auxR);
                writeln(auxR.codPractica);
            end;
        
        Close(arch);
        Close(practicas);
    end;

Procedure cargaCli(var clientes: TAC);
    var
        arch:text;
        auxR: TRC;
    begin
        Assign(arch, 'clientes.txt');
        Rewrite(clientes);
        Reset(arch);

        while not EOF(arch) do
            begin
                readln(arch, auxR.nombreCliente);
                readln(arch, auxR.telefono);
                readln(arch, auxR.cant_masc);
                write(clientes, auxR);
                writeln(auxR.nombreCliente)
            end;
        
        Close(arch);
        Close(clientes);
    end;

Procedure creaVec(var vP: TVP; var N: byte; var practicas: TAP);
    var
        auxR: TRP;
    begin
        Reset(practicas);
        N:=0;
        read(practicas, auxR);

        while not EOF(practicas) do
            begin
                N:= N + 1;
                vP[N].codPractica:= auxR.codPractica;
                vP[N].practico:= 0;
                read(practicas, auxR);
            end;
        Close(practicas);
    end;

Procedure creaVec2(var vC: TVC; var M: byte; var clientes:TAC);
    var
        auxR: TRC;
    begin
        Reset(clientes);
        M:=0;
        read(clientes, auxR);

        while not EOF(clientes) do
            begin
                M:= M + 1;
                vC[M]:= auxR.nombreCliente;
                read(clientes, auxR);
            end;
        Close(clientes);
    end; 

function buscqCli(vC: TVC; M:byte; busq:str10):byte;
    begin
        if M = 0 then
            buscqCli:= 0
        else
            begin
                if vC[M] <> busq then
                    buscqCli:= buscqCli(vc, M-1, busq)
                else
                    buscqCli:= M;
            end;
    end;
function buscqPrac(vP: TVP; N:byte; busq:str10):byte;
    begin
        if N = 0 then
            buscqPrac:= 0
        else
            begin
                if vP[N].codPractica <> busq then
                    buscqPrac:= buscqPrac(vP, N-1, busq)
                else
                    buscqPrac:= N;
            end;
    end;

Procedure ListadoPracticas(vP: TVP; N:byte);
    begin
        writeln('Listado de practicas');
        while N > 0 do
            begin
                if vP[N].practico <> 0 then
                    begin
                        writeln('COD: ',vP[N].codPractica);
                        writeln('Cantidad de practicas historicas: ',vP[N].practico);
                    end;
                N:= N - 1;
            end;
    end;

Procedure Listado(var clientes:TAC; var practicas:TAP; var veterinaria:TAV; N, M: byte; vC: TVC; var vP:TVP);
    var
        auxRP: TRP; auxRC: TRC; auxRV: TRV;
        auxRMasc : TRInfo_masc;
        anio, mes: string;
        total: real;
        erroneos, i, j: byte;
        cor_cli, cor_masc: str10;
        
    begin
        Reset(clientes); Reset(practicas); Reset(veterinaria);
        erroneos:= 0;
        read(veterinaria, auxRV);
        writeln('Informe del registro de practicas en 2024');
        while not EOF(veterinaria) do
            begin
                cor_cli:= auxRV.nombreCliente;
                total:= 0;
                j:= buscqCli(vC, M, auxRV.nombreCliente);

                if j = 0 then
                    begin
                        erroneos:= erroneos + 1;
                        read(veterinaria, auxRV);
                    end
                else
                    begin
                        seek(clientes, j-1);
                        read(clientes, auxRC);
                        writeln('Nombre: ', auxRC.nombreCliente,'   TEL:', auxRC.telefono);
                        writeln('NOMBRE UltMES TOTAL ALTA');
                        while (cor_cli = auxRV.nombreCliente) do
                            begin
                                cor_masc:= auxRV.nombreMascota;
                                auxRMasc.nombreMascota:= auxRV.nombreMascota;
                                auxRMasc.total:= 0;
                                auxRMasc.mesultP:= '0';
                                auxRMasc.alta:= 'N';
                                anio:= auxRV.fecha[1]+auxRV.fecha[2]+auxRV.fecha[3]+auxRV.fecha[4];
                                // writeln(anio);
                                while (cor_masc = auxRV.nombreMascota)and(cor_cli = auxRV.nombreCliente) do
                                    begin
                                        i:= buscqPrac(vP, N, auxRV.codPractica);
                                        
                                        if anio = '2024' then
                                            begin
                                                auxRMasc.nombreMascota:= auxRV.nombreMascota;

                                                if (auxRV.fecha[4] + auxRV.fecha[5]) > auxRMasc.mesultP then
                                                    auxRMasc.mesultP:= (auxRV.fecha[4] + auxRV.fecha[5]);
                                                
                                                seek(practicas, i-1);
                                                read(practicas, auxRP);
                                                
                                                if auxRV.alta = 'S' then
                                                    auxRMasc.alta:= 'S';

                                                auxRMasc.total:= auxRMasc.total + auxRP.costo;
                                            end;
                                        vP[i].practico:= vP[i].practico + 1;
                                        // writeln(vP[i].practico);
                                        read(veterinaria, auxRV);  
                                    end;
                                
                                if auxRMasc.total <> 0 then
                                    begin
                                        write(auxRMasc.nombreMascota,'     ');
                                        write(auxRMasc.mesultP, '    ');
                                        write(auxRMasc.total:3:2,' ');
                                        write(auxRMasc.alta);
                                        writeln;
                                        total:= total + auxRMasc.total;
                                    end;    
                            end;
                    
                        writeln('TOTAL: ', total:5:2);
                        writeln;
                    end;
                
            end;        
        writeln('Errores: ', erroneos);
        writeln;
        ListadoPracticas(vP, N);
        Close(clientes); Close(practicas); Close(veterinaria);
    end;



begin
    Assign(clientes, 'clientes.dat');
    Assign(practicas, 'practicas.dat');
    Assign(veterinaria, 'veterinaria.dat');
    // cargaVet(veterinaria);
    // cargaPrac(practicas);
    // cargaCli(clientes);
    creaVec(vP, N, practicas);
    creaVec2(vC, M, clientes);
    Listado(clientes, practicas, veterinaria, N, M, vC, vP);
    // ListadoPracticas(vP, N);
end.