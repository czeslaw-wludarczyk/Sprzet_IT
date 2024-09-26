unit del_computer_error;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  BGRAShape, Windows;

type

  { TfrmDelComputerError }

  TfrmDelComputerError = class(TForm)
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
    procedure btnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
  private

  public

  end;

var
  frmDelComputerError: TfrmDelComputerError;

implementation

{$R *.lfm}

uses shadow;

{ TfrmDelComputerError }

procedure TfrmDelComputerError.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmDelComputerError.Color, 255, LWA_COLORKEY);
end;

procedure TfrmDelComputerError.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

procedure TfrmDelComputerError.btnOKClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmDelComputerError.lblCloseMouseEnter(Sender: TObject);
begin
  Close();
end;

procedure TfrmDelComputerError.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmDelComputerError.lblCloseClick(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

end.
