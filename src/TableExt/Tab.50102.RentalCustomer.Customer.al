/// <summary>
/// TableExtension Rental Customer (ID 50102) extends Record Customer.
/// </summary>
tableextension 50102 "Rental Customer" extends Customer
{
    fields
    {
        field(50100; "Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;

        }
    }
}
