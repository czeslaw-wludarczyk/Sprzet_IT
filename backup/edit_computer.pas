unit edit_computer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, Windows, Types;

type

  { TfrmEditComputer }

  TfrmEditComputer = class(TForm)
    btnCancel: TButton;
    btnSave: TButton;
    edtAQName: TEdit;
    edtDescription: TMemo;
    edtMark: TEdit;
    edtModel: TEdit;
    edtName: TEdit;
    edtSN: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblClose: TLabel;
    lblComputerExist: TLabel;
    lblComputerTitle: TLabel;
    lblDescription: TLabel;
    lblMark: TLabel;
    lblModel: TLabel;
    lblName_AQ: TLabel;
    lblSerialNumber: TLabel;
    lblType: TLabel;
    lblType1: TLabel;
    lsboxTypeMenu: TListBox;
    pnlEditDescription: TPanel;
    pnlEditMark: TPanel;
    pnlEditModel: TPanel;
    pnlEditName_AQ: TPanel;
    pnlEditSerialNumber: TPanel;
    pnlEditType: TPanel;
    pnlTypeMenu: TPanel;
    Shape1: TShape;
    shpBckButton1: TBGRAShape;
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
    procedure btnCancelClick(Sender: TObject);
    procedure edtAQNameEnter(Sender: TObject);
    procedure edtAQNameExit(Sender: TObject);
    procedure edtAQNameKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtDescriptionEnter(Sender: TObject);
    procedure edtDescriptionExit(Sender: TObject);
    procedure edtMarkEnter(Sender: TObject);
    procedure edtMarkExit(Sender: TObject);
    procedure edtMarkKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtModelEnter(Sender: TObject);
    procedure edtModelExit(Sender: TObject);
    procedure edtModelKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtNameDblClick(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: char);
    procedure edtSNEnter(Sender: TObject);
    procedure edtSNExit(Sender: TObject);
    procedure edtSNKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
    procedure lblType1Click(Sender: TObject);
    procedure lblType1MouseEnter(Sender: TObject);
    procedure lblType1MouseLeave(Sender: TObject);
    procedure lsboxTypeMenuClick(Sender: TObject);
    procedure lsboxTypeMenuDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lsboxTypeMenuKeyPress(Sender: TObject; var Key: char);
    procedure lsboxTypeMenuMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure shpFormBckMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
  private
    procedure CloseTypeMenu();
    procedure GetComputerData();
  public

  end;

var
  frmEditComputer: TfrmEditComputer;

implementation

{$R *.lfm}

uses computers, shadow, Data, db_helper;

  { TfrmEditComputer }

procedure TfrmEditComputer.CloseTypeMenu();
begin
  if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False;
end;

procedure TfrmEditComputer.GetComputerData();
var
  status: integer;
begin
  //Get customer data
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text :=
    'select * from items where id_item = :id_item';
  DBModule.SQLQuery.Params.ParamByName('id_item').AsInteger :=
    TComputer(frmComputers.stBoxComputers.Items.Objects[frmComputers.stBoxComputers.ItemIndex]).id_item;
  DBModule.SQLQuery.Open;

  //Set editbox with selected user data
  edtName.Text := DBModule.SQLQuery.FieldByName('name').AsString;
  edtAQName.Text := DBModule.SQLQuery.FieldByName('aq_name').AsString;
  edtMark.Text := DBModule.SQLQuery.FieldByName('mark').AsString;
  edtModel.Text := DBModule.SQLQuery.FieldByName('model').AsString;
  edtSN.Text := DBModule.SQLQuery.FieldByName('serial_number').AsString;
  edtDescription.Text:= DBModule.SQLQuery.FieldByName('description').AsString;;
end;

procedure TfrmEditComputer.lblCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmEditComputer.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

procedure TfrmEditComputer.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmEditComputer.Color, 255, LWA_COLORKEY);
  //Set clear edit boxes
  pnlTypeMenu.Visible := False;
  //Set edits boxes
  edtName.Caption := lsboxTypeMenu.Items[0];
  edtAQName.Clear;
  edtMark.Clear;
  edtModel.Clear;
  edtSN.Clear;
  edtDescription.Clear;
  edtAQName.SetFocus;

  //Set Gui
  lblComputerExist.Width := frmEditComputer.Width;
  lblComputerExist.Left := 0;

  shpEditBck2.BorderColor := clSilver;
  shpEditBck3.BorderColor := clSilver;
  shpEditBck4.BorderColor := clSilver;
  shpEditBck5.BorderColor := clSilver;

  //Get Computer Data
  GetComputerData();

end;

procedure TfrmEditComputer.btnCancelClick(Sender: TObject);
begin
  if pnlTypeMenu.Visible then
  begin
    pnlTypeMenu.Visible := False;
    Exit;
  end;
  Close();
end;

procedure TfrmEditComputer.edtAQNameEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtAQName.SetFocus;
  shpEditBck2.Height := 28;
  shpLineEdit4.Pen.Color := $00BA6900;
  shpLineEdit5.Pen.Color := $00BA6900;
  edtAQname.SelStart:= Length(edtAQName.Text);
end;

procedure TfrmEditComputer.edtAQNameExit(Sender: TObject);
begin
  shpLineEdit4.Pen.Color := $00969696;
  shpLineEdit5.Pen.Color := $00969696;
  shpEditBck2.Height := 29;
end;

procedure TfrmEditComputer.edtAQNameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck2.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmEditComputer.edtDescriptionEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtDescription.SetFocus;
  shpEditBck6.Height := shpEditBck6.Height - 1;
  shpLineEdit12.Pen.Color := $00BA6900;
  shpLineEdit13.Pen.Color := $00BA6900;
  edtDescription.SelStart:= Length(edtDescription.Text);
end;

procedure TfrmEditComputer.edtDescriptionExit(Sender: TObject);
begin
  shpEditBck6.Height := shpEditBck6.Height + 1;
  shpLineEdit12.Pen.Color := $00969696;
  shpLineEdit13.Pen.Color := $00969696;
end;

procedure TfrmEditComputer.edtMarkEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtMark.SetFocus;
  shpEditBck3.Height := 28;
  shpLineEdit6.Pen.Color := $00BA6900;
  shpLineEdit7.Pen.Color := $00BA6900;
  edtMark.SelStart:= Length(edtMark.Text);
end;

procedure TfrmEditComputer.edtMarkExit(Sender: TObject);
begin
  shpEditBck3.Height := 29;
  shpLineEdit6.Pen.Color := $00969696;
  shpLineEdit7.Pen.Color := $00969696;
end;

procedure TfrmEditComputer.edtMarkKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck3.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmEditComputer.edtModelEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtModel.SetFocus;
  shpEditBck4.Height := 28;
  shpLineEdit8.Pen.Color := $00BA6900;
  shpLineEdit9.Pen.Color := $00BA6900;
  edtModel.SelStart:= Length(edtModel.Text);
end;

procedure TfrmEditComputer.edtModelExit(Sender: TObject);
begin
  shpEditBck4.Height := 29;
  shpLineEdit8.Pen.Color := $00969696;
  shpLineEdit9.Pen.Color := $00969696;
end;

procedure TfrmEditComputer.edtModelKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck4.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmEditComputer.edtNameDblClick(Sender: TObject);
begin
  if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False
  else
  begin
    pnlTypeMenu.Visible := True;
    lsboxTypeMenu.ItemIndex := 0;
  end;
end;

procedure TfrmEditComputer.edtNameKeyPress(Sender: TObject; var Key: char);
begin

  if Key = char(32) then
  begin
    if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False
    else
    begin
      pnlTypeMenu.Visible := True;
      lsboxTypeMenu.ItemIndex := 0;
      lsboxTypeMenu.SetFocus;
    end;
  end;
end;

procedure TfrmEditComputer.edtSNEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtSN.SetFocus;
  shpEditBck5.Height := 28;
  shpLineEdit10.Pen.Color := $00BA6900;
  shpLineEdit11.Pen.Color := $00BA6900;
  edtSN.SelStart:= Length(edtSN.Text);
end;

procedure TfrmEditComputer.edtSNExit(Sender: TObject);
begin
  shpEditBck5.Height := 29;
  shpLineEdit10.Pen.Color := $00969696;
  shpLineEdit11.Pen.Color := $00969696;
end;

procedure TfrmEditComputer.edtSNKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck5.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmEditComputer.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmEditComputer.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

procedure TfrmEditComputer.lblType1Click(Sender: TObject);
begin
  if pnlTypeMenu.Visible then pnlTypeMenu.Visible := False
  else
  begin
    pnlTypeMenu.Visible := True;
    lsboxTypeMenu.ItemIndex := 0;
  end;
end;

procedure TfrmEditComputer.lblType1MouseEnter(Sender: TObject);
begin
  shpBckButton1.Visible := True;
end;

procedure TfrmEditComputer.lblType1MouseLeave(Sender: TObject);
begin
  shpBckButton1.Visible := False;
end;

procedure TfrmEditComputer.lsboxTypeMenuClick(Sender: TObject);
begin
  pnlTypeMenu.Visible := False;
  edtName.Text := lsboxTypeMenu.Items[lsboxTypeMenu.ItemIndex];
end;

procedure TfrmEditComputer.lsboxTypeMenuDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do
  begin
    if odSelected in State then Brush.Color := $00F9EEE0;
    Font.Color := clBlack;
    FillRect(ARect);
    TextOut(ARect.Left + 5, ARect.Top + 2, (Control as TListBox).Items[Index]);
  end;
end;

procedure TfrmEditComputer.lsboxTypeMenuKeyPress(Sender: TObject; var Key: char);
begin
  if Key = char(13) then
  begin
    pnlTypeMenu.Visible := False;
    edtName.Text := lsboxTypeMenu.Items[lsboxTypeMenu.ItemIndex];
    edtName.SetFocus;
  end;
end;

procedure TfrmEditComputer.lsboxTypeMenuMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
var
  k: integer;
begin
  k := lsboxTypeMenu.ItemAtPos(Point(X, Y), True);
  lsboxTypeMenu.ItemIndex := k;
end;

procedure TfrmEditComputer.shpFormBckMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  CloseTypeMenu();
end;

end.
