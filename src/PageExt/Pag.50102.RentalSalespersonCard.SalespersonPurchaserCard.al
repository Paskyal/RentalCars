/// <summary>
/// PageExtension Rental Customer Card (ID 50100) extends Record Customer Card.
/// </summary>
pageextension 50102 "Rental Salesperson Card" extends "Salesperson/Purchaser Card"
{
    Layout
    {
        addbefore(Control3)
        {
            part(RentalSalespersonFactBox; "Rental Salesperson FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Name" = FIELD(Name),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(RentalSalespersStatFactBox; "Rental Salespers.Stat. FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Name" = FIELD("Name"),
                              "Date Filter" = FIELD("Date Filter");
            }
        }
    }
}