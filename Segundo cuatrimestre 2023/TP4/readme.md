# Subprogramas
La solucion de un problema puede abarcar varios aspectos o etapas bien diferenciados, cada una puede ser implementada como un proceso individual, la union de todos ellos lleva a la solucion del problema completo

### Cohesión y Acoplamiento
En la programacion modular, se persigue obtener alta cohesion y bajo acoplamiento

## FUNCIONES
Es un modulo de programa que realiza una tarea especifica y devuelve un unico valor(de tipo simple) en el nombre.

        Function NombFun (par:type; par2:type): type
            var
                {Seccion declarativa}
            begin
                {Seccion ejecutable}
                NombFun:= result; {Return}
            end;

        variable:= NomFun(par, par2);
        writeln(variable);

### Ejemplos de funciones

Funcion booleana que indica si un caracter es vocal
    
    Program Vocales;

    Funtion EsVocal(Letra:char): boolean;
        Begin
            Letra:= upcase(Letra);
            EsVocal = (Letra = 'A') or (Letra = 'E') or (Letra = 'I') or (Letra = 'O') or (Letra = 'U')
        End;

    var
        Letra:= char;
    Begin
        write('Ingrese una letra');readln(Letra);
        if Esvocal(Letra) then
            writeln('La letra ingresada es vocal')
        else
            writeln('La letra ingresada no es vocal');
    End.

## PROCEDIMIENTOS
Es un modulo de codigo independiente que se ejuta cuando es invocado o llamado por otro proceso, para realizar una tarea especifica `Lectura` `Escritura` `Menus`

    Procedure identificador(lista de parametros);
        Var
            {Seleccion declarativa}
        Begin
            {Seleccion ejecutable}
        End;

### Procedimientos de pascal 
    
    ClrScr; {Limpia la pantalla}
    GetDate(Anio,Mes,Dia,DS); {Devuelve la fecha del sistema}
    Delete(Palabra, 3, 2); {Borra 2 caracteres comenzando desde la posicion 3}
    Insert('cha', Palabra, 3) {Inserta 'cha' a partir de la posicion 3 de la cadena}


# Funciones matematicas
    
    Abs(RealOInteger) {valor absoluto}
    Frac(Real) {la parte decimal}
    Int(Real) {La parte entera del argunmento} Devuelve un Real
    Round(Real) {El entero mas proximo al argumento}
    Sqr(RealOInteger) {El cuadrado del argumento}
    Sqrt(RealOInteger) {La raiz cuadrada}
    Trunc(Real) {La parte entera del argumento} Devuelve un Integer
    Pi
    Upcase(string) {Mayuscula}
    Odd(Entero) {(true)>0 o (false)<0}

# Funciones especiales

    Ord(ordinal) {Devuelve el numero ordinal}
    Chr(byte) {Devuelve el caracter}
    Succ(ordinal) {Devuelve el sucesor del argumento, error si no lo tiene}
    Pred(ordinal) {Devuelve el predecesor del argumento, " " " "}

# Funciones en cadenas de caracteres

    Length(String) {Longitud del string}
    Pos(S1,S2) {Devuelve la posicion donde comienza la cadena S1 en la cadena S2} {Si no existe devuelve 0}
    Copy(S,p,n) {Devulve la cadena de longitud `n` extraida de la cadena `S` a partir de `P`}
    Val(S,n,error) {Convierte una cadena `S` a un numero `n` (si esto es posible, err tendra 0, sino 1)}
    Str(N,S) {Convierte al numero N en su representacion en String}
    Trim(S) {Devuelve la cadena sin los blancos}