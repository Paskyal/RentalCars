tableextension 50102 "Rental Customer" extends Customer
{
    fields
    {
        field(50100; "Rental Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
        }
    }
}