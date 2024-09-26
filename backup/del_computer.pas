unit del_computer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  BGRAShape, Windows;

type

  { TfrmDelComputer }

  TfrmDelComputer = class(TForm)
    btnCancel: TButton;
    btnOK: TButton;
    lblClose: TLabel;
    lblDeleteInfo: TLabel;
    lblUserDelTitle: TLabel;
    Shape1: TShape;
    shpBtnClose1: TBGRAShape;
    shpBtnClose2: TBGRAShape;
    shpBtnClose3: TBGRAShape;
    shpFormBck: TBGRAShape;
    shpFormBck1: TBGRAShape;
    shpLine3: TShape;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
  private

  public

  end;

var
  frmDelComputer: TfrmDelComputer;

implementation

{$R *.lfm}

uses shadow, Data;

  { TfrmDelComputer }


procedure TfrmDelComputer.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmDelComputer.Color, 255, LWA_COLORKEY);
  //Set focus to default button
  btnCancel.SetFocus;
end;

procedure TfrmDelComputer.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmDelComputer.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

procedure TfrmDelComputer.lblCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmDelComputer.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

end.
