page 50100 "Rental Orders"
{
    Caption = 'Rental Orders';
    PageType = List;
    SourceTable = "Rental Order";
    CardPageId = "Rental Order Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order,Release,Posting,Print/Send,Navigate';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Doc. No. field';
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the value of the Customer Name field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        RentalOrder: Record "Rental Order";
                    // SalesBatchPostMgt: Codeunit "Sales Batch Post Mgt.";
                    // BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
                    begin
                        CurrPage.SetSelectionFilter(RentalOrder);
                        if RentalOrder.Count > 1 then
                            // BatchProcessingMgt.SetParameter("Batch Posting Parameter Type"::Invoice, true);
                            // BatchProcessingMgt.SetParameter("Batch Posting Parameter Type"::Ship, true);

                            // SalesBatchPostMgt.SetBatchProcessor(BatchProcessingMgt);
                            // SalesBatchPostMgt.RunWithUI(RentalOrder, Count, ReadyToPostQst);
                            // end else
                            PostDocument(CODEUNIT::"Rental Posted Order");
                    end;
                }
            }

        }
    }
    local procedure PostDocument(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        CurrPage.Update(false);
    end;

    procedure SendToPosting(PostingCodeunitID: Integer) IsSuccess: Boolean
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
    begin
        Commit();
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, Rec.RecordId, 0, '');
        IsSuccess := CODEUNIT.Run(PostingCodeunitID, Rec);
        if not IsSuccess then
            ErrorMessageHandler.ShowErrors();
    end;

}