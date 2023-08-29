program camisas; 
{
    Un negocio vende camisas, estas pueden ser de hombre o mujer. Los talles que fabrican son: S, M, L y X. El precio base unitario
es de $1000 para hombres y $1200 para mujeres, se debe agregar el IVA de 21%. Hay una promocion en los talles S (hombre) y X (mujer)
con un 5% de descuento. Ademas si la compra supera la docena se considera venta mayorista y obtiene un descuento extra del 7% del total.

    Determinar cuales son los datos necesarios para calcular el importe a facturar en una venta. 
VAR
talle -> S, M, L, X
gen -> M, F
cantCam -> cantidad de camisas de un mismo tipo
cantTot -> cantidad total de camisas de cualquier tipo
total -> $$$$$$$$$$$

CONST
precioM -> 1200
precioH -> 1000
iva -> 1.21
desc -> 0.95
descMay -> 0.93

COND
si ((gen=H) and (talle=s)) or ((gen=M) and (talle=X)) -> desc-> 0.95
si (cantTot>=12) -> descMay -> 0.93

res -> "S" si , "N" no

}

var
    talle, gen, res: char;  // res -> respuesta, variable utilizada para consultar al usuario si quiere comprar mas camisas o no
    cantCam, cantTot: byte;
    compra, total: real; //Valor en $
    chekGen, chekTalle, chekProm, checkMay: boolean; //Chekeos booleanos para validaciones o condicionales

const
    precioM = 1200; //Precio base Mujer
    precioH = 1000; //Precio base Hombre
    iva = 1.21; //compra*iva
    desc = 0.95; //compra*desc
    descMay = 0.93; //compra.descMay

begin
    //Inicializacion de variables
    cantCam:= 0;
    cantTot:= 0;
    total:= 0.0;

    //Header
    writeln('------------------------');
    writeln('|Calculadora de camisas|');
    writeln('------------------------');
    writeln('Talle: S, M, L, X');
    writeln('Genero: Hombre[H], Mujer[M] ');
    writeln();


    //Programa principal
    repeat
        
        //Que genero de camisa desea
        repeat
            write('Que genero de camisa desea comprar?: ');readln(gen);
            gen:= upcase(gen);  
            chekGen := (gen = 'M') or (gen = 'H'); //Condicional de chekeo genero
        until (chekGen);

        //Talle
        repeat
            writeln('Ingrese el talle que desea ingresar');
            write('[S, l, M, X]: ');readln(talle);
            talle:= upcase(talle);
            chekTalle := ((talle = 'S') or (talle = 'M') or (talle = 'L') or (talle = 'X')); //Condicional de chekeo talle
        until (chekTalle);

        writeln();
        writeln('El genero ingresado es ', gen ,' y el talle es ', talle);
        writeln();
        writeln('Cuantas camisas desea comprar?: ');readln(cantCam);

        //Verificar el genero y multiplicar la cantidad para determinar el valor

        if (gen='M') then
            compra:= cantCam * precioM
        else
            compra:= cantCam * precioH;

        //Iva
        compra:= compra*iva;

        //Verificacion si entra en promocion
        chekProm:= (((gen='H')and(talle='S'))or((gen='M')and(talle='X'))); //Chekeo de promocion 
        if (chekProm) then
            compra:= compra * desc;

        //Contador de camisas (Total)
        cantTot:= cantTot + cantCam;
        checkMay:= (cantTot>12);

        if (checkMay) then
            compra:= compra*descMay;

        total:= total + compra;

        write('Desea seguir ingresando productos? [S]si [N]no: ');readln(res);
        
    until (upcase(res) = 'N');

    writeln('Total de la compra: ', total:4:2);
    readln;

end.



