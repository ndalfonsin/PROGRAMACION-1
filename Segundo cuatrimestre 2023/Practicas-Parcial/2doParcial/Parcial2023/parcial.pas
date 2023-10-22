Program SegundoParcial2023;

type
    Treg = record
        nivel, totAutos: byte;
        tiempo: real;
    end;

    matByte = array[1..5,1..3] of byte;
    matReal = array[1..5,1..3] of Real;
    matReg = array[1..5] of Treg;
 
const
    matAutos: matByte = (
        (4,5,15),
        (1,0,3),
        (10,3,9),
        (6,8,7),
        (2,1,3)
    );

    matHoras : matReal = (
        (9.5,15,20),
        (5,0,24),
        (15.3,10.5,9),
        (12,11,14),
        (4,1,6.5)
    );

    M = 3;
    N = 5;

Procedure NuevaMatriz(matAutos: matByte; matHoras: matReal; var VNiveles: matReg; N, M:byte; var G: byte);
    var
        i, j, cantA: byte;
        cantHoras: real;
        plazasOc: boolean;
    begin
        G:= 0;
        for i:= 1 to N do
            begin
                plazasOc:= False;
                cantA:= 0;
                cantHoras:= 0;
                for j:=1 to M do
                    begin
                        if matAutos[i,j] = 0 then
                            plazasOc:= true
                        else
                            begin
                                cantA:= cantA + matAutos[i,j];
                                cantHoras:= cantHoras + matHoras[i,j];
                            end;
                    end;
                if not plazasOc then
                    begin
                        G:= G + 1;
                        VNiveles[G].nivel:= i;
                        VNiveles[G].totAutos:= cantA;
                        VNiveles[G].tiempo:= cantHoras / cantA;
                    end;
            end;
    end;

procedure MuestraVec(VNiveles: matReg; G:byte);
    begin   
        if G > 0 then
            begin
                MuestraVec(VNiveles, G-1);
                writeln('Nivel: ',VNiveles[G].nivel);
                writeln('TotAutos: ',VNiveles[G].totAutos);
                writeln('Horas promedio: ',VNiveles[G].tiempo:4:2);
                writeln;
            end;
    end;

function OcXPlaza(matAutos: matByte; N, M, aux, X: byte): byte;
    begin
        if N > 0 then
            begin
                if matAutos[N, M] >= X then
                    begin
                        OcXPlaza := 1 + OcXPlaza(matAutos, N - 1, aux, aux, X);
                    end
                else
                    begin
                        if M > 1 then
                            OcXPlaza := OcXPlaza(matAutos, N , M - 1, aux, X)
                        else
                            OcXPlaza := OcXPlaza(matAutos, N - 1, aux, aux, X);
                    end;
            end
        else
            begin
                OcXPlaza := 0;
            end;
    end;

procedure IncisoB(matAutos: matByte; N, M: byte);
    var
        X, aux: byte;
    begin
        write('Ingrese la cantidad de autos que desea verificar que plazas cumple: ');
        readln(X);
        aux:= M;

        writeln('La cantidad de plazas que superan los ',X,' autos son: ',OcXPlaza(matAutos, N, M, aux, X));


    end;



var
    VNiveles: matReg;
    G: byte; {contador de VNiveles}
begin
    NuevaMatriz(matAutos, matHoras, VNiveles, N, M, G);
    MuestraVec(VNiveles, G);
    IncisoB(matAutos, N, M);
end.
