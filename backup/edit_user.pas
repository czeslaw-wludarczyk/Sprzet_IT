unit edit_user;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, Windows;

type

  { TfrmEditUser }

  TfrmEditUser = class(TForm)
    btnCancel: TButton;
    btnSave: TButton;
    chbActive: TCheckBox;
    edtName: TEdit;
    edtNumber: TEdit;
    edtSurname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblActive: TLabel;
    lblClose: TLabel;
    lblName: TLabel;
    lblNumber: TLabel;
    lblSurname: TLabel;
    lblUserExist: TLabel;
    lblUserName1: TLabel;
    pnlEditName: TPanel;
    pnlEditNumber: TPanel;
    pnlEditSurname: TPanel;
    Shape1: TShape;
    shpBtnClose1: TBGRAShape;
    shpBtnClose2: TBGRAShape;
    shpBtnClose3: TBGRAShape;
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
    procedure btnSaveClick(Sender: TObject);
    procedure chbActiveChange(Sender: TObject);
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
    procedure GetCustomerData();
    procedure UpdateCustomerData();
  public

  end;

var
  frmEditUser: TfrmEditUser;

implementation

{$R *.lfm}

uses shadow, Data, users;

  { TfrmEditUser }

procedure TfrmEditUser.GetCustomerData();
var
  status: integer;
begin
  //Get customer data
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text :=
    'select * from customers where id_customer = :id_customer';
  DBModule.SQLQuery.Params.ParamByName('id_customer').AsInteger :=
    TCustomer(frmUsers.stBoxUsers.Items.Objects[frmusers.stBoxUsers.ItemIndex]).id_customer;
  DBModule.SQLQuery.Open;

  //Set editbox with selected user data
  edtName.Text := DBModule.SQLQuery.FieldByName('first_name').AsString;
  edtSurname.Text := DBModule.SQLQuery.FieldByName('last_name').AsString;
  edtNumber.Text := DBModule.SQLQuery.FieldByName('customer_number').AsString;
  status := DBModule.SQLQuery.FieldByName('status').AsInteger;

  if status = 1 then chbActive.Checked := True
  else
    chbActive.Checked := False;
end;

procedure TfrmEditUser.UpdateCustomerData();
var
  status: integer;
begin
  if (edtName.Text <> '') and (edtSurname.Text <> '') then
  begin
    try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'select first_name, last_name, customer_number, status from customers where first_name = :name'
      +
      ' and last_name = :surname';
    DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('surname').AsString := edtSurname.Text;
    DBModule.SQLQuery.Open;
    except
      on e: Exception do
      ShowMessage(e.ToString);
    end;
  end
  else
  begin
    if (edtName.Text = '') or (edtName.Text = '') then shpEditBck1.BorderColor := clRed;
    if (edtSurname.Text = '') or (edtSurname.Text = '') then
      shpEditBck2.BorderColor := clRed;
    Exit;
  end;

  if chbActive.Checked then status := 1
  else
    status := 0;

  //Check if number or status changed - if yes then update existing customer data
  if (DBModule.SQLQuery.RecordCount > 0) and
    (DBModule.SQLQuery.FieldByName('customer_number').AsString = edtNumber.Text) and
    (DBModule.SQLQuery.FieldByName('status').AsInteger = status) then
  begin
    lblUserExist.Visible := True;
  end;

  if lblUserExist.Visible then
  begin
    //if user exist exit procedure
    exit;
  end
  else
  begin
    //update user data
    try
    DBModule.SQLQuery.Close;
    DBModule.SQLQuery.SQL.Text :=
      'update customers set first_name = :name, last_name = :surname, customer_number = :number,'
      +
      'status = :status, full_name = :fullname  where id_customer = :id';
    DBModule.SQLQuery.Params.ParamByName('name').AsString := edtName.Text;
    DBModule.SQLQuery.Params.ParamByName('surname').AsString := edtSurname.Text;
    DBModule.SQLQuery.Params.ParamByName('fullname').AsString :=
      edtName.Text + ' ' + edtSurname.Text;

    if edtNumber.Text <> '' then
      DBModule.SQLQuery.Params.ParamByName('number').AsString := edtNumber.Text
    else
      DBModule.SQLQuery.Params.ParamByName('number').Clear;

    DBModule.SQLQuery.Params.ParamByName('status').AsInteger := status;
    DBModule.SQLQuery.Params.ParamByName('id').AsInteger :=
      TCustomer(frmUsers.stBoxUsers.Items.Objects[frmUsers.stBoxUsers.ItemIndex]).id_customer;
    DBModule.SQLQuery.ExecSQL;
    Close();
    except
      on e: Exception do
      begin
      ShowMessage(e.ToString);
      lblUserExist.Visible := True;
      shpEditBck1.BorderColor := clRed;
      shpEditBck2.BorderColor := clRed;
      end;
    end;
  end;

end;

procedure TfrmEditUser.FormShow(Sender: TObject);
begin
  Color := $00C9C9C9;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
    WS_EX_LAYERED);
  SetLayeredWindowAttributes(Handle, frmEditUser.Color, 255, LWA_COLORKEY);

  //Get Customers data
  GetCustomerData();

  //Set editbox colors
  shpEditBck1.BorderColor := clSilver;
  shpEditBck2.BorderColor := clSilver;

  //Set lblUserExist to hide
  lblUserExist.Visible := False;
  //Set focus to first edit (edtName)
  edtName.SetFocus;
  edtName.SelStart := Length(edtName.Text);

end;

procedure TfrmEditUser.lblCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmEditUser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  frmShadow.Close();
end;

procedure TfrmEditUser.lblCloseMouseEnter(Sender: TObject);
begin
  shpBtnClose1.Visible := True;
  shpBtnClose2.Visible := True;
  shpBtnClose3.Visible := True;
  lblClose.Font.Color := clWhite;
end;

procedure TfrmEditUser.lblCloseMouseLeave(Sender: TObject);
begin
  shpBtnClose1.Visible := False;
  shpBtnClose2.Visible := False;
  shpBtnClose3.Visible := False;
  lblClose.Font.Color := clBlack;
end;

procedure TfrmEditUser.edtNameEnter(Sender: TObject);
begin
  edtName.SetFocus;
  shpEditBck1.Height := 28;
  shpLineEdit2.Pen.Color := $00BA6900;
  shpLineEdit3.Pen.Color := $00BA6900;
  edtName.SelStart := Length(edtName.Text);
end;

procedure TfrmEditUser.btnSaveClick(Sender: TObject);
begin
  UpdateCustomerData();
end;

procedure TfrmEditUser.chbActiveChange(Sender: TObject);
begin
  lblUserExist.Visible := False;
end;

procedure TfrmEditUser.edtNameChange(Sender: TObject);
begin
  shpEditBck1.BorderColor := clSilver;
end;

procedure TfrmEditUser.edtNameExit(Sender: TObject);
begin
  shpEditBck1.Height := 29;
  shpLineEdit2.Pen.Color := $00969696;
  shpLineEdit3.Pen.Color := $00969696;
end;

procedure TfrmEditUser.edtNameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck1.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

procedure TfrmEditUser.edtNumberEnter(Sender: TObject);
begin
  edtNumber.SetFocus;
  shpEditBck3.Height := 28;
  shpLineEdit6.Pen.Color := $00BA6900;
  shpLineEdit7.Pen.Color := $00BA6900;
  edtNumber.SelStart := Length(edtNumber.Text);
end;

procedure TfrmEditUser.edtNumberExit(Sender: TObject);
begin
  shpEditBck3.Height := 29;
  shpLineEdit6.Pen.Color := $00969696;
  shpLineEdit7.Pen.Color := $00969696;
end;

procedure TfrmEditUser.edtNumberKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck3.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

procedure TfrmEditUser.edtSurnameChange(Sender: TObject);
begin
  shpEditBck2.BorderColor := clSilver;
end;

procedure TfrmEditUser.edtSurnameEnter(Sender: TObject);
begin
  edtSurname.SetFocus;
  shpEditBck2.Height := 28;
  shpLineEdit4.Pen.Color := $00BA6900;
  shpLineEdit5.Pen.Color := $00BA6900;
  edtSurname.SelStart := Length(edtSurname.Text);
end;

procedure TfrmEditUser.edtSurnameExit(Sender: TObject);
begin
  shpEditBck2.Height := 29;
  shpLineEdit4.Pen.Color := $00969696;
  shpLineEdit5.Pen.Color := $00969696;
end;

procedure TfrmEditUser.edtSurnameKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Key := VK_TAB;
  shpEditBck2.BorderColor := clSilver;
  lblUserExist.Visible := False;
end;

end.
