unit uFormCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormCadBasico, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, uADStanIntf,
  uADStanOption, uADStanError, uADStanParam, uADDatSManager, uADPhysIntf,
  uADDAptIntf, uADStanAsync, uADCompClient;

type
  TFormCadUsuario = class(TFormCadBasico)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edSenha: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    edDtCad: TDBEdit;
    edLogin: TDBEdit;
    edNome: TDBEdit;
    edStatus: TDBComboBox;
    SpeedButton5: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure acNovoExecute(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure tabsheet1Show(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadUsuario: TFormCadUsuario;

implementation

{$R *.dfm}

uses uDM;

procedure TFormCadUsuario.acNovoExecute(Sender: TObject);
begin
  inherited;
  edDtCad.Text := DateTimeToStr(Date);
  edStatus.ItemIndex := 0;
end;

procedure TFormCadUsuario.SpeedButton1Click(Sender: TObject);
begin
 ///

end;

procedure TFormCadUsuario.SpeedButton5Click(Sender: TObject);
begin
  with DM do
  begin
  ADQuery1.Open('select * from usuarios');
   case cbxFiltros.ItemIndex of

      0 : ADQuery1.ExecSQL('select * from usuarios where nome like "th%"');
   end;
 end;
end;

procedure TFormCadUsuario.tabsheet1Show(Sender: TObject);
begin
  inherited;
  edDtCad.Text := DateTimeToStr(Date);
  edStatus.ItemIndex := 0;
end;

end.
