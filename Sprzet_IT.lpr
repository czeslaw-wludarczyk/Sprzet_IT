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
  dashboard, Data, users, add_user, shadow, del_user_error, edit_user, del_user,
  computers, add_computer;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDBModule, DBModule);
  Application.CreateForm(TfrmDashboard, frmDashboard);
  Application.CreateForm(TfrmAddUser, frmAddUser);
  Application.CreateForm(TfrmShadow, frmShadow);
  Application.CreateForm(TfrmUsers, frmUsers);
  Application.CreateForm(TfrmDelUserError, frmDelUserError);
  Application.CreateForm(TfrmEditUser, frmEditUser);
  Application.CreateForm(TfrmDelUser, frmDelUser);
  Application.CreateForm(TfrmComputers, frmComputers);
  Application.CreateForm(TfrmAddComputer, frmAddComputer);
  Application.Run;
end.

