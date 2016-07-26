unit uFormCadContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormCadBasico, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Datasnap.DBClient, Winapi.ShlObj,ShellApi;

type
  TFormCadContasPagar = class(TFormCadBasico)
    Label2: TLabel;
    edNumDoc: TDBEdit;
    Label3: TLabel;
    edDesc: TDBEdit;
    Label4: TLabel;
    edVlrCom: TDBEdit;
    Label7: TLabel;
    edVlrAbat: TDBEdit;
    edDataCom: TDBEdit;
    Label9: TLabel;
    edDataCad: TDBEdit;
    Label11: TLabel;
    edDataPag: TDBEdit;
    Label12: TLabel;
    edStatus: TDBEdit;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edVariacao: TEdit;
    SpeedButton5: TSpeedButton;
    DBGrid2: TDBGrid;
    cdsParcelas: TClientDataSet;
    dsParcelas: TDataSource;
    cdsParcelasvalor: TCurrencyField;
    cdsParcelasparcela: TIntegerField;
    cdsParcelasvencimento: TDateField;
    SpeedButton6: TSpeedButton;
    edQtdParc: TEdit;
    DBComboBox1: TDBComboBox;
    procedure acNovoExecute(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure acSalvarExecute(Sender: TObject);
    procedure tabsheet1Show(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FormCadContasPagar: TFormCadContasPagar;

implementation

{$R *.dfm}

uses UFuncoes, uDM, System.SysUtils;

procedure TFormCadContasPagar.acNovoExecute(Sender: TObject);
begin
  inherited;
 // edVariacao.Text := '30';
 // edDataCom.Text  :=  DateToStr(Date);
 // edDataCad.Text  :=  DateToStr(Date);

end;

procedure TFormCadContasPagar.acSalvarExecute(Sender: TObject);
var
vlrCom, vlraba :Currency;
dtCom, dtCad  :  TDateTime;
desc, num            :String ;

begin

  with  DM do
  begin
   cdsParcelas.First;
    desc     :=   tbcontas_Pagar.FieldByName('descricao').AsString;
    num      :=  tbcontas_Pagar.FieldByName('numero_doc').AsString ;
    vlrCom   :=   tbcontas_Pagar.FieldByName('vlr_compra').AsCurrency ;
    vlraba   :=   tbcontas_Pagar.FieldByName('vlr_abatido').AsCurrency ;
    dtCom    :=   tbcontas_Pagar.FieldByName('dt_compra').AsDateTime;
    dtCad    :=   tbcontas_Pagar.FieldByName('dt_cadastro').AsDateTime;
    while not cdsParcelas.Eof do
    begin
      if  dsTabela.State in [dsbrowse,dsinactive] then
        tbcontas_Pagar.insert;

  // tbcontas_Pagar.FieldByName('dt_pagamento').AsDateTime  :=   tbcontas_Pagar.FieldByName('dt_pagamento').AsDateTime;
      tbcontas_Pagar.FieldByName('vlr_compra').AsCurrency    :=   vlrCom;
      tbcontas_Pagar.FieldByName('vlr_abatido').AsCurrency   :=  vlraba;
      tbcontas_Pagar.FieldByName('dt_compra').AsDateTime     := dtCom;
      tbcontas_Pagar.FieldByName('dt_cadastro').AsDateTime   :=  dtCad;
      tbcontas_Pagar.FieldByName('numero_doc').AsString      := num;
      tbcontas_Pagar.FieldByName('descricao').AsString      :=   desc ;
      tbcontas_Pagar.FieldByName('parcela').AsInteger       :=  cdsParcelasparcela.AsInteger;
       tbcontas_Pagar.FieldByName('vlr_parcela').AsCurrency   :=  cdsParcelasvalor.AsCurrency;
       tbcontas_Pagar.FieldByName('dt_vencimento').AsDateTime :=  cdsParcelasvencimento.AsDateTime;



        tbcontas_Pagar.FieldByName('status').AsString  :=   'A';
        //tbcontas_Pagar.Post;
        tbcontas_Pagar.ApplyUpdates(0);
        tbcontas_Pagar.EmptyDataSet;
           messagebox(FormCadContasPagar.handle,PChar('parcela '+inttostr(cdsParcelasparcela.AsInteger  )),PChar('CONFIRMAÇÃO'), 0+64);
        cdsParcelas.Next;
          messagebox(FormCadContasPagar.handle,PChar('parcela '+inttostr(cdsParcelasparcela.AsInteger  )),PChar('CONFIRMAÇÃO'), 0+64);
      END;

  end;

 end;



procedure TFormCadContasPagar.SpeedButton5Click(Sender: TObject);
var
I : Integer;
begin
  if Trim(edNumDoc.Text) = '' then
  begin
    Application.MessageBox('Preencha o campo documento','Atenção',MB_OK+48);
    edNumDoc.SetFocus;
    Abort;
  end;
  if Trim(edDesc.Text) = '' then
  begin
    Application.MessageBox('Preencha o campo Descrição','Atenção',MB_OK+48);
    edDesc.SetFocus;
    Abort;
  end;
  if dsTabela.DataSet.FieldByName('vlr_compra').AsFloat  = 0 then
  begin
    Application.MessageBox('Preencha o valor da compra','Atenção',MB_OK+48);
    edVlrCom.SetFocus;
    Abort;
  end;
  if StrToInt(edQtdParc.Text) = 0 then
  begin
    Application.MessageBox('Preencha o campo Quantidade Parcela(s)','Atenção',MB_OK+48);
    edQtdParc.SetFocus;
    Abort;
  end;
  if Trim(edVariacao.Text) = '' then
  begin
    Application.MessageBox('Preencha o campo variação da(s) Parcela(s)','Atenção',MB_OK+48);
    edVariacao.SetFocus;
    Abort;
  end;
  if Trim(edDataCom.Text) = '' then
  begin
    Application.MessageBox('Preencha a data da compra','Atenção',MB_OK+48);
    edDataCom.SetFocus;
    Abort;
  end;

cdsParcelas.EmptyDataSet;
for I := 1 to StrToInt(edQtdParc.Text) do
begin
  cdsParcelas.Insert;
//  cdsParcelas.Post;
 // cdsParcelas.Edit;

  cdsParcelasparcela.AsInteger       := i ;
  //messagebox(FormCadContasPagar.handle,PChar('dt_vencimento '+Datetostr(dsTabela.DataSet.FieldByName('dt_vencimento').AsDateTime )),PChar('CONFIRMAÇÃO'), 0+64);
  cdsParcelasvalor.AsFloat           :=  (dsTabela.DataSet.FieldByName('vlr_compra').AsCurrency - dsTabela.DataSet.FieldByName('vlr_abatido').AsCurrency)/
  (StrToInt(edQtdParc.Text));
  cdsParcelasvencimento.AsDateTime   := IncMonth(Date,I);

end;

end;

procedure TFormCadContasPagar.SpeedButton6Click(Sender: TObject);
begin
  cdsParcelas.EmptyDataSet;
end;

procedure TFormCadContasPagar.tabsheet1Show(Sender: TObject);
begin
  inherited;
    edVariacao.Text := '30';
    dsTabela.DataSet.FieldByName('dt_compra').AsDateTime    :=  Date;
    dsTabela.DataSet.FieldByName('dt_cadastro').AsDateTime  :=  Date;
end;

end.
