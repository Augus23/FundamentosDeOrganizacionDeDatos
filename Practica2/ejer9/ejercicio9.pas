{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información está ordenada por código de provincia y código de localidad.
}
program untitled;
const
	valor_alto = 9999;
type
	mesas = record
		cod_prov : integer;
		cod_loc : integer;
		num_mesa : integer;
		cant_votos : integer;
	end;

	maestro = file of mesas;
	
procedure leer(var mae : text;var dato : mesas);
begin
	if(not eof(mae)) then read(mae,dato.cod_prov,dato.cod_loc,dato.num_mesa,dato.cant_votos)
	else dato.cod_prov := valor_alto;
end;

procedure imprimirVotos(var mae : text);
var
	prov_actual, loca_actual, votos_prov, votos_loca, votos_totales : integer;
	regm : mesas;
begin
	reset(mae);
	votos_totales := 0;
	leer(mae,regm);
	while(regm.cod_prov <> valor_alto)do
	begin
		prov_actual := regm.cod_prov;
		votos_prov := 0;
		writeln('Codigo provincia: ',regm.cod_prov);
		while(prov_actual = regm.cod_prov)do
		begin
			loca_actual := regm.cod_loc;
			votos_loca := 0;
			write('Codigo localidad: ',regm.cod_loc);
			while(loca_actual = regm.cod_loc) and (prov_actual = regm.cod_prov)do
			begin
				votos_loca := votos_loca + regm.cant_votos;
				leer(mae,regm);
			end;
			writeln(' Total votos: ',votos_loca);
			votos_prov := votos_prov + votos_loca;
		end;
		writeln('Total votos provincia: ',votos_prov);
		votos_totales := votos_totales + votos_prov;
	end;
	writeln('Votos totales: ',votos_totales);
	close(mae);
end;

var
	mae : text;
BEGIN
	assign(mae,'ejer9pract2mae.txt');
	imprimirVotos(mae);
END.

