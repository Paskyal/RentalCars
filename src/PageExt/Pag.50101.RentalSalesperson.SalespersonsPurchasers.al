/// <summary>
/// PageExtension Rental Customer Card (ID 50100) extends Record Customer Card.
/// </summary>
pageextension 50101 "Rental Salesperson" extends "Salespersons/Purchasers"
{
    Layout
    {
        addbefore(Control1900383207)
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