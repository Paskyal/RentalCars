page 50114 "Rental Customer Stat. FactBox"
{
    Caption = 'Customer Statistics';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = 'Customer No.';
                ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    DtldCustLedgEntry.SetRange("Customer No.", Rec."No.");
                    Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                    CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                end;
            }
            group("Rental Order")
            {
                Caption = 'Rental Orders';
                field("Rental Average Cost"; Rec."Rental Average Cost")
                {
                    Caption = 'Average Cost';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Average Price"; Rec."Rental Average Price")
                {
                    Caption = 'Average Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Average Profit"; Rec."Rental Average Profit")
                {
                    Caption = 'Average Profit';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
            }
            group("Rental Posted Order")
            {
                Caption = 'Rental Posted Orders';
                field("Rental Posted Average Cost"; Rec."Rental Average Cost")
                {
                    Caption = 'Average Cost';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Posted Average Price"; Rec."Rental Average Price")
                {
                    Caption = 'Average Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Posted Average Profit"; Rec."Rental Average Profit")
                {
                    Caption = 'Average Profit';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
            }
            group(Total)
            {
                Caption = 'Total';
                field("Rental Total Average Cost"; Rec."Rental Average Cost")
                {
                    Caption = 'Average Cost';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Total Average Price"; Rec."Rental Average Price")
                {
                    Caption = 'Average Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
                field("Rental Total Average Profit"; Rec."Rental Average Profit")
                {
                    Caption = 'Average Profit';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Rental Orders field.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CustomerNo: Code[20];
        CustomerNoFilter: Text;
    begin
        Rec.FilterGroup(4);
        // Get the customer number and set the current customer number
        CustomerNoFilter := Rec.GetFilter("No.");
        if (CustomerNoFilter = '') then begin
            Rec.FilterGroup(0);
            CustomerNoFilter := Rec.GetFilter("No.");
        end;

        CustomerNo := CopyStr(CustomerNoFilter, 1, MaxStrLen(CustomerNo));
        if CustomerNo <> CurrCustomerNo then begin
            CurrCustomerNo := CustomerNo;
            CalculateFieldValues(CurrCustomerNo);
        end;
    end;

    var
        TaskIdCalculateCue: Integer;
        CurrCustomerNo: Code[20];

    protected var
        LastPaymentDate: Date;
        TotalAmountLCY: Decimal;
        OverdueBalance: Decimal;
        SalesLCY: Decimal;
        InvoicedPrepmtAmountLCY: Decimal;

    procedure CalculateFieldValues(CustomerNo: Code[20])
    var
        Args: Dictionary of [Text, Text];
    begin
        if (TaskIdCalculateCue <> 0) then
            CurrPage.CancelBackgroundTask(TaskIdCalculateCue);

        Clear(LastPaymentDate);
        Clear(TotalAmountLCY);
        Clear(OverdueBalance);
        Clear(SalesLCY);
        Clear(InvoicedPrepmtAmountLCY);

        if CustomerNo = '' then
            exit;
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::"Calculate Customer Stats.", Args);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        if (TaskId = TaskIdCalculateCue) then
            if Results.Count() = 0 then
                exit;
    end;

    [TryFunction]
    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::"Customer Card", Rec);
    end;

    // local procedure SetFilterLastPaymentDateEntry(var CustLedgerEntry: Record "Cust. Ledger Entry")
    // begin
    //     CustLedgerEntry.SetCurrentKey("Document Type", "Customer No.", "Posting Date", "Currency Code");
    //     CustLedgerEntry.SetRange("Customer No.", Rec."No.");
    //     CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Payment);
    //     CustLedgerEntry.SetRange(Reversed, false);
    // end;

    // local procedure SetFilterRefundEntry(var CustLedgerEntry: Record "Cust. Ledger Entry")
    // begin
    //     CustLedgerEntry.SetCurrentKey("Document Type", "Customer No.", "Posting Date", "Currency Code");
    //     CustLedgerEntry.SetRange("Customer No.", Rec."No.");
    //     CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Refund);
    //     CustLedgerEntry.SetRange(Reversed, false);
    // end;
}

