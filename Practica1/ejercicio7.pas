{
  Realizar un programa que permita:
	a) Crear un archivo binario a partir de la información almacenada en un archivo de
	texto. El nombre del archivo de texto es: “novelas.txt”. La información en el
	archivo de texto consiste en: código de novela, nombre, género y precio de
	diferentes novelas argentinas. Los datos de cada novela se almacenan en dos
	líneas en el archivo de texto. La primera línea contendrá la siguiente información:
	código novela, precio y género, y la segunda línea almacenará el nombre de la
	novela.
	b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
	agregar una novela y modificar una existente. Las búsquedas se realizan por
	código de novela.
  NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado. 
}


program untitled;

type
	novela = record
		codigo : integer;
		nombre : string;
		genero : string;
		precio : real;
	end;
	
	archivo_novelas = file of novela;
	
procedure cargarBinario(var archivo_binario : archivo_novelas;var archivo_texto : text);
var
	nombre_fisico : string;
	novelas : novela;
begin
	writeln('Ingrese nombre del archivo binario a crear: ');
	readln(nombre_fisico);
	assign(archivo_binario,nombre_fisico);
	rewrite(archivo_binario);
	writeln('Ingrese nombre del archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	reset(archivo_texto);
	while not EOF(archivo_texto)do
	begin
		readln(archivo_texto,novelas.codigo,novelas.precio,novelas.genero);
		readln(archivo_texto,novelas.nombre);
		write(archivo_binario,novelas);
	end;
	close(archivo_texto);
	close(archivo_binario);
end;

procedure agregarNovela(var archivo_binario : archivo_novelas);
var
	nombre_fisico : string;
	auxnov,novelas : novela;
	flag : boolean;
begin
	writeln('Ingrese archivo binario: ');
	readln(nombre_fisico);
	assign(archivo_binario,nombre_fisico);
	reset(archivo_binario);
	writeln('Ingrese nombre de la novela: ');
	readln(novelas.nombre);
	writeln('Ingrese codigo de la novela: ');
	readln(novelas.codigo);
	writeln('Ingrese genero de la novela: ');
	readln(novelas.genero);
	writeln('Ingrese precio de la novela: ');
	readln(novelas.precio);
	flag := false;
	while not EOF(archivo_binario) do
	begin
		read(archivo_binario,auxnov);
		if(auxnov.codigo=novelas.codigo) then flag := true;
	end;
	if (flag = false) then write(archivo_binario,novelas)
	else writeln('Ya existe una novela con el codigo: ',novelas.codigo);
	close(archivo_binario);
end;

procedure modificarNovela(var archivo_binario : archivo_novelas);
var
	auxS,nombre_fisico : string;
	novelas : novela;
	auxI,codigo,menu : integer;
	flag : boolean;
begin
	writeln('Ingrese archivo binario: ');
	readln(nombre_fisico);
	assign(archivo_binario,nombre_fisico);
	reset(archivo_binario);
	writeln('Ingrese codigo de novela que desea modificar: ');
	readln(codigo);
	flag := false;
	while not EOF(archivo_binario) and (flag = false) do 
	begin
		read(archivo_binario,novelas);
		if(novelas.codigo = codigo) then flag := true;
	end;
	if(flag = true) then
	begin
		seek(archivo_binario,filepos(archivo_binario)-1);
		writeln('Que dese modificar ?');
		writeln('1. Nombre de novela');
		writeln('2. Codigo de novela');
		writeln('3. Genero de novela');
		writeln('4. Precio de novela');
		writeln('5. Salir');
		readln(menu);
		case menu of
			1:
			begin
				writeln('Ingrese nuevo nombre: ');
				readln(auxS);
				novelas.nombre := auxS;
				write(archivo_binario,novelas);
			end;
			2:
			begin
				writeln('Ingrese nuevo codigo: ');
				readln(auxI);
				novelas.codigo := auxI;
				write(archivo_binario,novelas);
			end;
			3:
			begin
				writeln('Ingrese nuevo genero: ');
				readln(auxS);
				novelas.genero := auxS;
				write(archivo_binario,novelas);
			end;
			4:
			begin
				writeln('Ingrese nuevo precio: ');
				readln(auxI);
				novelas.precio := auxI;
				write(archivo_binario,novelas);
			end;
		end;
	end
	else writeln('No se encontro ninguna novela con el codigo ',codigo);
	close(archivo_binario);
end;

procedure imprimirArchivo(var archivo_binario : archivo_novelas);
var
	nombre_fisico : string;
	novelas : novela;
begin
	writeln('Ingrese archivo binario: ');
	readln(nombre_fisico);
	assign(archivo_binario,nombre_fisico);
	reset(archivo_binario);
	while not EOF(archivo_binario) do
	begin
		read(archivo_binario,novelas);
		writeln('Titulo novela: ',novelas.nombre,', codigo: ',novelas.codigo,', genero: ',novelas.genero,', precio: ',novelas.precio);
	end;
	close(archivo_binario);
end;
var

	archivo_texto : text;
	archivo_binario : archivo_novelas;
	menu : integer;

BEGIN
	repeat
		writeln('1. Crear archivo binario');
		writeln('2. Agregar novela');
		writeln('3. Modificar novela');
		writeln('4. Imprimir novela');
		writeln('5. Cerrar programa');
		write('Ingrese una opcion: ');
		readln(menu);
		case menu of
			1: cargarBinario(archivo_binario,archivo_texto);
			2: agregarNovela(archivo_binario);
			3: modificarNovela(archivo_binario);
			4: imprimirArchivo(archivo_binario);
		end;
	until (menu=5);
END.

