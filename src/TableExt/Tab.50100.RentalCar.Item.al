tableextension 50100 "Rental Car" extends Item
{
    fields
    {
        field(50105; "Rental Mileage"; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
        }
        field(50106; "Rental Fuel Cons./100km"; Text[20])
        {
            Caption = 'Fuel Cons./100km';
            DataClassification = CustomerContent;
        }
        field(50107; "Rental Price/1 day"; Integer)
        {
            Caption = 'Price/1 day';
            DataClassification = CustomerContent;
        }
        field(50108; "Rental Doors"; Integer)
        {
            Caption = 'Doors';
            DataClassification = CustomerContent;
        }
        field(50109; "Rental Trunk Vol./Bags"; Text[30])
        {
            Caption = 'Trunk Vol./Bags';
            DataClassification = CustomerContent;
        }
        field(50110; "Rental Car Discount"; Decimal)
        {
            Caption = 'Car Discount';
            DataClassification = CustomerContent;
        }
    }
}