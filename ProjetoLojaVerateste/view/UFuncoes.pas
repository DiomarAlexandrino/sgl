unit UFuncoes;

interface

 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, DBGrids, Grids, DB;

type
 form = class(TForm)

end;
procedure CriarForm(T : TComponentClass; Form :TForm);
function StringParaFloat(s : string) : Extended;
function GetLoginCadastrado(Login: string) :Boolean;
procedure ZebrarDBGrid(DataSource : TDataSource; Sender : TDBGrid; State : TGridDrawState;  Rect: TRect; Column : TColumn);

function ReverterData(S: String):string;

implementation

uses
  SqlExpr, udm;

function ReverterData(S: String) : String;
begin
  result := copy(S,7,4)+'-'+copy(S,4,2)+'-'+copy(S,1,2);
end;



procedure CriarForm(T : TComponentClass; Form :TForm);

    begin
    Application.CreateForm(T, Form);
      try
        form.ShowModal;
      finally
         FreeAndNil(Form);
    end;

 end;

function GetLoginCadastrado(Login: string) :Boolean;
begin
  result := false;
  with TSQLQuery.Create(nil) do
   try
    //  SQLConnection := dm.conexao2;
     sql.Add('SELECT ID FROM USUARIOS WHERE LOGIN = :LOGIN');
     Params[0].AsString := Login;
     Open;
     if not IsEmpty  then result := true
   finally
    close;
    free;
   end;
end;

procedure ZebrarDBGrid(DataSource : TDataSource; Sender : TDBGrid; State : TGridDrawState;  Rect: TRect; Column : TColumn);
Begin
  if not odd(DataSource.DataSet.RecNo) then
    begin
      if not (gdSelected in state) then
      begin
        Sender.Canvas.Brush.color := $00FFEFDF;
        Sender.Canvas.FillRect(Rect);
        Sender.DefaultDrawDataCell(Rect, Column.field,State);
      end;
   END;
End;

function StringParaFloat(s : string) : Extended;
{ Filtra uma string qualquer, convertendo as suas partes
  numéricas para sua representação decimal, por exemplo:
  'R$ 1.200,00' para 1200,00 '1AB34TZ' para 134}
var
  i :Integer;
  t : string;
  SeenDecimal,SeenSgn : Boolean;
begin
   t := '';
   SeenDecimal := False;
   SeenSgn := False;
   {Percorre os caracteres da string:}
   for i := Length(s) downto 0 do
  {Filtra a string, aceitando somente números e separador decimal:}

     if (s[i] in ['0'..'9', '-','+',',']) then
     begin
        if (s[i] = ',') and (not SeenDecimal) then
        begin
           t := s[i] + t;
           SeenDecimal := True;
        end
        else if (s[i] in ['+','-']) and (not SeenSgn) and (i = 1) then
        begin
           t := s[i] + t;
           SeenSgn := True;
        end
        else if s[i] in ['0'..'9'] then
        begin
           t := s[i] + t;
        end;
     end;
   Result := StrToFloat(t);
end;

end.
