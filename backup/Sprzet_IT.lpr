program Sprzet_IT;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, runtimetypeinfocontrols, lazcontrols, Main,
  dashboard, Data, users, add_user, shadow;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDBModule, DBModule);
  Application.CreateForm(TfrmDashboard, frmDashboard);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAddUser, frmAddUser);
  Application.CreateForm(TfrmShadow, frmShadow);
  Application.CreateForm(TfrmUsers, frmUsers);
  Application.Run;
end.

