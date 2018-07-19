<%@ Page Title="Expense Master" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="ExpenseMaster.aspx.cs" Inherits="ExpenseMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   
     <style>
         .displayBlock
         {
         }

         .RadComboBox .rcbInputCellLeft
         {
            width : 118px !important;   
            overflow:hidden; 
        }

             .RadComboBox .rcbInputCellLeft inputs
             {
            width : 140px !important;
            }

         .RadComboBoxDropDown
         {
    min-width:150px !important;
}

         .rgEditForm > table tr
         {
             height: 0px!important;
         }
    </style>
     <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnOvertimeExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimeExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimePrint") >= 0 ||
                       args.get_eventTarget().indexOf("LinkbtnOvertimePrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeRefresh") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimeRefresh") >= 0 ||


                       args.get_eventTarget().indexOf("btnOvertimeDetailExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailPdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailPrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }
            function onFromValueChange(sender, args) {
                var fval = parseFloat($("#txtfromval").val());
                var tval = parseFloat($("#txttoval").val());
                var str = '';
                if (fval != '' && fval != null && tval != '' && tval != null) {
                    if (tval < fval) {
                        $("#txtfromval").val('');
                        str += "From Value can't be greater than To Value";
                    }
                }
                if (str != '')
                    showInfo(str, null, 10000);
            }

            function onToValueChange(sender, args) {
                var fval = parseFloat($("#txtfromval").val());
                var tval = parseFloat($("#txttoval").val());
                var str = '';
                if (fval != '' && fval != null && tval != '' && tval != null) {
                    if (tval < fval) {
                        $("#txttoval").val('');
                        str += "To Value can't be less than From Value";
                    }
                }
                if (str != '')
                    showInfo(str, null, 10000);
            }

            function ValidateExpenseType(txtexptcodId, txtexpttitleId, cbSpecValId, ddlMeasurmentTypeId, txtUnitTypeId, txtUnitValueId, txtfromvalId, txttovalId) {
                var str = '';
                if ($('#' + txtexptcodId).val() == undefined || $('#' + txtexptcodId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtexpttitleId).val() == undefined || $('#' + txtexpttitleId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlMeasurmentTypeId).val() == undefined || $('#' + ddlMeasurmentTypeId).val() == "") {
                    str += 'Measurement Type Required.<br/>';
                }
                if (($('#' + txtUnitTypeId).val() == undefined || $('#' + txtUnitTypeId).val() == "") && $('#' + txtUnitTypeId).is(':visible')) {
                    str += 'Unit Required.<br/>';
                }
                if (($('#' + txtUnitValueId).val() == undefined || $('#' + txtUnitValueId).val() == "") && $('#' + txtUnitValueId).is(':visible')) {
                    str += 'Unit Rate Required.<br/>';
                }
                if ($('#' + cbSpecValId).is(":checked")) {

                    if ($('#' + txtfromvalId).val() == undefined || $('#' + txtfromvalId).val() == "") {
                        str += 'From value Required.<br/>';
                    }
                    if ($('#' + txttovalId).val() == undefined || $('#' + txttovalId).val() == "") {
                        str += 'To value Required.<br/>';
                    }
                }
                
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpenseTypeDetail(txtexpsubtcodId,txtexpsubttitleId, cbSpecValId,ddlMeasurmentTypeId,txtUnitTypeId,txtUnitValueId, txtfromvalId, txttovalId) {
                var str = '';
                if ($('#' + txtexpsubtcodId).val() == undefined || $('#' + txtexpsubtcodId).val() == "") {
                    str += 'SubType code Required.<br/>';
                }
                if ($('#' + txtexpsubttitleId).val() == undefined || $('#' + txtexpsubttitleId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlMeasurmentTypeId).val() == undefined || $('#' + ddlMeasurmentTypeId).val() == "") {
                    str += 'Measurement Type Required.<br/>';
                }
                if (($('#' + txtUnitTypeId).val() == undefined || $('#' + txtUnitTypeId).val() == "") && $('#' + txtUnitTypeId).is(':visible')) {
                    str += 'Unit Required.<br/>';
                }
                if (($('#' + txtUnitValueId).val() == undefined || $('#' + txtUnitValueId).val() == "") && $('#' + txtUnitValueId).is(':visible')) {
                    str += 'Unit Rate Required.<br/>';
                }
                if ($('#' + cbSpecValId).is(":checked")) {

                    if ($('#' + txtfromvalId).val() == undefined || $('#' + txtfromvalId).val() == "") {
                        str += 'From value Required.<br/>';
                    }
                    if ($('#' + txttovalId).val() == undefined || $('#' + txttovalId).val() == "") {
                        str += 'To value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function OnMeasurmentTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdMeasurmentType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden').click();
                }, 50);
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
                        <telerik:RadGrid ID="gvExpense" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvExpense_InsertCommand"
                            OnNeedDataSource="gvExpense_NeedDataSource" PageSize="20" OnDeleteCommand="gvExpense_DeleteCommand"
                            OnUpdateCommand="gvExpense_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvExpense_ItemDataBound"
                            OnItemCommand="gvExpense_ItemCommand" OnDetailTableDataBind="gvExpense_DetailTableDataBind"
                            OnItemCreated="gvExpense_ItemCreated" >
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="exptidd" 
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="ExpenseTypeDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="expsubtidd"  AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense Type Detail</h6>
                                            </div>
                                            <tr class="rgCommandRow">

                                                <td colspan="9" class="rgCommandCell">

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
                                                                    <asp:Button ID="btnOvertimeDetailAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnOvertimeDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnOvertimeDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnOvertimeDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnOvertimeDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnOvertimeDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </CommandItemTemplate>
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                            <HeaderStyle Width="20px" />
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                            <HeaderStyle Width="20px" />
                                        </ExpandCollapseColumn>
                                        <DetailTables>
                                        </DetailTables>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="expsubtidd" FilterControlAltText="Filter expsubtidd column" AllowFiltering="false"
                                                HeaderText="ID" UniqueName="expsubtidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="expsubtcod" FilterControlWidth="130px" SortExpression="expsubtcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubtcod column"
                                                HeaderText="SubType Code" UniqueName="expsubtcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblexpsubtcod" runat="server" Text='<%# Eval("expsubtcod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridTemplateColumn DataField="expsubttitle" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="expsubttitle" CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubttitle column"
                                                HeaderText="Description" UniqueName="expsubttitle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsubDescription" runat="server" Text='<%# Eval("expsubttitle") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="measurmenttcod" visible="true" FilterControlWidth="130px" SortExpression="measurmenttcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter measurmenttcod column"
                                                HeaderText="Measurement Type" UniqueName="measurmenttcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmeasurmenttcod" runat="server" Text='<%# Eval("measurmenttcod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="specval" visible="false" FilterControlWidth="130px" SortExpression="specval" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter specval column"
                                                HeaderText="Specific Value" UniqueName="specval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblspecval" runat="server" Text='<%# Eval("specval") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="unittype" FilterControlWidth="130px" SortExpression="unittype" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter unittype column"
                                                HeaderText="Unit" UniqueName="unittype">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitType" runat="server" Text='<%# Eval("unittype") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="unitval" FilterControlWidth="130px" SortExpression="unitval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter unitval column"
                                                HeaderText="Unit Rate" UniqueName="unitval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitValue" runat="server" Text='<%# Eval("unitval") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="fromval" FilterControlWidth="130px" SortExpression="fromval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter fromval column"
                                                HeaderText="From Value" UniqueName="fromval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblfromval" runat="server" Text='<%# Eval("fromval") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="toval" FilterControlWidth="130px" SortExpression="toval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter toval column"
                                                HeaderText="To Value" UniqueName="toval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbltoval" runat="server" Text='<%# Eval("toval") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EdiExpenseTypeDetail">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expense type detail record?"
                                                ConfirmTextFields="expsubtidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteExpenseTypeDetail" ConfirmTextFormatString='Are you sure to delete Expense type detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="expsubtidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings EditFormType="Template">
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                            <FormTemplate>
                                                <table style="empty-cells: hide;">
                                                    <tr style="padding-bottom:5px">
                                                        <td>
                                                            <asp:Label ID="lblexpsubtcod" runat="server" Text="SubType Code:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px; padding-left: 0px">
                                                                <telerik:RadTextBox ID="txtexpsubtcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("expsubtcod") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="border-bottom: 0px;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorexpsubtcod" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtexpsubtcod"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td>
                                                            <asp:Label ID="lblexpsubttitle" runat="server" Text="Description:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px; padding-left: 0px">
                                                                <telerik:RadTextBox ID="txtexpsubttitle" MaxLength="200" runat="server" Text='<%# Eval("expsubttitle") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorexpsubttitle" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtexpsubttitle"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblMeasurmentType" runat="server" Text="Measurement Type:"></asp:Label>
                                                        </td>

                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <span class="combo180" style="float: left;">
                                                                <asp:Button ID="btnHidden" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                <telerik:RadComboBox ID="ddlMeasurmentType" runat="server"
                                                                    Width="180px" DropDownWidth="180px" OnSelectedIndexChanged="ddlMeasurmentType_SelectedIndexChanged"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdMeasurmentType4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdMeasurmentType4DDL_NeedDataSource"
                                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <GroupingSettings CaseSensitive="false" />
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="ValueSetID,Value,Text" ClientDataKeyNames="ValueSetID,Value,Text">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                        <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="Id" UniqueName="ValueSetID" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="Value" FilterControlWidth="50px" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Value" UniqueName="Value" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="Text" FilterControlWidth="50px" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Code" UniqueName="Text" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>

                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowClick="OnMeasurmentTypeRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>

                                                                        </div>
                                                </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>
                                                        </td>
                                                        <td style="padding-bottom: 8px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValddlMeasurmentType" Style="float: left" runat="server" ErrorMessage="*"
                                                                ForeColor="Red" Display="Dynamic" ControlToValidate="ddlMeasurmentType">
                                                            </asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblUnitType" runat="server" Text="Unit:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadTextBox runat="server" ID="txtUnitType" MaxLength="50" Text='<%# Eval("unittype") %>'></telerik:RadTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxtUnitType" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtUnitType"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblUnitValue" runat="server" Text="Unit Rate:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtUnitValue" ClientEvents-OnValueChanged="onFromValueChange" Width="75" MaxLength="8" ClientIDMode="Static"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("unitval") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxtUnitValue" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtUnitValue"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>

                                                        <tr>
                                                        <td>
                                                            <asp:Label ID="lblSpecVal" runat="server" Text="Range Limit:"></asp:Label>
                                                        </td>
                                                        <td style="width: 150px; padding-bottom: 8px;">
                                                                <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="cbSpecVal_CheckedChanged"  ID="cbSpecVal" Text="" Checked='<%# CheckBoxValue( Eval("specval")) %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td>
                                                            <asp:Label ID="lblfromval" runat="server" Text="From Value:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                                <telerik:RadNumericTextBox runat="server" ID="txtfromval" ClientEvents-OnValueChanged="onFromValueChange" Width="75" MaxLength="8" ClientIDMode="Static"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("fromval") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td style="border-bottom:0px">
                                                                <asp:RequiredFieldValidator ID="RFVtxtfromval" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtfromval"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td>
                                                            <asp:Label ID="lbltoval" runat="server" Text="To Value:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                                <telerik:RadNumericTextBox runat="server" ClientEvents-OnValueChanged="onToValueChange" ID="txttoval" ClientIDMode="Static"
                                                                    Width="75" MaxLength="8" AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("toval") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td style="border-bottom:0px">
                                                                <asp:RequiredFieldValidator ID="RFVtxttoval" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttoval"></asp:RequiredFieldValidator>
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="PerformInsertButton" ImageUrl="~/Images/check.gif" AlternateText='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />&nbsp;
                                                            <asp:ImageButton ID="btnCancel"  ImageUrl="~/Images/cancel.gif" AlternateText="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:ImageButton>
                                                        </td>
                                                        </tr>
                                                    </table>
                                            </FormTemplate>

                                            
                                        </EditFormSettings>

                                    </telerik:GridTableView>

                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense Type Setup</h6>
                                    </div>
                                    <tr class="rgCommandRow">

                                        <td colspan="10" class="rgCommandCell">

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
                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlterovteText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnOvertimeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlterovteText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnOvertimeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlterovteText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnOvertimePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlterovteText="Pdf" ToolTip="Pdf" />

                                                            <span>
                                                                <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                            </span>
                                                            <asp:Button runat="server" ID="btnOvertimePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlterovteText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnOvertimeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlterovteText="Refresh" ToolTip="Refresh" />
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
                                    <telerik:GridBoundColumn DataField="exptidd" SortExpression="exptidd" FilterControlAltText="Filter exptidd column"
                                        HeaderText="ID" UniqueName="exptidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="exptcod" FilterControlWidth="130px" SortExpression="exptcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter exptcod column"
                                        HeaderText="Code" UniqueName="exptcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblexptcod" runat="server" Text='<%# Eval("exptcod") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="expttitle" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="expttitle" CurrentFilterFunction="Contains" FilterControlAltText="Filter expttitle column"
                                        HeaderText="Description" UniqueName="expttitle">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("expttitle") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="measurmenttcod" Visible="true" FilterControlWidth="130px" SortExpression="measurmenttcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter measurmenttcod column"
                                        HeaderText="Measurement Type" UniqueName="measurmenttcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblmeasurmenttcod" runat="server" Text='<%# Eval("measurmenttcod") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="specval" Visible="false" FilterControlWidth="130px" SortExpression="specval" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter specval column"
                                        HeaderText="Specific Value" UniqueName="specval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblspecval" runat="server" Text='<%# Eval("specval") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="unittype" FilterControlWidth="130px" SortExpression="unittype" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter unittype column"
                                        HeaderText="Unit" UniqueName="unittype">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUnitType" runat="server" Text='<%# Eval("unittype") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="unitval" FilterControlWidth="130px" SortExpression="unitval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter unitval column"
                                        HeaderText="Unit Rate" UniqueName="unitval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUnitValue" runat="server" Text='<%# Eval("unitval") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                                   
                                    <telerik:GridTemplateColumn DataField="fromval" FilterControlWidth="130px" SortExpression="fromval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter fromval column"
                                        HeaderText="From Value" UniqueName="fromval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblfromval" runat="server" Text='<%# Eval("fromval") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="toval" FilterControlWidth="130px" SortExpression="toval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter toval column"
                                        HeaderText="To Value" UniqueName="toval">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltoval" runat="server" Text='<%# Eval("toval") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditExpenseType"
                                        ButtonType="ImageButton" ItemStyle-Width="56px"  EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expense Type record?"
                                        ConfirmTextFields="exptidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="0px" UniqueName="DeleteExpenseType" ConfirmTextFormatString='Are you sure to delete Expense Type record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings EditFormType="Template" CaptionFormatString='Edit Expense Type record # "{0}":' CaptionDataField="exptidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                    <FormTemplate>
                                                <table style="empty-cells: hide;">
                                                    <tr style="padding-bottom: 5px">
                                                        <td>
                                                            <asp:Label ID="lblexptcod" runat="server" Text="Code:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtexptcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("exptcod") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorexptcod" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtexptcod"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblexpttitle" runat="server" Text="Description:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtexpttitle" MaxLength="200" runat="server" Text='<%# Eval("expttitle") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorexpttitle" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtexpttitle"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblMeasurmentType" runat="server" Text="Measurement Type:"></asp:Label>
                                                        </td>

                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <span class="combo180" style="float: left;">
                                                                <asp:Button ID="btnHidden" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                <telerik:RadComboBox ID="ddlMeasurmentType" runat="server"
                                                                    Width="180px" DropDownWidth="180px" OnSelectedIndexChanged="ddlMeasurmentType_SelectedIndexChanged"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdMeasurmentType4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdMeasurmentType4DDL_NeedDataSource"
                                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <GroupingSettings CaseSensitive="false" />
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="ValueSetID,Value,Text" ClientDataKeyNames="ValueSetID,Value,Text">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                        <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="Id" UniqueName="ValueSetID" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="Value" FilterControlWidth="50px" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Value" UniqueName="Value" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="Text" FilterControlWidth="50px" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Code" UniqueName="Text" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>

                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowClick="OnMeasurmentTypeRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>

                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>
                                                        </td>
                                                        <td style="padding-bottom: 8px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValddlMeasurmentType" Style="float: left" runat="server" ErrorMessage="*"
                                                                ForeColor="Red" Display="Dynamic" ControlToValidate="ddlMeasurmentType">
                                                            </asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblUnitType" runat="server" Text="Unit:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadTextBox runat="server" ID="txtUnitType" MaxLength="50" Text='<%# Eval("unittype") %>'></telerik:RadTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxtUnitType" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtUnitType"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblUnitValue" runat="server" Text="Unit Rate:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtUnitValue" ClientEvents-OnValueChanged="onFromValueChange" Width="75" MaxLength="8" ClientIDMode="Static"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("unitval") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxtUnitValue" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtUnitValue"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSpecVal" runat="server" Text="Range Limit:"></asp:Label>
                                                        </td>
                                                        <td style="width: 150px; padding-bottom: 8px;">
                                                            <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="cbSpecVal_CheckedChanged" ID="cbSpecVal" Text="" Checked='<%# CheckBoxValue( Eval("specval")) %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblfromval" runat="server" Text="From Value:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadNumericTextBox runat="server" ID="txtfromval" ClientEvents-OnValueChanged="onFromValueChange" Width="75" MaxLength="8" ClientIDMode="Static"
                                                                AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("fromval") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxtfromval" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txtfromval"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbltoval" runat="server" Text="To Value:"></asp:Label>
                                                        </td>
                                                        <td style="width: 180px; padding-bottom: 8px;">
                                                            <telerik:RadNumericTextBox runat="server" ClientEvents-OnValueChanged="onToValueChange" ID="txttoval" ClientIDMode="Static"
                                                                Width="75" MaxLength="8" AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("toval") %>'
                                                                EnableSingleInputRendering="True">
                                                                <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                    KeepTrailingZerosOnFocus="True" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px">
                                                            <asp:RequiredFieldValidator ID="RFVtxttoval" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="txttoval"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="PerformInsertButton" ImageUrl="~/Images/check.gif" AlternateText='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />&nbsp;
                                                            <asp:ImageButton ID="btnCancel"  ImageUrl="~/Images/cancel.gif" AlternateText="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:ImageButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </FormTemplate>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20" IsSticky="true">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>




