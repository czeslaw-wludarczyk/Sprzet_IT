unit add_user;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, Windows;

type

  { TfrmAddUser }

  TfrmAddUser = class(TForm)
    edtName: TEdit;
    edtSurname: TEdit;
    edtNumber: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblUserExist: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    pnlEditName: TPanel;
    pnlEditSurname: TPanel;
    pnlEditNumber: TPanel;
    Shape1: TShape;
    shpBtnClose1: TBGRAShape;
    shpBtnClose2: TBGRAShape;
    shpBtnClose3: TBGRAShape;
    btnSave: TButton;
    btnCancel: TButton;
    chbActive: TCheckBox;
    lblName: TLabel;
    lblSurname: TLabel;
    lblNumber: TLabel;
    lblActive: TLabel;
    lblClose: TLabel;
    lblUserName1: TLabel;
    shpEditBck1: TBGRAShape;
    shpEditBck2: TBGRAShape;
    shpEditBck3: TBGRAShape;
    shpFormBck: TBGRAShape;
    shpFormBck1: TBGRAShape;
    shpLine3: TShape;
    shpLineEdit2: TShape;
    shpLineEdit3: TShape;
    shpLineEdit4: TShape;
    shpLineEdit5: TShape;
    shpLineEdit6: TShape;
    shpLineEdit7: TShape;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure edtNameEnter(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtNameKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtNumberEnter(Sender: TObject);
    procedure edtNumberExit(Sender: TObject);
    procedure edtNumberKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtSurnameChange(Sender: TObject);
    procedure edtSurnameEnter(Sender: TObject);
    procedure edtSurnameExit(Sender: TObject);
    procedure edtSurnameKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure lblCloseClick(Sender: TObject);
    procedure lblCloseMouseEnter(Sender: TObject);
    procedure lblCloseMouseLeave(Sender: TObject);
  private
    procedure Save();
  public
  var
    added_item: string;

  end;

var
  frmAddUser: TfrmAddUser;

implementation

{$R *.lfm}

uses shadow, Data;

  { TfrmAddUser }
procedure TfrmAddUser.Save();
var
  status: integer;
begin
  if (edtName.Text <> '') and (edtSurname.Text <> '') then
  begin
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select first_name, last_name, customer_number, status from customers where first_name = :name'
      +
      ' and last_name = :surname';
    DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('surname').AsString := edtSurname.Text;
    DBModule.SQLQuery.Open;
  end
  else
  begin
    if (edtName.Text = '') or (edtName.Text = ' ') then shpEditBck1.BorderColor := clRed;
    if (edtSurname.Text = '') or (edtSurname.Text = ' ') then
      shpEditBck2.BorderColor := clRed;
    Exit;
  end;

  if DBModule.SQLQuery.RecordCount > 0 then
  begin
    lblUserExist.Visible := True;
    Exit;
  end;

  //Insert data to database
  if chbActive.Checked then status := 1
  else
    status := 0;

  try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'insert into customers (first_name, last_name, full_name, customer_number, status)VALUES(:name '
      +
      ',:surname, :fullname, :number, :status)';
    DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('surname').AsString := edtSurname.Text;
    DBModule.SQLQuery.ParamByName('fullname').AsString := edtname.Text + ' ' + edtSurname.Text;
    if edtNumber.Text <> '' then
      DBModule.SQLQuery.Params.ParamByName('number').AsString := edtNumber.Text
    else
      DBModule.SQLQuery.Params.ParamByName('number').Clear;
    DBModule.SQLQuery.Params.ParamByName('status').AsInteger := status;
    DBModule.SQLQuery.ExecSQL;
    added_item := edtName.Text + ' ' + edtSurname.Text;
  except
  end;
  //Close Form
  Close();
end;

procedure TfrmAddUser.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmAddUser.Color, 255, LWA_COLORKEY);
  //Set clear edit boxes
  added_item := '';
  edtName.Text := '';
  edtSurname.Text := '';
  edtNumber.Text := '';
  chbActive.Checked := True;
  edtName.SetFocus;

  //Set GUI
  lblUserExist.Width:= frmAddUser.Width;
  lblUserExist.Left:=0;

  shpEditBck1.BorderColor := clSilver;
  shpEditBck2.BorderColor := clSilver;

end;

procedure TfrmAddUser.edtNameEnter(Sender: TObject);
begin
  edtName.SetFocus;
  shpEditBck1.Height := 28;
  shpLineEdit2.Pen.Color := $00BA6900;
  shpLineEdit3.Pen.Color := $00BA6900;
end;

procedure TfrmAddUser.edtNameExit(Sender: TObject);
begin
  shpEditBck1.Height := 29;
  shpLineEdit2.Pen.Color := $00969696;
  shpLineEdit3.Pen.Color := $00969696;
end;

procedure TfrmAddUser.btnCancelClick(Sender: TObject);
begin
  frmShadow.Close;
  Close;
end;

procedure TfrmAddUser.btnSaveClick(Sender: TObject);
begin
  Save();
end;

procedure TfrmAddUser.edtNameChange(Sender: TObject);
begin
  shpEditBck1.BorderColor := clSilver;
end;

procedure TfrmAddUser.edtNameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck1.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

procedure TfrmAddUser.edtSurnameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck2.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

procedure TfrmAddUser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

procedure TfrmAddUser.edtNumberEnter(Sender: TObject);
begin
  edtNumber.SetFocus;
  shpEditBck3.Height := 28;
  shpLineEdit6.Pen.Color := $00BA6900;
  shpLineEdit7.Pen.Color := $00BA6900;
end;

procedure TfrmAddUser.edtNumberExit(Sender: TObject);
begin
  shpEditBck3.Height := 29;
  shpLineEdit6.Pen.Color := $00969696;
  shpLineEdit7.Pen.Color := $00969696;
end;

procedure TfrmAddUser.edtNumberKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck3.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

procedure TfrmAddUser.edtSurnameChange(Sender: TObject);
begin
  shpEditBck2.BorderColor := clSilver;
end;

procedure TfrmAddUser.edtSurnameEnter(Sender: TObject);
begin
  edtSurname.SetFocus;
  shpEditBck2.Height := 28;
  shpLineEdit4.Pen.Color := $00BA6900;
  shpLineEdit5.Pen.Color := $00BA6900;
end;

procedure TfrmAddUser.edtSurnameExit(Sender: TObject);
begin
  shpEditBck2.Height := 29;
  shpLineEdit4.Pen.Color := $00969696;
  shpLineEdit5.Pen.Color := $00969696;
end;

procedure TfrmAddUser.lblCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddUser.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmAddUser.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

end.
