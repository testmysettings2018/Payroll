<%@ Page Title="Premium Master" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="PremiumMaster.aspx.cs" Inherits="PremiumMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   
     <style>
         .displayBlock {
         }
        .RadComboBox .rcbInputCellLeft {
            width : 118px !important;   
            overflow:hidden; 
        }
         .RadComboBox .rcbInputCellLeft inputs {
            width : 140px !important;
            }
          .RadComboBoxDropDown{
    min-width:150px !important;
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
           
            function OnUnitOFPaymentRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdUnitOFPayment4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function ValidatePremType(txtpremtypeId, txtpremtypedescId, ddlUnitOFPaymentId) {
                var str = '';
                if ($('#' + txtpremtypeId).val() == undefined || $('#' + txtpremtypeId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtpremtypedescId).val() == undefined || $('#' + txtpremtypedescId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlUnitOFPaymentId).val() == undefined || $('#' + ddlUnitOFPaymentId).val() == "") {
                    str += 'Unit of Payment Required.<br/>';
                }
                
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function OnDayTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("daycod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDayType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function ValidatePremTypeDetail(ddlDayTypeId, cbSpecValId, txtfromvalId, txttovalId, txtdefvalId) {
                var str = '';
                var dval,tval,fval;
                if ($('#' + ddlDayTypeId).val() == undefined || $('#' + ddlDayTypeId).val() == "") {
                    str += 'Day Type Required.<br/>';
                }
                if ($('#' + cbSpecValId).is(":checked")) {
                    if ($('#' + txtdefvalId).val() != undefined || $('#' + txtdefvalId).val() != "") {
                        dval = parseFloat($("#txtdefval").val());
                    }

                    if ($('#' + txtfromvalId).val() == undefined || $('#' + txtfromvalId).val() == "") {
                        str += 'From value Required.<br/>';
                    }
                    else {
                        fval = parseFloat($("#txtfromval").val());
                        if (dval != null && dval != "" && fval != null && fval != "") {
                            if (dval < fval) {
                                str += 'Default value can not be less than From value.<br/>';
                            }
                        }
                    }
                    if ($('#' + txttovalId).val() == undefined || $('#' + txttovalId).val() == "") {
                        str += 'To value Required.<br/>';
                    }
                    else {
                        tval = parseFloat($("#txttoval").val());
                        if (dval != null && dval != "" && tval != null && tval != "") {
                            if (dval > tval) {
                                str += 'Default value can not be greater than To value.<br/>';
                            }
                        }
                    }

                }
                if (str != '') {
                    showError(str, null, 10000);
                    return false;
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
            <div class="widget" >
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <telerik:RadGrid ID="gvPremium" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvPremium_InsertCommand"
                            OnNeedDataSource="gvPremium_NeedDataSource" PageSize="20" OnDeleteCommand="gvPremium_DeleteCommand"
                            OnUpdateCommand="gvPremium_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvPremium_ItemDataBound"
                            OnItemCommand="gvPremium_ItemCommand" OnDetailTableDataBind="gvPremium_DetailTableDataBind"
                            OnItemCreated="gvPremium_ItemCreated" >
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="recidd" 
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="PremTypeDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="recidd"  AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Premium Type Detail</h6>
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
                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" AllowFiltering="false"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="daytcod" FilterControlWidth="130px" SortExpression="daytcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter daytcod column"
                                                HeaderText="Day Type" UniqueName="daytcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldaycod" runat="server" Text='<%# Eval("daytcod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="border-bottom:0px">
                                                                <span class="combo180" style="float: left;">
                                                                    <telerik:RadComboBox ID="ddlDayType" runat="server"
                                                                        Width="180px" DropDownWidth="180px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                                <div style="overflow: auto; max-height: 200px;">
                                                                                <telerik:RadGrid ID="rGrdDayType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDayType4DDL_NeedDataSource"
                                                                                    Width="200px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                    </ClientSettings>

                                                                                    <MasterTableView DataKeyNames="recidd,daycod,dayds1" ClientDataKeyNames="recidd,daycod,dayds1">
                                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </RowIndicatorColumn>
                                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </ExpandCollapseColumn>
                                                                                        <Columns>

                                                                                            <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="recidd">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="daycod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="daycod">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="dayds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="dayds1">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnDayTypeRowClicked"></ClientEvents>
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
                                                            <td style="border-bottom:0px"><asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlDayType"></asp:RequiredFieldValidator></td>
                                                           
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="specval" visible="false" FilterControlWidth="130px" SortExpression="specval" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter specval column"
                                                HeaderText="Specific Value" UniqueName="specval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldayprt" runat="server" Text='<%# Eval("specval") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 150px; border-bottom: 0px">
                                                                <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="cbSpecVal_CheckedChanged"  ID="cbSpecVal" Text="" Checked='<%#  Eval("specval") %>' />
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="fromval" FilterControlWidth="130px" SortExpression="fromval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter fromval column"
                                                HeaderText="From Value" UniqueName="fromval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblfromval" runat="server" Text='<%# Eval("fromval") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtfromval"  ClientEvents-OnValueChanged="onFromValueChange"  Width="75" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("fromval") %>' ClientIDMode="Static"
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
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="toval" FilterControlWidth="130px" SortExpression="toval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter toval column"
                                                HeaderText="To Value" UniqueName="toval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbltoval" runat="server" Text='<%# Eval("toval") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txttoval" Width="75" MaxLength="8"  ClientEvents-OnValueChanged="onToValueChange"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("toval") %>' ClientIDMode="Static"
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
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="defval" FilterControlWidth="130px" SortExpression="defval" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter defval column"
                                                HeaderText="Default Value" UniqueName="defval">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldefval" runat="server" Text='<%# Eval("defval") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtdefval" Width="75" MaxLength="8" 
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("defval") %>' ClientIDMode="Static"
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td style="border-bottom:0px">
                                                                <%--<asp:RequiredFieldValidator ID="RFVtxtdefval" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtdefval"></asp:RequiredFieldValidator>--%>
                                                            </td>
                                                         
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditPremTypeDetail">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Premium type detail record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeletePremTypeDetail" ConfirmTextFormatString='Are you sure to delete Premium type detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>

                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>

                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Premium Type Setup</h6>
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
                                    <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="premtype" FilterControlWidth="130px" SortExpression="premtype" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter premtype column"
                                        HeaderText="Code" UniqueName="premtype">
                                        <ItemTemplate>
                                            <asp:Label ID="lblovtcod" runat="server" Text='<%# Eval("premtype") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtpremtype" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("premtype") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPremtype" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtpremtype"></asp:RequiredFieldValidator>
                                                    </td>                                                  
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="premtypedescription" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="premtypedescription" CurrentFilterFunction="Contains" FilterControlAltText="Filter premtypedescription column"
                                        HeaderText="Description" UniqueName="premtypedescription">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("premtypedescription") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtpremtypedesc" MaxLength="200" runat="server" Text='<%# Eval("premtypedescription") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPremtypedes" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtpremtypedesc"></asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn DataField="uopcod" SortExpression="uopcod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter uopcod column"
                                        HeaderText="Unit of Payment" UniqueName="uopcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lbluopcod" runat="server" Text='<%# Eval("uopcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 200px; border-bottom: 0px">
                                                        <span class="combo180" style="float: left;">
                                                            <telerik:RadComboBox ID="ddlUnitOFPayment" runat="server"
                                                                Width="180px" DropDownWidth="180px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdUnitOFPayment4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdUnitOFPayment4DDL_NeedDataSource"
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
                                                                                <ClientEvents OnRowClick="OnUnitOFPaymentRowClicked"></ClientEvents>
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
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValddlUnitOFPayment" Style="float: left" runat="server" ErrorMessage="*" 
                                                            ForeColor="Red" Display="Dynamic" ControlToValidate="ddlUnitOFPayment">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditPremiumType"
                                        ButtonType="ImageButton" ItemStyle-Width="56px"  EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center"  />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Premium Type record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="0px" UniqueName="DeletePremiumType" ConfirmTextFormatString='Are you sure to delete Premium Type record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Overtime record # "{0}":' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
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




