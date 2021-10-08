/// <summary>
/// PageExtension Rental Customer Card (ID 50100) extends Record Customer Card.
/// </summary>
pageextension 50100 "Rental Customer Card" extends "Customer Card"
{
    Layout
    {
        addafter("Disable Search by Name")
        {
            field("Rental Customer Discount"; Rec."Rental Customer Discount")
            {
                ToolTip = 'Specifies the value of the Discount field';
                ApplicationArea = All;
                MaxValue = 100;
                MinValue = 0;
            }
        }
        addbefore(SalesHistSelltoFactBox)
        {
            part(RentalHistRenttoFactBox; "Rental Hist. Rent-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(RentalCustomerStatFactBox; "Rental Customer Stat. FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
        }
    }
}