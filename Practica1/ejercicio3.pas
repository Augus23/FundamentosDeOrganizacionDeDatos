{
    Realizar un programa que presente un menú con opciones para:
		a. Crear un archivo de registros no ordenados de empleados y completarlo con
		datos ingresados desde teclado. De cada empleado se registra: número de
		empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
		DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
		b. Abrir el archivo anteriormente generado y
			i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
			determinado, el cual se proporciona desde el teclado.
			ii. Listar en pantalla los empleados de a uno por línea.
			iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
		NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.
		* 
	Agregar al menú del programa del ejercicio 3, opciones para:
		a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
		teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
		un número de empleado ya registrado (control de unicidad).
		b. Modificar la edad de un empleado dado.
		c. Exportar el contenido del archivo a un archivo de texto llamado
		“todos_empleados.txt”.
		d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
		que no tengan cargado el DNI (DNI en 00).
	NOTA: Las búsquedas deben realizarse por número de empleado.
}


program untitled;

type
	
	empleado = record
		nombre : string;
		apellido : string;
		nro_empleado : integer;
		edad : integer;
		dni : integer;
	end;
	
	archivo_empleados = file of empleado;
	
procedure leerEmpleado(var emp:empleado);
begin
	write('Ingrese apellido de la persona: ');
	readln(emp.apellido);
	write('Ingrese nombre de la persona: ');
	readln(emp.nombre);
	write('Ingrese nro de empleado de la persona: ');
	readln(emp.nro_empleado);
	write('Ingrese edad de la persona: ');
	readln(emp.edad);
	write('Ingrese dni de la persona: ');
	readln(emp.dni);
end;
var
	
	exportar_archivo,empleados : archivo_empleados;
	emp,aux : empleado;
	nom_o_ape,nombre_logico : string;
	numero,menu : integer;
	flag : boolean;
	
BEGIN
	repeat
		writeln('Ingrese una opcion: ');
		writeln('1. Crear archivo');
		writeln('2. Buscar empleados por nombre o apellido');
		writeln('3. Listar empleados');
		writeln('4. Listar empleados proximos a jubilarse');
		writeln('5. Agregar empleado');
		writeln('6. Modificar edad de empleado');
		writeln('7. Exportar el contenido del archivo');
		writeln('8. Exportar el contenido del archivo con empleados con dni 00');
		writeln('9. Cerrar programa');
		readln(menu);
		case menu of
			1:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				rewrite(empleados);
				leerEmpleado(emp);
				while(emp.apellido<>'fin') do
				begin
					write(empleados,emp);
					leerEmpleado(emp);
				end;
				close(empleados);
			end;
			2:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				write('Ingrese nombre o apellido a buscar: ');
				readln(nom_o_ape);
				while not EOF(empleados) do
				begin
					read(empleados,emp);
					if(emp.apellido = nom_o_ape) or (emp.nombre = nom_o_ape) then writeln('Nombre: ',emp.nombre,', Apellido: ',emp.apellido,', Nro de empleado: ',emp.nro_empleado,', Edad: ',emp.edad,', Dni: ',emp.dni);
				end;
				close(empleados);
			end;
			3:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				while not EOF(empleados) do
				begin
					read(empleados,emp);
					writeln('Nombre: ',emp.nombre,', Apellido: ',emp.apellido,', Nro de empleado: ',emp.nro_empleado,', Edad: ',emp.edad,', Dni: ',emp.dni);
				end;
				close(empleados);
			end;
			4:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				while not EOF(empleados) do
				begin
					read(empleados,emp);
					if (emp.edad>=70) then writeln('Nombre: ',emp.nombre,', Apellido: ',emp.apellido,', Nro de empleado: ',emp.nro_empleado,', Edad: ',emp.edad,', Dni: ',emp.dni);
				end;
				close(empleados);
			end;
			5:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				leerEmpleado(emp);
				flag := false;
				while not EOF(empleados) do
				begin
					read(empleados,aux);
					if(emp.nro_empleado = aux.nro_empleado) then flag := true;
				end;
				if (flag = false) then write(empleados,emp)
				else writeln('Ya existe un nro de empleados con el nro: ',emp.nro_empleado);
				close(empleados);
			end;
			6:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				write('Ingrese nro de empleado a cambiar edad: ');
				readln(numero);
				read(empleados,emp);
				while not EOF(empleados) and (emp.nro_empleado <> numero) do
				begin
					read(empleados,emp);
				end;
				if(emp.nro_empleado = numero) then 
				begin
					write(emp.nombre,' tiene una edad de: ',emp.edad,' elige su nueva edad: ');
					readln(numero);
					emp.edad := numero;
					seek(empleados,filePos(empleados)-1);
					write(empleados,emp);
				end
				else writeln('No se encontro ningun empleado con el numero: ',numero);
				close(empleados);
			end;
			7:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				assign(exportar_archivo,'todos_empleados.txt');
				rewrite(exportar_archivo);
				while not EOF(empleados) do
				begin
					read(empleados,emp);
					write(exportar_archivo,emp);
				end;
				close(empleados);
				close(exportar_archivo);
			end;
			8:
			begin
				write('Ingrese nombre del archivo: ');
				readln(nombre_logico);
				assign(empleados,nombre_logico);
				reset(empleados);
				assign(exportar_archivo,'faltaDNIEmpleado.txt');
				rewrite(exportar_archivo);
				while not EOF(empleados) do
				begin
					read(empleados,emp);
					if(emp.dni <> 00) then write(exportar_archivo,emp);
				end;
				close(empleados);
				close(exportar_archivo);
			end;
			9: writeln('Apagando programa...');
			else
				writeln('Numero no valido');
			end;
	until (menu = 9);
END.

