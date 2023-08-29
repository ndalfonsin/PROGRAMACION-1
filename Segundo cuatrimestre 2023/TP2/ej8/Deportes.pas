program Deportes; 

{
    Un club cobra a sus socios una cuota basica por mes que incluye dos deportes, su costo depende de la edad del socio

        -si es mayor de 18: $1800
        -si esta entre 13 y 18: $1200
        -si esta entre 5 y 12: $750
        -en otro caso no paga

    Ademas se cobra $250 extra por cada deporte que se quiera agregar excepto natacion que tiene un valor de $800

    Si la cuota se paga despues del dia 15 entonces tendra un recargo del 5%
}

var
    edad, cantDep, diaPago: byte;
    tipo: char;
    precio: real;
    chekDep: boolean;
const
    cuotaAdulto = 1800;
    cuotaAdolec = 1200;
    cuotaNinos = 750;
    depotAd = 250;
    natacion = 800;
    segQuincena = 1.05; 
begin
    precio := 0.0;
    tipo := ' ';
    cantDep := 0;

    writeln('Calculadora de Cuota | Club de deportes');
    write('Ingrese la edad del socio: '); readln(edad);

    if edad >= 18 then
        precio := cuotaAdulto
    else if ((edad<=17)and(edad>=13)) then
        precio := cuotaAdolec
    else if ((edad<=12)and(edad>=5)) then
        precio := cuotaNinos;
    
    writeln;
    writeln('Debera ingresar los deportes que practica: ');
    

    while upcase(tipo) <> 'S' do
        begin
            writeln('[N] natacion [F] futbol [B] basket [T] tenis [D] danza [S] SALIR ');
            repeat
                readln(tipo);
                tipo := upcase(tipo);
                chekDep:= ((tipo='S')or((tipo='N')or(tipo='F')or(tipo='T')or(tipo='D')or(tipo='B')));
            until (chekDep);
            
            if tipo <> 'S' then
                begin
                    cantDep:= cantDep + 1;

                    if cantDep > 2 then
                        begin
                            if tipo = 'N' then
                                precio:=precio + natacion
                            else 
                                precio:= precio + depotAd;
                        end
                end;
        end;

    writeln;
    writeln('Ha ingresado ',cantDep,' deportes');
    write('Ingrese la fecha de pago: '); readln(diaPago);

    if diaPago>15 then
        precio := precio * segQuincena;

    writeln;
    writeln('El cliente debe abonar un total de: $',precio:4:1);
    readln;    
end.