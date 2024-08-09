Program final;

type

    str8 = string[8];

    TRcarpas = record
        carpa: byte;
        DNI: str8;
        consumo: real;
    end;

    TRconsumos = record
        carpa: byte;
        concepto: string;
        importe: real;
    end;

    TAcarpa = file of TRcarpas;
    TAconsumos = file of TRconsumos;

Procedure cargaCarpas(var carpas: TAcarpa);
    var
        arch: text;
        auxR: TRcarpas;
    begin
        Assign(arch, 'carpas.txt');
        Rewrite(carpas);
        Reset(arch);

        while not EOF(arch) do
            begin
                readln(arch, auxR.carpa);
                readln(arch, auxR.DNI);
                readln(arch, auxR.consumo);

                write(carpas, auxR);
            end;

        Close(carpas);
        Close(arch);
    end;

Procedure cargaConsumos(var consumos: TAconsumos);
    var
        arch: text;
        auxR: TRconsumos;
    begin
        Assign(arch, 'consumos.txt');
        Rewrite(consumos);
        Reset(arch);

        while not EOF(arch) do
            begin
                readln(arch, auxR.carpa);
                readln(arch, auxR.concepto);
                readln(arch, auxR.importe);

                write(consumos, auxR);
            end;

        Close(consumos);
        Close(arch);
    end;

Procedure Enfrentamiento(var carpas: TAcarpa; var consumos: TAconsumos; nombre: string);
    var
        erroneos, ratas, carp_no_rata: byte;
        max_consumo, acum: real;
        auxRCa, auxTemp: TRcarpas;
        auxRCo: TRconsumos;
        temp: TAcarpa;
        auxCod: byte;
    begin
        Assign(temp, 'temp.dat');
        Rewrite(temp);
        Reset(carpas);
        Reset(consumos);
        erroneos:= 0;
        ratas:= 0;
        max_consumo:= 0;
        read(carpas, auxRCa);
        read(consumos, auxRCo);
        

        while (not EOF(carpas))or(not EOF(consumos)) do
            begin

                acum:= 0;

                if auxRCa.carpa = auxRCo.carpa then
                    begin
                        while (auxRCa.carpa = auxRCo.carpa)and(auxRCo.importe <> 0) do
                            begin
                                acum:= acum + auxRCo.importe;
                                read(consumos, auxRCo);
                            end;

                        auxRCa.consumo:= auxRCa.consumo + acum;
                        
                        if auxRCa.consumo > max_consumo then
                            begin
                                max_consumo:= auxRCa.consumo;
                                carp_no_rata:= auxRCa.carpa;
                            end;

                        if auxRCo.importe = 0 then
                            begin
                                writeln('Cierre carpa nro: ', auxRCa.carpa);
                                writeln('DNI: ', auxRCa.DNI);
                                writeln('TOTAL: $', auxRCa.consumo:6:2);
                                writeln;
                                read(consumos, auxRCo);
                            end
                        else
                            begin
                                Write(temp, auxRCa);
                            end;
                        read(carpas, auxRCa);
                    end
                else
                    begin
                        if auxRCa.carpa < auxRCo.carpa then
                            begin
                                erroneos:= erroneos + 1;
                                auxCod:= auxRCo.carpa;

                                while auxCod = auxRCo.carpa do
                                    read(consumos, auxRCo);
                            end
                        else
                            begin
                                ratas:= ratas + 1;
                                read(carpas, auxRCa);
                                write(temp, auxRCa);
                            end;
                    end;               

            end;
        writeln('Erroneos: ', erroneos);
        writeln('Carpa con mayor consumo: ', carp_no_rata);
        writeln('Cant de carpas sin consumos en el dia: ', ratas);


        Close(carpas);
        Close(consumos);
        Close(temp);
    end;

var
    carpas: TAcarpa;
    consumos: TAconsumos;

begin
    Assign(carpas, 'carpas.dat');
    Assign(consumos, 'consumos.dat');

    cargaCarpas(carpas);
    cargaConsumos(consumos);
    Enfrentamiento(carpas, consumos, 'new');
end.