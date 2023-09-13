Program silos;

{Una planta de silos registra el ingreso de camiones de sus clientes con cereal, por cada uno se tiene:
    -cliente
    -patente del camion
    -tipo de cereal [1]trigo [2]girasol [3]soja [4]maiz
    -toneladas

Se pide que lea los datos desde un archivo y mediante un menu de opciones interativo calcule e informe: 
    a-Porcentaje de toneladas de cada cereal respecto del total
    b-Dada una patente, si es que existe, decir que tipo de cereal transporta, las toneladas y a que cliente pertenece
    c-Generar un arreglo con los clientes que transportaron mas de X toneladas, ordenado alfabeticamente
    
Generar un archivo de texto que represente los resultados de la busqueda}
Uses
    Crt;
type
    str6 = string[6];
    TVstring = Array[1..10] of string;
    TVstr6 = Array[1..10] of str6;
    TVbyte = Array[1..10] of byte;
    TVreal = Array[1..10] of real;


// Function leeChar():string;
//     var
//         ch:char;
//         cliente: string;
//     Begin
//         cliente:= '';
//         read(arch, ch);
//         while ch<>' ' do    
//             begin
//                 cliente:= cliente + ch;
//                 read(arch, ch);
//             end;
//         leeChar:= cliente;
//     End;

Procedure AsignaArray(var cliente: TVstring; var patente: TVstr6; var tipo: TVbyte; var toneladas: TVreal; linea: string; N:byte);
    var 
        ch: char;
        J: byte;
        aux: string;
        auxbyte: byte;
    begin
        J:= 0;
        ch:= linea[J];

        while ch <> ' ' do
            cliente[N]:= cliente[N] + ch;
            J:= J + 1;
            ch:= linea[J];
        
        patente[N]:= Copy(linea, J, 6);
        auxbyte:= Copy(linea, J+8, 1);
        tipo[N]:= Val(auxbyte, tipo[N]);
        toneladas[N]:= Copy(StrToFloat(linea, J+10, Length(linea)));
    end;

Procedure LecturaArchivo(var cliente: TVstring; var patente: TVstr6; var tipo: TVbyte; var toneladas: TVreal; var N: byte);
var 
    arch: text;
    client, linea: string;
Begin
    N := 1;
    Assign(arch, 'registros.txt');
    Reset(arch);
    
    while not EOF(arch) do
    Begin
        readln(arch,linea);
        AsignaArray(cliente, patente, tipo, toneladas linea, N);
        
        N := N + 1;
    End;

    Close(arch);
End;


Procedure LeeArray(cliente: TVstring; patente:TVstr6; tipo:TVbyte; toneladas:TVreal; N:byte);
    var
        i: byte;
    Begin
        for i:= 1 to N do
            Begin
                writeln('Cliente: ',cliente[i]);
                writeln('Patente: ',patente[i]);
                writeln('Tipo: ',tipo[i]);
                writeln('toneladas: ',toneladas[i]);
                writeln(i);
                writeln;
            End;
            writeln(N);
    End;



var
    cliente: TVstring;
    patente: TVstr6;
    tipo: TVbyte;
    toneladas: TVreal;
    N: byte;

Begin
    LecturaArchivo(cliente, patente, tipo, toneladas, N);
    LeeArray(cliente, patente, tipo, toneladas, N);
    readln();
end.