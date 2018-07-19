<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="TransactionSequence.aspx.cs" Inherits="Payroll_TransactionSequence" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnTransactionExcelExport") >= 0 ||
                    args.get_eventTarget().indexOf("LinkTransactionExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnTransactionCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkTransactionCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnTransactionPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkTransactionPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnTransactionPrint") >= 0 ||
                        args.get_eventTarget().indexOf("LinkbtnTransactionPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnTransactionRefresh") >= 0 ||
                        args.get_eventTarget().indexOf("LinkTransactionRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }
            function ValidateTransaction(txtbxPrefix, txtNextNumber) {
                var str = '';
                if ($('#' + txtbxPrefix).val() == undefined || $('#' + txtbxPrefix).val() == "") {
                    str = 'Prefix Required.<br/>';
                }
                if ($('#' + txtNextNumber).val() == undefined || $('#' + txtNextNumber).val() == "") {
                    str += 'Next Number Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <div class="widget">

        <fieldset>
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <telerik:RadGrid ID="gvTransaction" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvTransaction_InsertCommand"
                            OnNeedDataSource="gvTransaction_NeedDataSource" PageSize="20" OnDeleteCommand="gvTransaction_DeleteCommand"
                            OnUpdateCommand="gvTransaction_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvTransaction_ItemDataBound"
                            OnItemCommand="gvTransaction_ItemCommand" OnDetailTableDataBind="gvTransaction_DetailTableDataBind" 
                            OnItemCreated="gvTransaction_ItemCreated" >
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <ClientSettings>
                                <Selecting CellSelectionMode="None"></Selecting>
                            </ClientSettings>
                            <ExportSettings
                                HideStructureColumns="true"
                                ExportOnlyData="true"
                                IgnorePaging="true"
                                OpenInNewWindow="true">
                                <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                                <Pdf PaperSize="A4">
                                </Pdf>
                            </ExportSettings>
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-ShowExportToCsvButton="true" CommandItemSettings-ShowExportToExcelButton="true" CommandItemSettings-ShowExportToPdfButton="true" CommandItemSettings-ShowExportToWordButton="true" AutoGenerateColumns="False" DataKeyNames="seqidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Transaction Sequence</h6>
                                    </div>
                                    <tr class="rgCommandRow">

                                        <td colspan="8" class="rgCommandCell">

                                            <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                <caption>

                                                    <span style="display: none">Command item</span>
                                                </caption>
                                                <thead>
                                                    <tr>
                                                        <th scope="col"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>

                                                        <td align="left">

                                                            </td>

                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnTransactionExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlterseqeText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnTransactionCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlterseqeText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnTransactionPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlterseqeText="Pdf" ToolTip="Pdf" />

                                                           <telerik:RadComboBox ID="ddlPrintOptions" style="margin:0px 5px" runat="server" Width="250px" DropDownWidth="250px">
                        </telerik:RadComboBox><asp:Button runat="server" ID="btnTransactionPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlterseqeText="Print" ToolTip="Print" />
                                                            <asp:Button ID="btnTransactionRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlterseqeText="Refresh" ToolTip="Refresh" />
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </CommandItemTemplate>
                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                </ExpandCollapseColumn>

                                <Columns>
                                    <telerik:GridBoundColumn DataField="seqidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="seqidd" ReadOnly="True" DataType="System.Int32">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="seqcod" ReadOnly="True" FilterControlWidth="130px" SortExpression="seqcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="seqcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblseqcod" runat="server" Text='<%# Eval("seqcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtseqcod" Style="float: left" runat="server" MaxLength="15" Text='<%# Eval("seqcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtseqcod"></asp:RequiredFieldValidator></td>

                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="seqdsc" ReadOnly="True" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="seqdsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="seqdsc">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("seqdsc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtseqdsc" runat="server" Text='<%# Eval("seqdsc") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator61111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtseqdsc"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="seqpre" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="seqpre" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Prefix" UniqueName="seqpre">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrevious" runat="server" Text='<%# Eval("seqpre") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtseqpre" runat="server" MaxLength="10" Text='<%# Eval("seqpre") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator61112" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtseqpre"></asp:RequiredFieldValidator>
                                              </td>  </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="seqnxt" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="seqnxt" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Next Number" UniqueName="seqnxt">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNextNumber" runat="server" Text='<%# Eval("seqnxt") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 300px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtseqnxt" runat="server"  MaxLength="50" Text='<%# Eval("seqnxt") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator61113" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtseqnxt"></asp:RequiredFieldValidator>
                                              </td>  
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditTransaction"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                   <%-- <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Transaction?"
                                        ConfirmTextFields="seqidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteTransaction" ConfirmTextFormatString='Are you sure to delete Transaction record "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Transaction "{0}":' CaptionDataField="seqidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>

                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>
