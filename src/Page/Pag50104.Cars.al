page 50104 "Cars"
{

    ApplicationArea = All;
    Caption = 'Cars';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    CardPageId = "Cars Card";
    Editable = false;
    SourceTableView = where(Type = const(Rental));
    PromotedActionCategories = 'New,Process,Report,Item,History,Prices & Discounts,Request Approval,Periodic Activities,Inventory,Attributes';
    layout
    {
        area(content)
        {

            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    Caption = 'Model,Year';
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }

                field(Mileage; Rec.Mileage)
                {
                    ToolTip = 'Specifies the value of the Mileage field';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Price per day';
                    ToolTip = 'Specifies the value of the Unit Price field';
                    ApplicationArea = All;
                }
                field("Car Discount"; Rec."Car Discount")
                {
                    Caption = 'Discount';
                    ToolTip = 'Specifies the value of the Car Discount field';
                    ApplicationArea = All;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            group(PricesandDiscounts)
            {
                Caption = 'Rental Prices & Discounts';
                action(Prices_Prices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Prices';
                    Image = Price;
                    Scope = Repeater;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'Set up sales prices for the selected item. An item price is automatically used on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    begin
                        ShowPrices();
                    end;
                }
                action(Prices_LineDiscounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Discounts';
                    Image = LineDiscount;
                    Scope = Repeater;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'Set up sales discounts for the selected item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    begin
                        ShowLineDiscounts();
                    end;
                }
                action(PricesDiscountsOverview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Prices & Discounts Overview';
                    Image = PriceWorksheet;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'View the sales prices and line discounts that you grant for this item when certain criteria are met, such as vendor, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesPriceAndLineDiscounts: Page "Sales Price and Line Discounts";
                    begin
                        SalesPriceAndLineDiscounts.InitPage(true);
                        SalesPriceAndLineDiscounts.LoadItem(Rec);
                        SalesPriceAndLineDiscounts.RunModal();
                    end;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();

    end;

    var
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";

    protected var
        ExtendedPriceEnabled: Boolean;

    local procedure ShowLineDiscounts()
    var
        SalesLineDiscount: Record "Sales Line Discount";
    begin
        SalesLineDiscount.SetCurrentKey(Type, Code);
        SalesLineDiscount.SetRange(Type, SalesLineDiscount.Type::Item);
        SalesLineDiscount.SetRange(Code, Rec."No.");
        Page.Run(Page::"Sales Line Discounts", SalesLineDiscount);
    end;

    [Obsolete('Replaced by the new implementation (V16) of price calculation.', '17.0')]
    local procedure ShowPrices()
    var
        SalesPrice: Record "Sales Price";
    begin
        SalesPrice.SetCurrentKey("Item No.");
        SalesPrice.SetRange("Item No.", Rec."No.");
        Page.Run(Page::"Sales Prices", SalesPrice);
    end;
}
