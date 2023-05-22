program recursividad;

type
    TV = Array [1..50] of integer;

var 
    vector : TV;
    N: byte;

{ 
    EJERCICIO 1- Funcion potencia

     La siguiente función calcula la potencia n-ésima de un número X ( X n ) en forma iterativa,
    siendo n y X enteros. Se pide:  
        a) Desarrollarla en forma recursiva. 
        b) Considerar n negativo.  
        
        function potencia(X,n: integer): integer;   (* X elevado a n *) 
            var    
                i: integer;                         
                mult: integer;                
                
                begin    
                    mult := 1;                   (* inicialización *)    
                    for i := 1 to n do       
                        mult := mult * X;          (* hacemos "n" veces "X*X" *)    
                    potencia := mult;              
                end; 
}
Function potencia(X,n: real): real;
    var
        mult: real;

    begin
        mult:= 1;
        
        if n<0 then
            begin
                n:= -n;
                X:= 1/X;
            end;
        
        if n<>0 then
            mult:= X * potencia(X,(n-1));
        
        potencia:= mult;
    end;

{   
    EJERCICIO 2

            |-      1       sii i=0
    f(i) = |    1+f(i-1)    sii i es par
            |-   f(i-1)     sii i es impar

    En resumen, la función f(i) genera una secuencia recursiva en la que cada término depende del término anterior y de la paridad de i.

}
Function parOImpar(i:integer):integer;
    var
        result: integer;

    begin
        if i = 0 then
            result:=1
        else if (i mod 2) = 0 then
            result:= 1 + parOImpar(i-1)
        else if (i mod 2) <> 0 then
            result:= parOImpar(i-1);
        parOImpar:=result;  
    end;

{
    EJERCICIO 3
    
    a) Probarlo con los siguientes invocaciones: confuso(2, 17) y confuso(4, 25) 
    b) Determinar qué función matemática define confuso. 

        Multiplica dos valores que le des.
}

function confuso(a,b:integer):integer; 
    begin      
        if (b = 0) then   
            confuso := 0       
        else    
            if (b mod 2 = 0) then        
                confuso := confuso(a+a, b div 2)   
            else            
                confuso := confuso(a+a, b div 2) + a; 
    end; 

{
    EJERCICIO 5
    Sea V un arreglo de enteros, mediante procesos recursivos se pide: 
        a) Calcular e informar la suma de sus elementos. 
        b) Mostrar sus elementos. 
        c) Mostrarlos en orden inverso. 
        d) Obtener el máximo de sus elementos. 
        e) Obtener el promedio
}

Procedure creaVector(var vector: TV; var N:byte);
    var
        Arch : text;

    begin
        Assign(Arch, 'ej5.txt');
        reset(Arch);
        N:=0;

        while not EOF(Arch) do
            begin
                N:=N+1;
                readln(Arch, vector[N])
            end;
        
        {for i:= 1 to N do
            writeln(vector[i]);}
    end;

Function sumaElementos(vector: TV; N:byte):integer;
    begin

        if N>0 then
            sumaElementos:= vector[N] + sumaElementos(vector, N-1);

    end;


//NOOOOOOOOOOOOO ANDAAAAAAAAAAAAAAAAAAAAAA!!!!!!!!!!!!!!!!!!!!!!!!!
Procedure muestraElementos(vector:TV; N:byte);
    var
        i: integer;
    begin
        if N>1 then
            i:= muestraElementos(vector, N-1)
        else if N = 1 then
            i:=vector[N]
        else
            writeln;
        
        write(i);
    end;

    //############ PROGRAMA PRINCIPAL ####################
begin
    //FUNCION POTENCIA
    
    writeln('Prueba 1: ',potencia(2, 2):3:2);
    writeln('Prueba 2: ',potencia(3, 3):3:2);
    writeln('Prueba 3: ',potencia(-2, 5):3:2);
    writeln('Prueba 4: ',potencia(-2, -5):3:2);
    writeln('Prueba 5: ',potencia(3, -2):3:2);
    writeln('Prueba 6: ',potencia(4, -2):3:2);
    writeln();
    writeln();

    //FUNCION EJERCICIO 2
    writeln('EJERCICIO 2');
    writeln('Prueba 1: ', parOImpar(8));
    writeln('Prueba 2: ', parOImpar(-8));
    writeln('Prueba 3: ', parOImpar(18));
    writeln('Prueba 4: ', parOImpar(348));
    writeln();
    writeln();

    //EJERCICIO 3: Confuso
    writeln('EJERCICIO 3');
    writeln('Prueba 1: ', confuso(2,17));
    writeln('Prueba 2: ', confuso(4,25));
    writeln();
    writeln();

    //EJERCICIO 5
    writeln('EJERCICIO 5');
    creaVector(vector, N);
    writeln('La suma de los elementos del vector es: ',sumaElementos(vector, N));
    muestraElementos(vector, N);

    readln;

end.