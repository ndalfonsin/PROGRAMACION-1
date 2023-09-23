Program RadarDeMultas;
{
En una ruta argentina, se intenta determinar el correcto funcionamiento de un nuevo radar, que detecta la
velocidad a la que circulan los vehículos. En un archivo de texto RADAR.TXT se encuentra la información obtenida
por el radar en un determinado día. El archivo contiene:
    Tipo Vehículo (1-Moto, 2-Auto, 3-Camión)
    Velocidad (expresada en Km/h)
    Zona de la lectura (AN3), ya está validada
    Patente (Cadena de 7)
Se pide desarrollar un programa Pascal, claro y eficiente, que ingrese desde un archivo la información
almacenándola en las estructuras que corresponda, sólo si corresponde a una infracción.
Se entiende por infracción al exceso de velocidad, para Motos > 100 Km/h, para Autos > 110 Km/h y para
Camiones > 90 Km/h.
La multa a abonar por cada infracción es una tasa fija (Motos: $1000, Autos: $2000, Camiones: $5000)
multiplicada por un factor que depende de la zona en la que se produjo. Este factor se obtiene de otro archivo de
texto ZONAS.TXT: 
    ● Zona (AN3)
    ● Coeficiente para multiplicar tasa fija 

a) Cantidad de lecturas del radar que no corresponden a infracciones.
b) Patente de la multa de valor máximo cometida en cada zona (si se repite la multa máxima, tomar la
primera).
c) Cantidad de infracciones de una zona ingresada por teclado (puede no existir).
}

Uses
    crt;
const
    max = 50;
    infAuto = 2000;
    infMoto = 1000;
    infCam = 5000;
type
    STR3 = string[3];
    STR7 = string[7];
    {TV -> tipo vector}
    TVSTR3 = array[1..max] of STR3;
    TVSTR7 = array[1..max] of STR7;
    TVreal = array[1..max] of real;
    TVbyte = array[1..max] of byte;


Procedure CargaDatosZonas(var codZona: TVSTR3; var multZona: TVreal; var Nv2: byte);
    var
        arch: text;
    begin
        Assign(arch, 'ZONAS.txt');
        Reset(arch);
        Nv2:= 0;
        while not EOF(arch) do
            begin
                Nv2:= Nv2 + 1;
                readln(arch, codZona[Nv2], multZona[Nv2]);
            end;
    end;

Procedure CargaDatosRadar(var tipoVehiculo: TVbyte; var vel: TVreal; var zona: TVSTR3; var patente: TVSTR7; var Nv1, contErr: byte);
    var
        arch: text;
        aux: char;
    begin
        Assign(arch, 'RADAR.txt');
        Reset(arch);
        Nv1:= 1;
        contErr:= 0;

        while not EOF(arch) do
            begin
                readln(arch, tipoVehiculo[Nv1], vel[Nv1], aux, zona[Nv1], aux, patente[Nv1]);
                if ((tipoVehiculo[Nv1]=1)and(vel[Nv1]>100))or((tipoVehiculo[Nv1]=2)and(vel[Nv1]>110))or((tipoVehiculo[Nv1]=3)and(vel[Nv1]>90)) then
                    Nv1:= Nv1 + 1
                else
                    contErr:= contErr + 1;
                        
                    
            end;
    end;

Function buscaXzona(codZona: TVSTR3; busqueda: STR3; Nv2:byte):byte;
    var
        i:byte;
    begin
        i:= 1;
        while (codZona[i]<>busqueda)and(i<=(Nv2+1)) do
            i:= i + 1;

        if i= Nv2 + 1 then
            buscaXzona:= 0
        else
            buscaXzona:= i;
    end;


Procedure cargaVectorCosto(var costo: TVreal; tipoVehiculo: TVbyte; zona, codZona: TVSTR3; multZona: TVreal; Nv1,Nv2:byte);
    var
        i:byte;
    begin
        for i:=1 to Nv1 do
            begin
                case tipoVehiculo[i] of
                    1: costo[i]:= infMoto * multZona[buscaXzona(codZona, zona[i], Nv2)];
                    2: costo[i]:= infAuto * multZona[buscaXzona(codZona, zona[i], Nv2)];
                    3: costo[i]:= infCam * multZona[buscaXzona(codZona, zona[i], Nv2)];
                end;
            end;
    end;

Function BuscaElMayorCostoXzona(costo: TVreal; Nv1: byte; zona: TVSTR3; Nv2:byte; codZonaBusq: STR3):byte;
    var
        i: byte;
        costoAnt: real;
    begin
        costoAnt:= 0.0;
        for i:= 1 to Nv1 do
            begin
                if (zona[i] = codZonaBusq)and(costo[i]>costoAnt) then
                    begin
                        costoAnt:= costo[i];
                        BuscaElMayorCostoXzona:= i;
                    end;
            end;
    end;

var
    tipoVehiculo: TVbyte;
    vel, multZona, costo: TVreal;
    zona, codZona: TVSTR3;
    patente: TVSTR7;
    Nv1, Nv2, contErr: byte; {delimitadores de cada tipo de vector paralelo}
    {multZona y codZona pertenecen a Nv2, vector paralelo de almacenamiento de
    multiplicadores de infracciones segun zona}
begin
    CargaDatosZonas(codZona, multZona, Nv2);
    CargaDatosRadar(tipoVehiculo, vel, zona, patente, Nv1, contErr);
    cargaVectorCosto(costo, tipoVehiculo, zona, codZona, multZona, Nv1, Nv2);
    writeln(contErr,' Lecturas del radar no son infracciones');
    writeln('La patente que mas debe pagar en infracciones en la zona ',zona[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[1])],' es "',patente[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[1])],'" con un total de $',costo[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[1])]:4:2);
    writeln('La patente que mas debe pagar en infracciones en la zona ',zona[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[2])],' es "',patente[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[2])],'" con un total de $',costo[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[2])]:4:2);
    writeln('La patente que mas debe pagar en infracciones en la zona ',zona[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[3])],' es "',patente[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[3])],'" con un total de $',costo[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[3])]:4:2);
    writeln('La patente que mas debe pagar en infracciones en la zona ',zona[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[4])],' es "',patente[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[4])],'" con un total de $',costo[BuscaElMayorCostoXzona(costo, Nv1, zona, Nv2, codZona[4])]:4:2);
    readln();
end.