Program Matrices1;

type
    TM = Array[1..5,1..5] of integer;
    TV = Array[1..5] of integer;


var 
    Mat : TM;
    MaxF : TV;
    N, M, i: byte;
    matx: text;

//Carga de la matriz 

procedure cargaDatos(var N, M: byte; var Mat: TM);
    var
        i, j: byte;
    begin
        Assign(matx, 'mat.txt');
        reset(matx);

        readln(matx, N, M);

        For i:= 1 to N do 
            Begin  
                For j:= 1 to M do  
                    read(matx, Mat[i, j]);  
            end;

        //corroboracion
        For i:= 1 to N do 
            Begin  
                For j:= 1 to M do  
                    write(Mat[i,j]:4,' ');
                writeln;  
            end;
    end;

//- Generar un arreglo con el maximo de cada fila y mostrarlo

Function MaxFila(Mat:TM; i, M:Byte):integer; {recorre la fila i con j entre 1 y M} 
        Var     
            j:Byte;       
            Max: integer; 
        Begin    
            Max:= Mat[i,1];   
            For j:= 2 to M do      
                If Max < Mat[i,j] then        
                    Max:=Mat[i,j]; 
            MaxFila:= Max 
        End;



begin
    writeln('Se ha cargado la siguiente matriz:');
    writeln;
    cargaDatos(N, M, Mat);
    
    writeln;
    writeln('Maximos valores por fila:');
    
    for i:=1 to N do
        writeln(MaxFila(Mat, i, M));
    
    readln();
end.
