unit uFormCadBasico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TFormCadBasico = class(TForm)
    dsTabela: TDataSource;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    tbsPesquisar: TPageControl;
    tabsheet1: TTabSheet;
    Pesquisar: TTabSheet;
    DBGrid1: TDBGrid;
    ActonList: TActionList;
    acNovo: TAction;
    acEditar: TAction;
    acExcluir: TAction;
    acSalvar: TAction;
    acCancelar: TAction;
    acImprimir: TAction;
    acFechar: TAction;
    ImageCadastro: TImageList;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    grpPesquisa: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    acPesquisar: TAction;
    Label8: TLabel;
    cbxFiltros: TComboBox;
    Label6: TLabel;
    EdPesquisa: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure acExcluirExecute(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure acCancelarExecute(Sender: TObject);
    procedure acImprimirExecute(Sender: TObject);
    procedure acFecharExecute(Sender: TObject);
    procedure acNovoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acPesquisarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    protected
      function ApplyUpdates(Ds:TDataSource):Boolean;
      procedure VerificaBotoes();
  end;

var
  FormCadBasico: TFormCadBasico;

implementation

{$R *.dfm}

uses uDM, uADCompClient;

procedure TFormCadBasico.acCancelarExecute(Sender: TObject);
begin
  dsTabela.DataSet.Cancel;
  VerificaBotoes;
  tabsheet1.TabVisible := false;
  Pesquisar.TabVisible := true;
end;

procedure TFormCadBasico.acEditarExecute(Sender: TObject);
begin
  dsTabela.DataSet.Edit;
  VerificaBotoes;
  tabsheet1.TabVisible := true;
  Pesquisar.TabVisible := false;
end;

procedure TFormCadBasico.acExcluirExecute(Sender: TObject);
begin
  if MessageDlg('Confirma Excluir?',mtConfirmation,mbYesNo,0)=mrYes then begin
    dsTabela.DataSet.Delete;
    ApplyUpdates(dsTabela);
    VerificaBotoes;
  end;
end;

procedure TFormCadBasico.acFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormCadBasico.acImprimirExecute(Sender: TObject);
begin
//
end;

procedure TFormCadBasico.acNovoExecute(Sender: TObject);
begin
  if not(dsTabela.DataSet.Active) then
   dsTabela.DataSet.Open;
   dsTabela.DataSet.Insert;
   VerificaBotoes;
   tbsPesquisar.ActivePageIndex := 0;
   tabsheet1.TabVisible := true;
   Pesquisar.TabVisible := false;


 
end;

procedure TFormCadBasico.acPesquisarExecute(Sender: TObject);
begin
   tabsheet1.TabVisible := false;
  Pesquisar.TabVisible := true;
end;

procedure TFormCadBasico.acSalvarExecute(Sender: TObject);
begin
  if ApplyUpdates(dsTabela) then
    ShowMessage('Registro Salvo/Inserido Com Sucesso!');
  VerificaBotoes;
end;

function TFormCadBasico.ApplyUpdates(Ds: TDataSource):Boolean;
begin
  try
     Result := True;
    (ds.DataSet as TADTable).ApplyUpdates(-1);
    (ds.DataSet as TADTable).CommitUpdates;
  except
    on e:exception do begin
      Result := False;
      ShowMessage('Erro ao Salvar '+#13#10+'Msg '+#13#10+e.Message);
    end;
  end;
end;

procedure TFormCadBasico.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  dsTabela.DataSet.Close;
end;

procedure TFormCadBasico.FormCreate(Sender: TObject);
begin
  dsTabela.DataSet.Open;
  tbsPesquisar.ActivePageIndex := 1;
end;

procedure TFormCadBasico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key= #27 then
     Close;

  if key= #13 then
     perform(WM_NEXTDLGCTL,0,0);

end;

procedure TFormCadBasico.SpeedButton1Click(Sender: TObject);
begin
////
///
end;

procedure TFormCadBasico.VerificaBotoes;
begin
  if (dsTabela.DataSet.State in dsEditModes) then begin
    acCancelar.Enabled := True;
    acSalvar.Enabled   := True;

    acNovo.Enabled        := False;
    acEditar.Enabled      := False;
    acExcluir.Enabled     := False;
    acFechar.Enabled      := False;
    acPesquisar.Enabled   := False;

  end
  else begin
    acCancelar.Enabled := False;
    acSalvar.Enabled   := False;

    acNovo.Enabled      := True;
    acEditar.Enabled    := True;
    acExcluir.Enabled   := True;
    acFechar.Enabled    := True;
    acPesquisar.Enabled := True;
  end;
end;

end.
