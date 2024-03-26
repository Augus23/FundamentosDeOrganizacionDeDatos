{
   Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
	incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
	cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
	archivo debe ser proporcionado por el usuario desde teclado.  
}


program untitled;

type
	archivo_enteros = file of integer;
var 
	nombre_fisico : string;
	enteros : archivo_enteros;
	entero : integer;
	
BEGIN
	write('Ingrese nombre del archivo: ');
	readln(nombre_fisico);
	assign(enteros,nombre_fisico);
	rewrite(enteros);
	write('Ingrese un numero al archivo: ');
	readln(entero);
	while (entero<>3000) do
	begin
		write(enteros,entero);
		write('Ingrese un numero al archivo: ');
		readln(entero);
	end;
	close(enteros);
END.

