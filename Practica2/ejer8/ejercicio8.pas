{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.}
program untitled;
const
	valor_alto = 9999;
type
	cliente = record
		cod :integer;
		nom : string;
		ape : string;
	end;
	
	cliente_maestro = record
		cli : cliente;
		ano : integer;
		mes : integer;
		monto : integer;
	end;
	
	maestro = file of cliente_maestro;
	
procedure leer(var mae : text;var dato : cliente_maestro);
begin
	if(not eof(mae)) then
	begin
		readln(mae,dato.cli.cod,dato.ano,dato.mes,dato.monto,dato.cli.nom);
		readln(mae,dato.cli.ape);
	end
	else dato.cli.cod := valor_alto;
end;

procedure recorrerMae(var mae : text);
var
	total_empresa, total_cliente, mes_cliente, ano, mes, cod_actual : integer;
	regm : cliente_maestro;
begin
	reset(mae);
	leer(mae,regm);
	total_empresa := 0;
	while(regm.cli.cod <> valor_alto) do
	begin
		cod_actual := regm.cli.cod;
		writeln('Cliente: ',regm.cli.nom,' ',regm.cli.ape); 
		while(cod_actual = regm.cli.cod)do
		begin
			ano := regm.ano;
			total_cliente := 0;
			writeln('Anio: ', ano);
			while(ano = regm.ano) and (cod_actual = regm.cli.cod) do
			begin
				mes := regm.mes;
				mes_cliente := 0;
				while(mes = regm.mes) and (ano = regm.ano) and (cod_actual = regm.cli.cod) do
				begin
					mes_cliente := mes_cliente + regm.monto;
					leer(mae,regm);
				end;
				if(mes_cliente > 0) then writeln('Cant del mes ',mes,' ',mes_cliente);
				total_cliente := total_cliente + mes_cliente;
			end;
			writeln('Cant del anio: ',ano,' ',total_cliente);
			total_empresa := total_empresa + total_cliente;
		end;
	end;
	writeln('Cant empresa: ',total_empresa);
	close(mae);
end;

var
	mae : text;
BEGIN
	assign(mae,'ejer8pract2mae.txt');
	recorrerMae(mae);
END.

