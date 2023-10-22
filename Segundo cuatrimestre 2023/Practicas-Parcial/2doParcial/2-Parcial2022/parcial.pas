Program Parcial2022;

{Un edificio de departamentos de N pisos registra información respecto a los ocupantes de cada 
departamento(son 6 departamentos por piso). Esta información se encuentra en un archivo de texto 
OCUPANTES.TXT. El archivo no está ordenado por ningún criterio y no se registra información de los 
departamentos desocupados. La primera línea contiene el valor de N, y desde la segunda línea cada una 
contiene los siguientes datos: 
    • Piso (1..N) 
    • Departamento (1..6) 
    • Apellido del ocupante responsable (cadena de 12) 
    • Categoría (cadena de 3, referencia en archivo CATEGORIAS.TXT) 
    • Cantidad de ocupantes del departamento 
    • Propietario (S/N) 

El archivo CATEGORIAS.TXT posee los siguientes datos: 
    • Código (cadena de 3) 
    • Descripción 
    • Importe mensual expensas. Los propietarios tienen un 10% de descuento. 

Se pide leer los datos y almacenarlos en estructuras adecuadas. Luego, obtener e informar: 
    a) Cuántos pisos tienen todos sus departamentos ocupados por más de 2 personas. 
    b) Dada una categoría CATEG ingresada por teclado calcular lo que debería abonarse en 
concepto de expensas en un mes para dicha categoría. 
    c) Generar un arreglo con los apellidos y pisos de los ocupantes que son propietarios de los 
departamentos identificados con un número (entre 1 y 6) ingresado por teclado. Luego 
mostrar el arreglo generado. 

Condición para aprobar: los siguientes subprogramas (función o procedimiento, según corresponda), 
necesarios para resolver el problema planteado, deben ser resueltos correctamente en forma recursiva: 
    - Verificar si determinado piso tiene todos sus departamentos ocupados con más de 2 personas (para el 
inciso a) 
    - Contar departamentos ocupados en todo el edificio para determinada categoría (discriminado en 
propietarios y no propietarios) (para el inciso b) }

type
    str12 = string[12];
    str3 = string[3];

    Treg2 = record
        cod: str3;
        monto: real;
    end;

    Treg = record
        apellido: str12;
        cat: str3;
        cantOc: char;
        Prop: char;
    end;

    matReg = array[1..3,1..6] of Treg;
    arry = array[1..3] of Treg2;

const
    M = 6;

{Seteamos la cantidad de hab en 0 para luego determinar cuales estan ocupados}
Procedure seteoMatriz(var edificio: matReg; N,M,aux:byte);
    begin
        if N>0 then
            begin
                if M=1 then
                    begin
                        edificio[N,M].cantOc:= '0';
                        // write(edificio[N,M].cantOc,' ');
                        // writeln;
                        seteoMatriz(edificio, N-1, aux, aux);
                    end
                else
                    begin
                        edificio[N,M].cantOc:= '0';
                        // write(edificio[N,M].cantOc, ' ');
                        seteoMatriz(edificio, N, M-1, aux);
                    end;
            end;
    end;

Procedure CargaEdificio(var edificio: matReg; var N:byte; M:byte);
    var
        arch:text;
        aux:char;
        i, j, err: byte;
        lectura: string;
    begin
        Assign(arch, 'ocupantes.txt');
        Reset(arch);
        
        readln(arch, N);
        seteoMatriz(edificio, N, M, M);

        while not EOF(arch) do
            begin
                lectura:='';
                read(arch, i, j, aux);
                
                read(arch, aux);
                
                // repeat
                //     lectura:= lectura + aux;
                //     read(arch, aux);    
                // until ((aux>='0')and(aux<='9'));
                
                
                while ((aux >= 'A')and(aux <= 'z'))or(aux = ' ') do
                    begin    
                        lectura:= lectura + aux;
                        read(arch, aux);
                    end;
                writeln(lectura);
                // val(aux, edificio[i,j].cantOc, err);
                edificio[i,j].cantOc:= aux;
                edificio[i,j].cat:= copy(lectura, Length(lectura)-3, 3);
                // writeln(edificio[i,j].cat);
                edificio[i,j].apellido:= copy(lectura, 1, Length(lectura)-5);
                // writeln(edificio[i,j].apellido);
                read(arch, aux, edificio[i,j].Prop);
                readln(arch);
            end;
        

        Close(arch);
    end;

procedure muestraMatriz(edificio: matReg; N, M, aux: byte);
begin
    if N > 0 then
        begin
            if M = 1 then
                begin
                    write(edificio[N, M].cantOc);
                    writeln;
                    muestraMatriz(edificio, N-1, aux, aux);
                end
            else
                begin
                    write(edificio[N, M].cantOc);
                    muestraMatriz(edificio, N, M-1, aux);
                end;
        end;
end;

Function cuentaPersonas(edificio: matReg; N,M,aux: byte):byte;
    begin
        if N > 0 then
            begin
                if edificio[N,M].cantOc > '2' then
                    begin
                        if M = 1 then
                            cuentaPersonas:= 1 + cuentaPersonas(edificio, N-1, aux, aux)
                        else
                            cuentaPersonas:= cuentaPersonas(edificio, N, M-1, aux);
                    end
                else
                    cuentaPersonas:= cuentaPersonas(edificio, N-1, aux, aux);
            end
        else
            cuentaPersonas:= 0;
    end;

Procedure cargaCat(var categorias:arry; var C:byte);
    var
        arch: text;
        aux: str12;
        auxCh: char;
    begin
        Assign(arch, 'categorias.txt');
        Reset(arch);
        C:= 0;

        while not EOF(arch) do
            begin
                C:= C + 1;
                readln(arch, categorias[C].cod, auxCh, aux, categorias[C].monto);
            end;

        Close(arch);
    end;

function BusquedaXCod(categorias: arry; C:byte; X: str3):byte;
    begin
        if C > 0 then
            begin
                if categorias[C].cod <> X then
                    BusquedaXCod:= BusquedaXCod(categorias, C-1, X)
                else
                    BusquedaXCod:= C
            end
        else
            BusquedaXCod:= 0;
    end;


Function IncisoBrec(edificio: matReg; N, M, aux: byte; cd:str3; monto: real):real;
    begin
        if N > 0 then
            begin
                if M = 1 then
                    IncisoBrec:= IncisoBrec(edificio, N-1, aux, aux, cd, monto)
                else
                    IncisoBrec:= IncisoBrec(edificio, N, M-1, aux, cd, monto);

                if edificio[N, M].cat = cd then
                    begin
                        if edificio[N, M].Prop = 'S' then
                            IncisoBrec:= IncisoBrec + (monto*0.90)
                        else
                            IncisoBrec:= IncisoBrec + monto;
                    end;
            end
        else
            IncisoBrec:= 0;
    end;

Procedure IncisoB(edificio: matReg; N, M, C: byte; categorias: arry);
    var
        cod: str3;
        monto: real;
    begin
        repeat
            write('Ingrese el codigo que desea buscar: ');readln(cod);
            cod:= upcase(cod);
        until (BusquedaXCod(categorias, C, cod) <> 0);

        monto:= categorias[BusquedaXCod(categorias, C, cod)].monto;

        writeln('Se debe abonar $',IncisoBrec(edificio, N, M, M, cod, monto):4:2);

    end;



var
    edificio: matReg;
    N, C: byte;
    categorias: arry;

begin
    CargaEdificio(edificio, N, M);
    muestraMatriz(edificio, N, M, M);   
    writeln(edificio[1,1].apellido);
    writeln('Inciso A:',cuentaPersonas(edificio, N, M, M));
    writeln;
    cargaCat(categorias, C); 
    IncisoB(edificio, N, M, C, categorias);

end.
