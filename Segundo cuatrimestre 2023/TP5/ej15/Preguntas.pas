Program pruebas;

Uses
    SysUtils;

// Function leeChar(arch:text):string;
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


// Procedure cargaDatos(var cliente: TVstring; var patente:TVstr6; var tipo:TVbyte; var toneladas:TVreal; var N:byte);
//     var 
//         arch: text;
//     Begin
//         N:= 1;
//         Assign(arch, 'registros.txt');
//         Reset(arch);
//         while not EOF(arch) do
//             Begin
//                 cliente[N]:= leeChar(arch);
//                 read(arch, patente[N], tipo[N], toneladas[N]);
//                 N:= N + 1;
//             End;

//         Close(arch);
//     End;


var
    rl: real;
    str: string;

begin
    str:= '10';
    rl:= StrToFloat(str);
    writeln(rl:2:2);
end.
