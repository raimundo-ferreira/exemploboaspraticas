program prjExemplo;

uses
  Vcl.Forms,
  view.main in 'src\view.main.pas' {frmMain},
  service.vendaitem in 'src\service.vendaitem.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
