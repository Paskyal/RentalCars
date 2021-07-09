tableextension 50102 "Rental Customer" extends Customer
{
    fields
    {
        field(50100; "Rental Discount"; Decimal)
        {
            Caption = 'Rental Discount';
            DataClassification = CustomerContent;

        }
    }
}
