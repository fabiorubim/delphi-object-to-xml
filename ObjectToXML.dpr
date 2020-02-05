program ObjectToXML;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FormObjectToXML};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormObjectToXML, FormObjectToXML);
  Application.Run;
end.
