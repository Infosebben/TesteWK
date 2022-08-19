program TesteWK;

uses
  Forms,
  UPrincipal in 'View\UPrincipal.pas' {FormPrincipal},
  UDMPrincipal in 'Model\UDMPrincipal.pas' {DMPrincipal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.Run;
end.
