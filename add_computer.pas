unit add_computer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, Windows, Types;

type

  { TfrmAddComputer }

  TfrmAddComputer = class(TForm)
    btnCancel: TButton;
    btnSave: TButton;
    edtName: TEdit;
    edtNumber: TEdit;
    edtNumber1: TEdit;
    edtNumber2: TEdit;
    edtSurname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblClose: TLabel;
    lblType: TLabel;
    lblMark: TLabel;
    lblModel: TLabel;
    lblSerialNumber: TLabel;
    lblDescription: TLabel;
    lblName_AQ: TLabel;
    lblComputerExist: TLabel;
    lblComputerTitle: TLabel;
    lblType1: TLabel;
    lsboxTypeMenu: TListBox;
    Memo1: TMemo;
    pnlTypeMenu: TPanel;
    pnlEditType: TPanel;
    pnlEditDescription: TPanel;
    pnlEditMark: TPanel;
    pnlEditModel: TPanel;
    pnlEditSerialNumber: TPanel;
    pnlEditName_AQ: TPanel;
    Shape1: TShape;
    shpBtnClose1: TBGRAShape;
    shpBtnClose2: TBGRAShape;
    shpBtnClose3: TBGRAShape;
    shpEditBck1: TBGRAShape;
    shpEditBck2: TBGRAShape;
    shpEditBck3: TBGRAShape;
    shpEditBck4: TBGRAShape;
    shpEditBck5: TBGRAShape;
    shpEditBck6: TBGRAShape;
    shpEditBck7: TBGRAShape;
    shpFormBck: TBGRAShape;
    shpFormBck1: TBGRAShape;
    shpLine3: TShape;
    shpLineEdit10: TShape;
    shpLineEdit11: TShape;
    shpLineEdit12: TShape;
    shpLineEdit13: TShape;
    shpLineEdit2: TShape;
    shpLineEdit3: TShape;
    shpLineEdit4: TShape;
    shpLineEdit5: TShape;
    shpLineEdit6: TShape;
    shpLineEdit7: TShape;
    shpLineEdit8: TShape;
    shpLineEdit9: TShape;
    procedure edtNameDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lsboxTypeMenuClick(Sender: TObject);
    procedure lsboxTypeMenuDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lsboxTypeMenuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure shpFormBckMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
  private
     procedure CloseTypeMenu();

  public
  var
    added_item: string;

  end;

var
  frmAddComputer: TfrmAddComputer;

implementation

{$R *.lfm}

uses shadow, Data;

  { TfrmAddComputer }

procedure TfrmAddComputer.CloseTypeMenu();
begin
 if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False;
end;

procedure TfrmAddComputer.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmAddComputer.Color, 255, LWA_COLORKEY);
  //Set clear edit boxes
  pnlTypeMenu.Visible := False;
end;

procedure TfrmAddComputer.lsboxTypeMenuClick(Sender: TObject);
begin
  pnlTypeMenu.Visible := False;
  edtName.Text := lsboxTypeMenu.Items[lsboxTypeMenu.ItemIndex];
end;

procedure TfrmAddComputer.lsboxTypeMenuDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin
    if odSelected in State then Brush.Color := $00F9EEE0;
    Font.Color := clBlack;
    FillRect(ARect);
    TextOut(ARect.Left + 5, ARect.Top + 2,  (Control as TListBox).Items[Index]);
  end;
end;

procedure TfrmAddComputer.lsboxTypeMenuMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  k: Integer;
begin
  k:= lsboxTypeMenu.ItemAtPos(Point(X,Y), true);
  lsboxTypeMenu.ItemIndex:=k;
end;

procedure TfrmAddComputer.edtNameDblClick(Sender: TObject);
begin
 if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False
  else
  begin
    pnlTypeMenu.Visible := True;
    lsboxTypeMenu.ItemIndex := 0;
  end;
end;

procedure TfrmAddComputer.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

procedure TfrmAddComputer.shpFormBckMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  CloseTypeMenu();
end;

end.
