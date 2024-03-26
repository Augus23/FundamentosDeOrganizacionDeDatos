{
	Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
	creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
	promedio de los números ingresados. El nombre del archivo a procesar debe ser
	proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
	contenido del archivo en pantalla.
}


program untitled;

type
	
	archivo_enteros = file of integer;

var 
	
	enteros : archivo_enteros;
	nombre_logico : string;
	cant_menores,promedio,dato : integer;
	
BEGIN
	write('Ingrese nombre del archivo: ');
	readln(nombre_logico);
	assign(enteros,nombre_logico);
	reset(enteros);
	cant_menores := 0;
	promedio := 0;
	while not EOF(enteros) do
	begin
		read(enteros,dato);
		if (dato < 1500) then cant_menores := cant_menores + 1;
		promedio := promedio + dato;
	end;
	writeln('Cantidad de numeros menores a 1500: ',cant_menores);
	writeln('Promedio: ',promedio/fileSize(enteros));
	close(enteros);
END.

