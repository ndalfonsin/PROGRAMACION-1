program CreditCards;

(* Las compras realizadas por cada uno de los N  titulares de Tarjetas de Crédito se registran en un archivo de texto, de la siguiente forma:
Nro. de Cliente y a continuación sus compras, por cada una:
Tipo de compra: (C=combustible, S=supermercado, O=otros, no se conoce la cantidad, F es fin de datos)
Día (1-31 )
Monto

El Banco ofrece un descuento  si la compra es 
de combustible en la segunda quincena, obtiene un 10% 
de supermercado en la primera quincena, obtiene un 15%. 
Además, si el monto de la compra supera los $300 se agrega un 5% de descuento adicional, aplicado a posteriori de los descuentos anteriores.

Se pide desarrollar un programa Pascal, claro, eficiente y eficaz que lea desde el archivo la información descripta  para calcular e informar:

A1.- Total gastado por cada cliente que no se beneficio con los descuentos (ninguno de los tres posibles)
B1.-Cuantos clientes obtuvieron descuentos por quincena en ambos rubros (super y combustible) en algunas de sus compras.
C1.-INFORMAR  CUÁNTO AHORRO CADA CLIENTE.

Para determinar el descuento de una compra, se pide utilizar la función Descuento, que a partir del día, el monto y el tipo de compra devuelve  el 
correspondiente  descuento (puede ser cero).  Esta función no calcula el descuento de compras mayores a $300.
RTA  :
A1) BBBB   $807.50       
B1)  2 ( AAAA Y CCCC )
C1)  AHORRO   AAAA (0+58+30)=88   BBBB ( 25+17,5 )=42,5  CCCC (80,85 +0+22)=102,85  DDDD =(48+13,6)=61,6
        
A2)     AAAA ( $ 40+ $18 )+( $ 30) = $58 + $30   = $88
        CCCC  ( $ 63+$17.85) +( $22 )  = $80.85 + $ 22 = $102,85
B2)     (Solo BBBB )    ……  25 %
C2)  GASTOS  
        AAAA (200+342+170)=712   
        BBBB (475+332,5)=807,50  
        CCCC (339,15 +100+198)=637,15 
        DDDD =258,4
*)

