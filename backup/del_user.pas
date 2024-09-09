unit del_user;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, del_user_error, Windows;

type

  { TfrmDelUser }

  TfrmDelUser = class(TfrmDelUserError)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
  private

  public

  end;

var
  frmDelUser: TfrmDelUser;

implementation

{$R *.lfm}

uses shadow, Data;

{ TfrmDelUser }

procedure TfrmDelUser.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  frmShadow.Close();
end;

procedure TfrmDelUser.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmDelUser.Color, 255, LWA_COLORKEY);
  //Set focus to default button
  btnCancel.SetFocus;
end;

procedure TfrmDelUser.lblCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmDelUser.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmDelUser.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

end.
