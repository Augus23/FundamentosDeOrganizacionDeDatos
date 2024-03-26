{
    5. Realizar un programa para una tienda de celulares, que presente un menú con
	opciones para:
		a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
		ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
		correspondientes a los celulares deben contener: código de celular, nombre,
		descripción, marca, precio, stock mínimo y stock disponible.
		b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
		stock mínimo.
		c. Listar en pantalla los celulares del archivo cuya descripción contenga una
		cadena de caracteres proporcionada por el usuario.
		d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
		“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
		podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
		debería respetar el formato dado para este tipo de archivos en la NOTA 2.
	NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
	NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
	tres líneas consecutivas. En la primera se especifica: código de celular, el precio y
	marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
	nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo "celulares.txt”
}


program untitled;

type
	
	celular = record
		cod_celular : integer;
		nombre : string;
		descripcion : string;
		marca : string;
		precio : real;
		stock_min : integer;
		stock_dis : integer;
	end;
	
	archivo_celulares = file of celular;

procedure imprimir_Cel(c:celular);
begin
  writeln('El celular marca ', c.marca,' con codigo ', c.cod_celular,' modelo ', c.nombre,' descripcion ', c.descripcion, ' precio ', c.precio,' stock actual de ', c.stock_dis,' y stock minimo de ', c.stock_min);
end;

procedure leerCelu(var c:celular);
begin
	writeln('Ingrese cod de celular: ');
	readln(c.cod_celular);
	writeln('Ingrese nombre de celular: ');
	readln(c.nombre);
	writeln('Ingrese descripcion de celular: ');
	readln(c.descripcion);
	writeln('Ingrese marca de celular: ');
	readln(c.marca);
	writeln('Ingrese precio de celular: ');
	readln(c.precio);
	writeln('Ingrese stock minimo de celular: ');
	readln(c.stock_min);
	writeln('Ingrese disponible de celular: ');
	readln(c.stock_dis);
end;

procedure crearArchivo(var archivo_texto : text;var archivo_celus : archivo_celulares);
var
	nombre_fisico : string;
	celu : celular;
begin
	writeln('Ingrese nombre de archivo a crear: ');
	readln(nombre_fisico);
	assign(archivo_celus,nombre_fisico);
	rewrite(archivo_celus);
	writeln('Ingrese nombre de archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	reset(archivo_texto);
	while not EOF(archivo_texto) do
	begin
		readln(archivo_texto,celu.cod_celular,celu.nombre);
		readln(archivo_texto,celu.descripcion);
		readln(archivo_texto,celu.precio,celu.stock_min,celu.stock_dis,celu.marca);
		write(archivo_celus,celu);
	end;
	close(archivo_celus);
	close(archivo_texto);
end;

procedure listarStock(var archivo_texto:text);
var
	nombre_fisico : string;
	celu : celular;
begin
	writeln('Ingrese nombre de archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	reset(archivo_texto);
	while not EOF(archivo_texto) do
	begin
		readln(archivo_texto,celu.cod_celular,celu.nombre);
		readln(archivo_texto,celu.descripcion);
		readln(archivo_texto,celu.precio,celu.stock_min,celu.stock_dis,celu.marca);
		if(celu.stock_min > celu.stock_dis) then imprimir_Cel(celu);
	end;
	close(archivo_texto);
end;

procedure buscarDescripcion(var archivo_texto:text);
var
	nombre_fisico,descripcion : string;
	celu : celular;
begin
	writeln('Ingrese nombre de archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	reset(archivo_texto);
	writeln('Ingrese descrpcion: ');
	readln(descripcion);
	while not EOF(archivo_texto) do
	begin
		readln(archivo_texto,celu.cod_celular,celu.nombre);
		readln(archivo_texto,celu.descripcion);
		readln(archivo_texto,celu.precio,celu.stock_min,celu.stock_dis,celu.marca);	
		if(celu.descripcion = descripcion) then imprimir_Cel(celu);
	end;
	close(archivo_texto);
end;

procedure exportarBinario(var archivo_texto:text;var archivo_celus:archivo_celulares);
var
	nombre_fisico : string;
	celu : celular;
begin
	writeln('Ingrese nombre de archivo binario: ');
	readln(nombre_fisico);
	assign(archivo_celus,nombre_fisico);
	reset(archivo_celus);
	writeln('Ingrese nombre de archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	rewrite(archivo_texto);
	while not EOF(archivo_celus) do
	begin
		read(archivo_celus,celu);
		writeln(archivo_texto,celu.cod_celular,' ',celu.precio,' ',celu.marca);
		writeln(archivo_texto,celu.stock_min,' ',celu.stock_dis,' ',celu.descripcion);
		writeln(archivo_texto,celu.nombre);	
	end;
	close(archivo_texto);
	close(archivo_celus);
end;
	
procedure anadirCelular(var archivo_texto:text);
var
	nombre_fisico : string;
	celu,aggcelu : celular;
	flag : boolean;
begin
	writeln('Ingrese nombre de archivo de texto: ');
	readln(nombre_fisico);
	assign(archivo_texto,nombre_fisico);
	reset(archivo_texto);
	leerCelu(aggcelu);
	flag := false;
	while not EOF(archivo_texto) do
	begin
		readln(archivo_texto,celu.cod_celular,celu.nombre);
		readln(archivo_texto,celu.descripcion);
		readln(archivo_texto,celu.precio,celu.stock_min,celu.stock_dis,celu.marca); 
		if (celu.nombre = aggcelu.nombre) then flag := true;
	end;
	if (flag = false) then 
	begin
		writeln(archivo_texto, aggcelu.cod_celular,' ', aggcelu.nombre);
		writeln(archivo_texto, aggcelu.descripcion);
		writeln(archivo_texto, aggcelu.precio,' ', aggcelu.stock_min,' ', aggcelu.stock_dis,' ', aggcelu.marca);
	end
	else 
	begin
		writeln('Ya existe el modelo: ',aggcelu.nombre);
	end;
end;

var
	
	archivo_celus : archivo_celulares;
	archivo_texto : text;
	menu : integer;
	
BEGIN
	repeat
		writeln('Ingrese una opcion: ');
		writeln('1. Crear archivo binario');
		writeln('2. Listar celulares con stock menor al stock minimo');
		writeln('3. Buscar por descripcion');
		writeln('4. Exportar archivo binario');
		writeln('5. Añadir celular');
		writeln('6. Cerrar programa');
		readln(menu);
		case menu of
			1:
			begin
				crearArchivo(archivo_texto,archivo_celus);
			end;
			2:
			begin
				listarStock(archivo_texto);
			end;
			3:
			begin
				buscarDescripcion(archivo_texto);
			end;
			4:
			begin
				exportarBinario(archivo_texto,archivo_celus);
			end;
			5:
			begin
				anadirCelular(archivo_texto);
			end;
		end;
	until (menu = 6)
END.

