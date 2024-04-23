{Suponga que usted es administrador de un servidor de correo electrónico. En los logs del
mismo (información guardada acerca de los movimientos que ocurren en el server) que se
encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
a. Realice el procedimiento necesario para actualizar la información del log en un
día particular. Defina las estructuras de datos que utilice su procedimiento.
b. Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema. Considere la implementación de esta opción de las
siguientes maneras:
i- Como un procedimiento separado del punto a).
ii- En el mismo procedimiento de actualización del punto a). Qué cambios
se requieren en el procedimiento del punto a) para realizar el informe en
el mismo recorrido?}


program untitled;
const
	valor_alto = 9999;
type
	usuario = record
		nro : integer;
		nomUs : string;
		nom : string;
		ape : string;
		cantMails : integer;
	end;
	
	mails = record
		nro : integer;
		cuenDes : string;
		msg : string;
	end;

	maestro = file of usuario;

procedure leer(var det : text;var dato : mails);
begin
	if(not eof(det)) then
	begin
		readln(det,dato.nro,dato.cuenDes);
		readln(det,dato.msg);
	end
	else dato.nro := valor_alto;
end;

procedure generarArchivo(var arch : text;nro,cant : integer);
begin
	writeln(arch,nro,' ',cant);
end;

procedure convertirMaeBin(var maeBin : maestro;var mae : text);
var
	regm : usuario;
begin
	reset(mae);
	rewrite(maeBin);
	while(not eof(mae))do
	begin
		readln(mae,regm.nro,regm.nomUs);
		readln(mae,regm.nom);
		readln(mae,regm.ape);
		readln(mae,regm.cantMails);
		write(maeBin,regm);
	end;
	close(mae);
	close(maeBin);
end;

procedure actualizarMae(var mae : maestro;var det,arch : text);
var
	nroUs,cant : integer;
	regd : mails;
	regm : usuario;
begin
	rewrite(arch);
	reset(mae);
	reset(det);
	read(mae,regm);
	leer(det,regd);
	while(regd.nro <> valor_alto)do
	begin
		nroUs := regd.nro;
		cant := 0;
		while(nroUs = regd.nro)do
		begin
			cant := cant + 1;
			leer(det,regd);		
		end;
		while(regm.nro <> nroUs)do read(mae,regm);
		if(regm.nro = nroUs)then
		begin
			regm.cantMails := regm.cantMails + cant;
			seek(mae,filepos(mae)-1);
			write(mae,regm);
		end;
		generarArchivo(arch,nroUs,regm.cantMails);
	end;
	if(not eof(mae))then
	begin
		while(not eof(mae))do
		begin
			read(mae,regm);
			generarArchivo(arch,regm.nro,regm.cantMails);
		end;
	end;
	close(mae);
	close(det);
	close(arch);
end;

procedure imprimirArch(var arch : text);
var
	us,cant : integer;
begin
	reset(arch);
	while(not eof(arch)) do
	begin
		readln(arch,us,cant);
		writeln('Usuario: ',us,' cantidad mails enviados: ',cant);
	end;
	close(arch);
end;

var
	maeT,det,arch : text;
	maeBin : maestro;
BEGIN
	assign(maeT,'ejer12pract2mae.txt');
	assign(det,'ejer12pract2det.txt');
	assign(arch,'ejer12pract2arch.txt');
	assign(maeBin,'ejer12pract2maeBin.dat');
	convertirMaeBin(maeBin,maeT);
	actualizarMae(maeBin,det,arch);
	imprimirArch(arch);
END.

