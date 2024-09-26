unit add_computer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, Windows, Types;

type

  { TfrmAddComputer }

  TfrmAddComputer = class(TForm)
    shpBckButton1: TBGRAShape;
    btnCancel: TButton;
    btnSave: TButton;
    edtName: TEdit;
    edtMark: TEdit;
    edtModel: TEdit;
    edtSN: TEdit;
    edtAQName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
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
    edtDescription: TMemo;
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
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtAQNameChange(Sender: TObject);
    procedure edtAQNameExit(Sender: TObject);
    procedure edtAQNameKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtDescriptionEnter(Sender: TObject);
    procedure edtDescriptionExit(Sender: TObject);
    procedure edtMarkChange(Sender: TObject);
    procedure edtMarkExit(Sender: TObject);
    procedure edtMarkKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtModelChange(Sender: TObject);
    procedure edtModelExit(Sender: TObject);
    procedure edtModelKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtNameDblClick(Sender: TObject);
    procedure edtAQNameEnter(Sender: TObject);
    procedure edtMarkEnter(Sender: TObject);
    procedure edtModelEnter(Sender: TObject);
    procedure edtNameKeyPress(Sender: TObject; var Key: char);
    procedure edtSNChange(Sender: TObject);
    procedure edtSNEnter(Sender: TObject);
    procedure edtSNExit(Sender: TObject);
    procedure edtSNKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
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
    procedure Save();
  public
  var
    added_item: string;

  end;

var
  frmAddComputer: TfrmAddComputer;

implementation

{$R *.lfm}

uses shadow, Data, db_helper, computers;

  { TfrmAddComputer }

procedure TfrmAddComputer.Save();
var
  category: integer;
begin
  if (edtAQName.Text <> '') and (edtMark.Text <> '') and
    (edtModel.Text <> '') and (edtSN.Text <> '') then
  begin
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select aq_name, serial_number from items where aq_name = :aq_name or serial_number = :SN';
    //DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('aq_name').AsString := edtAQName.Text;
    //DBModule.SQLQuery.Params.ParamByName('mark').AsString := edtMark.Text;
    //DBModule.SQLQuery.Params.ParamByName('model').AsString := edtModel.Text;
    DBModule.SQLQuery.Params.ParamByName('SN').AsString := edtSN.Text;
    DBModule.SQLQuery.Open;
  end
  else
  begin
    if (edtAQName.Text = '') or (edtAQName.Text = ' ') then
      shpEditBck2.BorderColor := clRed;
    if (edtMark.Text = '') or (edtMark.Text = ' ') then shpEditBck3.BorderColor := clRed;
    if (edtModel.Text = '') or (edtModel.Text = ' ') then
      shpEditBck4.BorderColor := clRed;
    if (edtSN.Text = '') or (edtSN.Text = ' ') then shpEditBck5.BorderColor := clRed;
    Exit;
  end;


  if DBModule.SQLQuery.RecordCount > 0 then
  begin
    //Check SN number or name
    if DBModule.SQLQuery.FieldByName('serial_number').AsString = edtSN.Text then
    begin
      lblComputerExist.Caption := 'Komputer o tym numerze seryjnym już istnieje!';
      shpEditBck5.BorderColor := clRed;
    end
    else
    begin
      lblComputerExist.Caption := 'Komputer o tej nazwie już istnieje!';
      shpEditBck2.BorderColor := clRed;
    end;
    lblComputerExist.Visible := True;
    Exit;
  end;

  //Get category komputer ID;
  category := db_helper.Get_category();

  //Add computer to database
  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'insert into items (name, aq_name, mark, model, serial_number, category, description)VALUES(:name '
      + ',:aq_name, :mark, :model, :SN, :category, :description)';
    DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('aq_name').AsString := edtAQName.Text;
    DBModule.SQLQuery.Params.ParamByName('mark').AsString := edtMark.Text;
    DBModule.SQLQuery.Params.ParamByName('model').AsString := edtModel.Text;
    DBModule.SQLQuery.Params.ParamByName('SN').AsString := edtSN.Text;
    DBModule.SQLQuery.Params.ParamByName('category').AsInteger := category;
    DBModule.SQLQuery.Params.ParamByName('description').AsString := edtDescription.Text;
    added_item := edtAQName.Text;
    DBModule.SQLQuery.ExecSQL;
  except
  end;
  //Close Form
  Close();

end;

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
  //Set edits boxes
  edtName.Caption := lsboxTypeMenu.Items[0];
  edtAQName.Clear;
  edtMark.Clear;
  edtModel.Clear;
  edtSN.Clear;
  edtDescription.Clear;
  edtAQName.SetFocus;

  //Set Gui
  lblComputerExist.Width := frmAddComputer.Width;
  lblComputerExist.Left := 0;

  shpEditBck2.BorderColor := clSilver;
  shpEditBck3.BorderColor := clSilver;
  shpEditBck4.BorderColor := clSilver;
  shpEditBck5.BorderColor := clSilver;

end;

procedure TfrmAddComputer.lblCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmAddComputer.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmAddComputer.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

procedure TfrmAddComputer.lblType1MouseEnter(Sender: TObject);
begin
  shpBckButton1.Visible := True;
end;

procedure TfrmAddComputer.lblType1MouseLeave(Sender: TObject);
begin
  shpBckButton1.Visible := False;
end;

procedure TfrmAddComputer.lsboxTypeMenuClick(Sender: TObject);
begin
  pnlTypeMenu.Visible := False;
  edtName.Text := lsboxTypeMenu.Items[lsboxTypeMenu.ItemIndex];
end;

procedure TfrmAddComputer.lsboxTypeMenuDrawItem(Control: TWinControl;
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

procedure TfrmAddComputer.lsboxTypeMenuKeyPress(Sender: TObject; var Key: char);
begin
  if Key = char(13) then
  begin
    pnlTypeMenu.Visible := False;
    edtName.Text := lsboxTypeMenu.Items[lsboxTypeMenu.ItemIndex];
  end;
end;

procedure TfrmAddComputer.lsboxTypeMenuMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
var
  k: integer;
begin
  k := lsboxTypeMenu.ItemAtPos(Point(X, Y), True);
  lsboxTypeMenu.ItemIndex := k;
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

procedure TfrmAddComputer.btnCancelClick(Sender: TObject);
begin
  if pnlTypeMenu.Visible then
  begin
    pnlTypeMenu.Visible := False;
    Exit;
  end;
  Close();
end;

procedure TfrmAddComputer.btnSaveClick(Sender: TObject);
begin
  Save();
end;

procedure TfrmAddComputer.edtAQNameChange(Sender: TObject);
begin
  shpEditBck2.BorderColor := clSilver;
end;

procedure TfrmAddComputer.edtAQNameEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtAQName.SetFocus;
  shpEditBck2.Height := 28;
  shpLineEdit4.Pen.Color := $00BA6900;
  shpLineEdit5.Pen.Color := $00BA6900;
end;

procedure TfrmAddComputer.edtAQNameExit(Sender: TObject);
begin
  shpEditBck2.Height := 29;
  shpLineEdit4.Pen.Color := $00969696;
  shpLineEdit5.Pen.Color := $00969696;
end;

procedure TfrmAddComputer.edtAQNameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck2.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmAddComputer.edtMarkEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtMark.SetFocus;
  shpEditBck3.Height := 28;
  shpLineEdit6.Pen.Color := $00BA6900;
  shpLineEdit7.Pen.Color := $00BA6900;
end;

procedure TfrmAddComputer.edtMarkExit(Sender: TObject);
begin
  shpEditBck3.Height := 29;
  shpLineEdit6.Pen.Color := $00969696;
  shpLineEdit7.Pen.Color := $00969696;
end;

procedure TfrmAddComputer.edtMarkKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck3.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmAddComputer.edtModelChange(Sender: TObject);
begin
  shpEditBck4.BorderColor := clSilver;
end;

procedure TfrmAddComputer.edtModelEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtModel.SetFocus;
  shpEditBck4.Height := 28;
  shpLineEdit8.Pen.Color := $00BA6900;
  shpLineEdit9.Pen.Color := $00BA6900;
end;

procedure TfrmAddComputer.edtNameKeyPress(Sender: TObject; var Key: char);
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

procedure TfrmAddComputer.edtSNChange(Sender: TObject);
begin
  shpEditBck5.BorderColor := clSilver;
end;

procedure TfrmAddComputer.edtModelExit(Sender: TObject);
begin
  shpEditBck4.Height := 29;
  shpLineEdit8.Pen.Color := $00969696;
  shpLineEdit9.Pen.Color := $00969696;
end;

procedure TfrmAddComputer.edtModelKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck4.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmAddComputer.edtSNEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtSN.SetFocus;
  shpEditBck5.Height := 28;
  shpLineEdit10.Pen.Color := $00BA6900;
  shpLineEdit11.Pen.Color := $00BA6900;
end;

procedure TfrmAddComputer.edtSNExit(Sender: TObject);
begin
  shpEditBck5.Height := 29;
  shpLineEdit10.Pen.Color := $00969696;
  shpLineEdit11.Pen.Color := $00969696;
end;

procedure TfrmAddComputer.edtSNKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  shpEditBck5.BorderColor := clSilver;
  lblComputerExist.Visible := False;
end;

procedure TfrmAddComputer.edtDescriptionEnter(Sender: TObject);
begin
  CloseTypeMenu();
  edtDescription.SetFocus;
  shpEditBck6.Height := shpEditBck6.Height - 1;
  shpLineEdit12.Pen.Color := $00BA6900;
  shpLineEdit13.Pen.Color := $00BA6900;
end;

procedure TfrmAddComputer.edtDescriptionExit(Sender: TObject);
begin
  shpEditBck6.Height := shpEditBck6.Height + 1;
  shpLineEdit12.Pen.Color := $00969696;
  shpLineEdit13.Pen.Color := $00969696;
end;

procedure TfrmAddComputer.edtMarkChange(Sender: TObject);
begin
  shpEditBck3.BorderColor := clSilver;
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
