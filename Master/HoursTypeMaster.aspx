<%@ Page Title="Hour Type Master" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="HoursTypeMaster.aspx.cs" Inherits="HoursTypeMaster" %>

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
            
            function ValidateHoursType(txthourtypecodeId, txthourtypedescriptionId, txthourtypedescription2Id, cbSpecValId, txtfromvalId, txttovalId, txtdefvalId) {
                var str = '';
                var dval, tval, fval;
                if ($('#' + txthourtypecodeId).val() == undefined || $('#' + txthourtypecodeId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txthourtypedescriptionId).val() == undefined || $('#' + txthourtypedescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                //if ($('#' + txthourtypedescription2Id).val() == undefined || $('#' + txthourtypedescription2Id).val() == "") {
                //    str += 'Description2 Required.<br/>';
                //}

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
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <telerik:RadGrid ID="gvHourType" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvHourType_InsertCommand"
                            OnNeedDataSource="gvHourType_NeedDataSource" PageSize="20" OnDeleteCommand="gvHourType_DeleteCommand"
                            OnUpdateCommand="gvHourType_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvHourType_ItemDataBound"
                            OnItemCommand="gvHourType_ItemCommand" 
                            OnItemCreated="gvHourType_ItemCreated" >
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
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Hours Type Setup</h6>
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
                                    <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter recidd column"
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="hourtypecode" FilterControlWidth="130px" SortExpression="hourtypecode" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter hourtypecode column"
                                        HeaderText="Code" UniqueName="hourtypecode">
                                        <ItemTemplate>
                                            <asp:Label ID="lblhourtypecode" runat="server" Text='<%# Eval("hourtypecode") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txthourtypecode" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("hourtypecode") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorhourtypecode" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txthourtypecode"></asp:RequiredFieldValidator>
                                                    </td>                                                  
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="hourtypedescription" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="hourtypedescription" CurrentFilterFunction="Contains" FilterControlAltText="Filter hourtypedescription column"
                                        HeaderText="Description" UniqueName="hourtypedescription">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("hourtypedescription") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txthourtypedescription" MaxLength="200" runat="server" Text='<%# Eval("hourtypedescription") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorhourtypedescription" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txthourtypedescription"></asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridTemplateColumn DataField="hourtypedescription2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="hourtypedescription2" CurrentFilterFunction="Contains" FilterControlAltText="Filter hourtypedescription2 column"
                                        HeaderText="Description2" UniqueName="hourtypedescription2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("hourtypedescription2") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txthourtypedescription2" MaxLength="200" runat="server" Text='<%# Eval("hourtypedescription2") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom:0px">
                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorhourtypedescription2" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txthourtypedescription2"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                   
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
                                                                <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="cbSpecVal_CheckedChanged"  ID="cbSpecVal" Text="" Checked='<%# Eval("specval") %>' />
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
                                    
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditHourType"
                                        ButtonType="ImageButton" ItemStyle-Width="56px"  EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Hour Type record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="0px" UniqueName="DeleteHourType" ConfirmTextFormatString='Are you sure to delete Hour Type record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Hour Type record # "{0}":' CaptionDataField="recidd">
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




