page 50105 "Cars Card"
{

    Caption = 'Car specifications';
    DataCaptionExpression = '';
    PageType = Card;
    SourceTable = Item;
    UsageCategory = Documents;
    ApplicationArea = all;
    PopulateAllFields = true;
    PromotedActionCategories = 'New,Process,Report,Item,History,Prices & Discounts,Approve,Request Approval';


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the item card represents a physical inventory unit (Inventory), a labor time unit (Service), or a physical unit that is not tracked in inventory (Non-Inventory).';
                }
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

        area(factboxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = FIELD("No.");
            }
            part(ItemAttributesFactbox; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
            }
        }

    }
    actions
    {
        area(processing)
        {
            group(ItemActionGroup)
            {
                Caption = 'Item';
                Image = DataEntry;
                action(Attributes)
                {
                    AccessByPermission = TableData "Item Attribute" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attributes';
                    Image = Category;
                    Promoted = true;

                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                    trigger OnAction()
                    begin
                        PAGE.RunModal(PAGE::"Item Attribute Value Editor", Rec);
                        CurrPage.SaveRecord();
                        CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData(Rec."No.");
                    end;
                }
            }
            group(PricesandDiscounts)
            {
                Caption = 'Sales Prices & Discounts';
                action("Set Special Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices';
                    Image = Price;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'Set up sales prices for the item. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesPrice: Record "Sales Price";
                    begin
                        SalesPrice.SetRange("Item No.", Rec."No.");
                        Page.Run(Page::"Sales Prices", SalesPrice);
                    end;
                }
                action("Set Special Discounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Discounts';
                    Image = LineDiscount;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = not ExtendedPriceEnabled;
                    ToolTip = 'Set up sales discounts for the item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
                    ObsoleteTag = '17.0';

                    trigger OnAction()
                    var
                        SalesLineDiscount: Record "Sales Line Discount";
                    begin
                        SalesLineDiscount.SetCurrentKey(Type, Code);
                        SalesLineDiscount.SetRange(Type, SalesLineDiscount.Type::Item);
                        SalesLineDiscount.SetRange(Code, Rec."No.");
                        Page.Run(Page::"Sales Line Discounts", SalesLineDiscount);
                    end;
                }
                action(PricesDiscountsOverview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices & Discounts Overview';
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
                action(SalesPriceLists)
                {
                    AccessByPermission = TableData "Sales Price Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices';
                    Image = Price;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'Set up sales prices for the item. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Sale, AmountType::Price);
                        UpdateSpecialPriceListsTxt(PriceType::Sale);
                    end;
                }
                action(SalesPriceListsDiscounts)
                {
                    AccessByPermission = TableData "Sales Discount Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Discounts';
                    Image = LineDiscount;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category6;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'Set up sales discounts for the item. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        AmountType: Enum "Price Amount Type";
                        PriceType: Enum "Price Type";
                    begin
                        Rec.ShowPriceListLines(PriceType::Sale, AmountType::Discount);
                        UpdateSpecialPriceListsTxt(PriceType::Sale);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.ItemAttributesFactbox.PAGE.LoadItemAttributesData(Rec."No.");
    end;

    local procedure UpdateSpecialPriceListsTxt(PriceType: Enum "Price Type")
    begin
        if PriceType in [PriceType::Any, PriceType::Sale] then
            SalesPriceListsText := GetPriceActionText(PriceType::Sale);
        if PriceType in [PriceType::Any, PriceType::Purchase] then
            PurchPriceListsText := GetPriceActionText(PriceType::Purchase);
    end;

    local procedure GetPriceActionText(PriceType: Enum "Price Type"): Text
    var
        PriceListLine: Record "Price List Line";
        PriceAssetList: Codeunit "Price Asset List";
        PriceUXManagement: Codeunit "Price UX Management";
        AssetType: Enum "Price Asset Type";
        AmountType: Enum "Price Amount Type";
    begin
        PriceAssetList.Add(AssetType::Item, Rec."No.");
        PriceUXManagement.SetPriceListLineFilters(PriceListLine, PriceAssetList, PriceType, AmountType::Any);
        if PriceListLine.IsEmpty() then
            exit(CreateNewTxt);
        exit(ViewExistingTxt);
    end;

    trigger OnOpenPage()
    begin
        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();

    end;

    var
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
        SalesPriceListsText: Text;
        PurchPriceListsText: Text;
        CreateNewTxt: Label 'Create New...';
        ViewExistingTxt: Label 'View Existing Prices and Discounts...';

    protected var
        ExtendedPriceEnabled: Boolean;

}