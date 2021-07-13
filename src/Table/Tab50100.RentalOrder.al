
/// <summary>
/// Table Rental Order (ID 50100).
/// </summary>
table 50100 "Rental Order"
{
    Caption = 'Rental Order';
    DataClassification = CustomerContent;
    LookupPageId = "Rental Order line";
    DrillDownPageId = "Rental Order line";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetRentalSetup();
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
                end;
            end;
        }
        field(2; "Salesperson Name"; Code[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";

        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                CopyFromCustomer();
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = field("Customer No.")));
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(7; "Customer Discount"; Decimal)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InitInsert();
    end;

    /// <summary>
    /// InitInsert.
    /// </summary>
    procedure InitInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");//!
        end;
    end;

    local procedure TestNoSeries()
    begin
        GetRentalSetup();
        RentalSetup.Testfield("Order Nos.");

    end;

    local procedure GetRentalSetup()
    begin
        if RentalSetup.Get() then
            exit;
        RentalSetup.Init();
        RentalSetup.Insert(true);
        Commit();
    end;

    local procedure CopyFromCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.Get("Customer No.");
        Rec.Validate("Customer Discount", Customer."Customer Discount");
    end;


    /// <summary>
    /// GetNoSeriesCode.
    /// </summary>
    /// <returns>Return value of type Code[20].</returns>
    procedure GetNoSeriesCode(): Code[20]
    begin
        exit(NoSeriesMgt.GetNoSeriesWithCheck(RentalSetup."Order Nos.", false, "No. Series"));
    end;

    var
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}
