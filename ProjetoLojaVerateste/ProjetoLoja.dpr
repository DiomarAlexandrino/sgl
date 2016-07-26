program ProjetoLoja;

uses
  Vcl.Forms,
  uFormPrincipal in 'view\uFormPrincipal.pas' {FormPrincipal},
  uDM in 'dataModule\uDM.pas' {DM: TDataModule},
  uFormCadBasico in 'view\uFormCadBasico.pas' {FormCadBasico},
  uFormCadUsuario in 'view\uFormCadUsuario.pas' {FormCadUsuario},
  uFormCadContasPagar in 'view\uFormCadContasPagar.pas' {FormCadContasPagar},
  uformCadReceber in 'view\uformCadReceber.pas' {FormCadContasReceber},
  uFormCadCaixa in 'view\uFormCadCaixa.pas' {FormCadCaixa},
  UFuncoes in 'view\UFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
