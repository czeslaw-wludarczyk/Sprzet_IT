unit dashboard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  BGRAShape, data;

type

  { TfrmDashboard }

  TfrmDashboard = class(TForm)
    lblAccesories1: TLabel;
    lblAccesories2: TLabel;
    lblAccesories3: TLabel;
    lblAccesories4: TLabel;
    lblAccesoriesCountUse: TLabel;
    lblPhonesCountUse: TLabel;
    lblAccessoriesFree: TLabel;
    lblPhonesFree: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnlCustomersInner1: TPanel;
    shpBckCustomers: TBGRAShape;
    shpBckComputers: TBGRAShape;
    shpBckAccesories: TBGRAShape;
    BGRAShape4: TBGRAShape;
    FlowPanel1: TFlowPanel;
    lblCustomersTitle: TLabel;
    lblComputersFree: TLabel;
    lblComputersTitle: TLabel;
    lblAccesoriesTitle: TLabel;
    Label4: TLabel;
    lblCustomers1: TLabel;
    lblCustomersCount: TLabel;
    lblComputers2: TLabel;
    lblComputers3: TLabel;
    lblComputersCountUse: TLabel;
    pnlCustomers: TPanel;
    pnlComputers: TPanel;
    pnlAccesories: TPanel;
    pnlPhone: TPanel;
    ScrollBox1: TScrollBox;
    procedure FormShow(Sender: TObject);
  private
    procedure ReadData();

  public

  end;

var
  frmDashboard: TfrmDashboard;

implementation

{$R *.lfm}

{ TfrmDashboard }

procedure TfrmDashboard.FormShow(Sender: TObject);
begin
  ReadData();
end;

procedure TfrmDashboard.ReadData();
begin
  //Read users
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from customers where status = 1';
  DBModule.SQLQuery.Open;
  //Label customers
  lblCustomersCount.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read computers free
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Komputer" and items.id_customer is NULL';
  DBModule.SQLQuery.Open;
  //Label computers free
  lblComputersFree.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read computers used
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Komputer" and items.id_customer is not NULL';
  DBModule.SQLQuery.Open;
  //Label computers used
  lblComputersCountUse.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read accessories free
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Akcesoria" and items.id_customer is NULL';
  DBModule.SQLQuery.Open;
  //Label accessories free
  lblAccessoriesFree.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read accessories used
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Akcesoria" and items.id_customer is not NULL';
  DBModule.SQLQuery.Open;
  //Label accessories used
  lblAccesoriesCountUse.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read phones free
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Telefon" and items.id_customer is NULL';
  DBModule.SQLQuery.Open;
  //Label phones free
  lblPhonesFree.Caption:= DBModule.SQLQuery.Fields[0].AsString;

  //Read phones used
  DBModule.SQLQuery.Close;
  DBModule.SQLQuery.SQL.Text:= 'select count(*) from items inner JOIN category_items on category_items.id_category = items.category where category_items.category = "Telefon" and items.id_customer is not NULL';
  DBModule.SQLQuery.Open;
  //Label phones used
  lblPhonesCountUse.Caption:= DBModule.SQLQuery.Fields[0].AsString;
end;

end.

