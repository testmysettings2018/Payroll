<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="EmployeeSetup.aspx.cs" Inherits="Payroll_EmployeeSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }

            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnEmployeeExcelExport") >= 0 ||
                   args.get_eventTarget().indexOf("LinkEmployeeExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeePrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeeRefresh") >= 0 ||
                    args.get_eventTarget().indexOf("ddlPrintOptions") >= 0 ||
                                       args.get_eventTarget().indexOf("btnEmployeeDetailAdd") >= 0 ||
                                           args.get_eventTarget().indexOf("btnEmployeeDetailExcelExport") >= 0 ||
                                           args.get_eventTarget().indexOf("btnEmployeeDetailCsvExport") >= 0 ||
                                          args.get_eventTarget().indexOf("btnEmployeeDetailPdfExport") >= 0 ||
                                           args.get_eventTarget().indexOf("btnEmployeeDetailPrint") >= 0 ||
                     args.get_eventTarget().indexOf("btnEmployeeDetailRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }

            function OnNatCodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("natcod");
                var id = args.getDataKeyValue("natidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdNatCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnReligionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("relcod");
                var id = args.getDataKeyValue("relidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdReligion4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEmployeeClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("clscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployeeClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEmployeeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnPositionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("poscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPosition4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCityRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ctrcty");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCity4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnBloodGroupRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdBloodGroup4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnMaritalStatusRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdMaritalStatus4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnVisaProfessionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdVisaProfession4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGenderRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGender4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGradeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grdcode");
                var id = args.getDataKeyValue("grdidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGrade4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnSectionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("seccod");
                var id = args.getDataKeyValue("secidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdSection4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnDepartmentRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("dptcod");
                var id = args.getDataKeyValue("dptidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDepartment4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                    $('#btnHidden').click();
                }, 50);
            }

            function OnDivisionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("divcod");
                var id = args.getDataKeyValue("dividd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDivision4DDL', ''));
                var btn = $("#" + combo._element.id.replace('ddlDivision', 'btn'));

                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                    //btn[0].click();
                    //wait
                    $('#btnHidden').click();
                }, 50);
            }
            function OnLocationRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLocation4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnSupervisorRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("supcod");
                var id = args.getDataKeyValue("supidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdSupervisor4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnEmployeementTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployeementType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnAddressRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdAddress4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnToBankRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("brncod");
                var id = args.getDataKeyValue("brnidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdToBank4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnOfficeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("brncod");
                var id = args.getDataKeyValue("brnidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdOffice4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnFromBankRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("brncod");
                var id = args.getDataKeyValue("brnidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdFromBank4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnVisaTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdVisaType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCountryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ctrcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCountry4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                    $('#btnHidden').click();
                }, 50);
            }
            function OnStatusRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdStatus4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }


            function ValidateEmployee(txtempcodId, txtfirstnameId, txtlastnameId, txtempprnId, ddlNationalityId, dtpbirthdateId, ddlGenderId, ddlMaritalStatusId,
                ddlGradeId, ddlDepartmentId, ddlPositionId, ddlStatusId, ddlEmployeementTypeId) {
                var str = '';
                if ($('#' + txtempcodId).val() == undefined || $('#' + txtempcodId).val() == "") {
                    str = 'Employee Code Required.<br/>';
                }
                if ($('#' + txtfirstnameId).val() == undefined || $('#' + txtfirstnameId).val() == "") {
                    str += 'First Name Required.<br/>';
                }
                if ($('#' + txtlastnameId).val() == undefined || $('#' + txtlastnameId).val() == "") {
                    str += 'Last Name Required.<br/>';
                }
                if ($('#' + txtempprnId).val() == undefined || $('#' + txtempprnId).val() == "") {
                    str += 'Printing Name Required.<br/>';
                }
                if ($('#' + ddlNationalityId).val() == undefined || $('#' + ddlNationalityId).val() == "") {
                    str += 'Nationality Required.<br/>';
                }
                if ($('#' + dtpbirthdateId).val() == undefined || $('#' + dtpbirthdateId).val() == "") {
                    str += 'Date of Birth Required.<br/>';
                }
                if ($('#' + ddlGenderId).val() == undefined || $('#' + ddlGenderId).val() == "") {
                    str += 'Gender Required.<br/>';
                }
                if ($('#' + ddlMaritalStatusId).val() == undefined || $('#' + ddlMaritalStatusId).val() == "") {
                    str += 'Marital Status Required.<br/>';
                }
                if ($('#' + ddlGradeId).val() == undefined || $('#' + ddlGradeId).val() == "") {
                    str += 'Grade Required.<br/>';
                }
                if ($('#' + ddlDepartmentId).val() == undefined || $('#' + ddlDepartmentId).val() == "") {
                    str += 'Department Required.<br/>';
                }
                if ($('#' + ddlPositionId).val() == undefined || $('#' + ddlPositionId).val() == "") {
                    str += 'Position Required.<br/>';
                }
                if ($('#' + ddlStatusId).val() == undefined || $('#' + ddlStatusId).val() == "") {
                    str += 'Status Required.<br/>';
                }
                if ($('#' + ddlEmployeementTypeId).val() == undefined || $('#' + ddlEmployeementTypeId).val() == "") {
                    str += 'Employment Type Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateEmployeeDetail(txtmacfldId, txtmacflnId, txtBxmacmapId, txtBxmacdscId) {
                var str = '';
                if ($('#' + txtmacfldId).val() == undefined || $('#' + txtmacfldId).val() == "") {
                    str = 'File Field Seq # Required.<br/>';
                }
                if ($('#' + txtmacflnId).val() == undefined || $('#' + txtmacflnId).val() == "") {
                    str += 'Field Name Required.<br/>';
                }
                if ($('#' + txtBxmacmapId).val() == undefined || $('#' + txtBxmacmapId).val() == "") {
                    str += 'Mapped to Field Required.<br/>';
                }
                if ($('#' + txtBxmacdscId).val() == undefined || $('#' + txtBxmacdscId).val() == "") {
                    str += 'Description Required.<br/>';
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
                        <telerik:RadGrid ID="gvEmployee" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AllowAutomaticInserts="False" AllowAutomaticUpdates="False" AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvEmployee_InsertCommand"
                            OnNeedDataSource="gvEmployee_NeedDataSource" PageSize="20" OnDeleteCommand="gvEmployee_DeleteCommand"
                            OnUpdateCommand="gvEmployee_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvEmployee_ItemDataBound"
                            OnItemCommand="gvEmployee_ItemCommand" OnDetailTableDataBind="gvEmployee_DetailTableDataBind" 
                            OnItemCreated="gvEmployee_ItemCreated">
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
                                InsertItemPageIndexAction="ShowItemOnCurrentPage">
                                <DetailTables>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee Setup</h6>
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
                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlteratteText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnEmployeeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlteratteText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnEmployeeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlteratteText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnEmployeePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlteratteText="Pdf" ToolTip="Pdf" />

                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                            <asp:Button runat="server" ID="btnEmployeePrint"  CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlteratteText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnEmployeeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteratteText="Refresh" ToolTip="Refresh" />
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
                                        HeaderText="ID" UniqueName="EmployeeId" ReadOnly="True" DataType="System.Int32" visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Employee Code" UniqueName="TemplateColumn0">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempcod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="empfsn" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="First Name" UniqueName="TemplateColumn01">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempfsn" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="empmdn" Visible="false" FilterControlWidth="130px" SortExpression="empmdn" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Middle Name" UniqueName="TemplateColumn02">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempmdn" runat="server" Text='<%# Eval("empmdn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="emplsn" FilterControlWidth="130px" SortExpression="emplsn" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Last Name" UniqueName="TemplateColumn03">
                                        <ItemTemplate>
                                            <asp:Label ID="lblemplsn" runat="server" Text='<%# Eval("emplsn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditEmployee"
                                        ButtonType="ImageButton" ItemStyle-Width="40px" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="40px" UniqueName="DeleteEmployee" ConfirmTextFormatString='Are you sure to delete Employee record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings EditFormType="Template" CaptionFormatString='Edit Details for Employee record # "{0}":' CaptionDataField="recidd">
                                    <EditColumn UniqueName="EditCommandColumn1" />
                                    <FormTemplate>

                                        <telerik:RadTabStrip CausesValidation="false" ValidateRequestMode="Disabled" runat="server" ID="RadTabStrip1" Orientation="HorizontalTop"
                                            SelectedIndex="0" MultiPageID="RadMultiPage1" CssClass="tabstrip">
                                            <Tabs>
                                                <telerik:RadTab ValidateRequestMode="Disabled" Text="Personal">
                                                </telerik:RadTab>
                                                <telerik:RadTab ValidateRequestMode="Disabled" Text="Contract">
                                                </telerik:RadTab>
                                                <telerik:RadTab ValidateRequestMode="Disabled" Text="Address">
                                                </telerik:RadTab>
                                                <telerik:RadTab ValidateRequestMode="Disabled" Text="Payment">
                                                </telerik:RadTab>
                                            </Tabs>
                                        </telerik:RadTabStrip>
                                        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0"
                                            Width="950px" CssClass="multiPage">


                                            <telerik:RadPageView runat="server" ValidateRequestMode="Disabled" ID="RadPageView1">
                                                <table style="margin: 10px 10px 0px 10px">
                                                    <tr>
                                                        <td>
                                                            <div style="width: 468px; float: left">
                                                                <div style="width: 196px; float: left">
                                                                    <asp:Label ID="lblempcod" Style="padding-left: 13px; width: 250px" runat="server" Text='Employee Code'></asp:Label>
                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">
                                                                    <telerik:RadTextBox ID="txtempcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("empcod") %>'>
                                                                    </telerik:RadTextBox>
                                                                </div>

                                                                <div style="width: 196px; float: left">



                                                                    <asp:Label ID="lblfirstname" Style="padding-left: 13px; width: 250px" runat="server" Text='First Name'></asp:Label>

                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">

                                                                    <telerik:RadTextBox ID="txtfirstname" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empfsn") %>'>
                                                                    </telerik:RadTextBox>
                                                                </div>

                                                                <div style="width: 196px; float: left">
                                                                    <asp:Label ID="Label1" Style="padding-left: 13px; width: 250px" runat="server" Text='Middle Name'></asp:Label>
                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">
                                                                    <telerik:RadTextBox ID="txtmiddlename" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empmdn") %>'>
                                                                    </telerik:RadTextBox>
                                                                </div>


                                                                <div style="width: 196px; float: left">
                                                                    <asp:Label ID="Label8" Style="padding-left: 13px; width: 250px" runat="server" Text='Last Name'></asp:Label>
                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">

                                                                    <telerik:RadTextBox ID="txtlastname" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("emplsn") %>'>
                                                                    </telerik:RadTextBox>


                                                                </div>

                                                                <div style="width: 196px; float: left">

                                                                    <asp:Label ID="Label9" Style="padding-left: 13px; width: 250px" runat="server" Text='Printing Name'></asp:Label>
                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">
                                                                    <telerik:RadTextBox ID="txtempprn" MaxLength="200" Style="float: left" runat="server" Text='<%# Eval("empprn") %>'>
                                                                    </telerik:RadTextBox>
                                                                </div>
                                                                <div style="width: 196px; float: left">

                                                                    <asp:Label ID="Label10" Style="padding-left: 13px; width: 250px" runat="server" Text='Suffix'></asp:Label>
                                                                </div>
                                                                <div style="width: 270px; float: left; border-bottom: 0px; padding-left: 0px; margin-bottom: 5px;">

                                                                    <telerik:RadTextBox ID="txtempsfx" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empsfx") %>'>
                                                                    </telerik:RadTextBox>

                                                                </div>

                                                            </div>
                                                            <div style="float: right; width: 460px">
                                                                <div style="float: left; width: 200px">
                                                                    <div style="width: 200px; float: left; height: 36px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtempcod"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                    <div style="width: 200px; float: left; height: 70px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtfirstname"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                    <div style="width: 200px; float: left; height: 36px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtlastname"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                    <div style="width: 200px; float: left; height: 36px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator82" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtempprn"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>
                                                                <div style="width: 220px; float: right;">
                                                                    <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# Eval("empphto") == DBNull.Value? new System.Byte[0]: Eval("empphto") %>'
                                                                        AutoAdjustImageControlSize="false" Width="150px" Height="165px" />

                                                                </div>
                                                            </div>
                                                            <div style="width: 190px; float: left; margin-top: 0px">
                                                                <asp:Label ID="Label68" Style="padding-left: 13px; width: 250px" runat="server" Text='Photo'></asp:Label>


                                                            </div>
                                                            <div style="width: 266px; float: left; margin-top: 0px">

                                                                <telerik:RadAsyncUpload Width="250px" ID="RadAsyncUpImageUpload" MaxFileInputsCount="1" MultipleFileSelection="Disabled"
                                                                    runat="server" FileUploaded="RadAsyncUpImageUpload_FileUploaded" />
                                                            </div>


                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table style="margin: 0px 10px 10px 10px">





                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label11" Style="padding-left: 13px; width: 250px; margin-top: 5px;" runat="server" Text='First Name-Sec Lang'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempfss" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empfss") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px">

                                                            <asp:Label ID="Label12" Style="padding-left: 13px; width: 250px; margin-top: 5px;" runat="server" Text='Middle Name-Sec Lang'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px">
                                                            <telerik:RadTextBox ID="txtempmds" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empmds") %>'>
                                                            </telerik:RadTextBox></td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:Label ID="Label13" Style="padding-left: 13px; margin-top: 5px; width: 250px" runat="server" Text='Last Name-Sec Lang'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px; margin-top: 5px">
                                                            <telerik:RadTextBox ID="txtemplss" MaxLength="50" Style="float: left; margin-top: 5px;" runat="server" Text='<%# Eval("emplss") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px">

                                                            <asp:Label ID="Label14" Style="padding-left: 13px; width: 250px; margin-top: 5px;" runat="server" Text='Printing Name-Sec Lang'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px">
                                                            <telerik:RadTextBox ID="txtempprs" MaxLength="200" Style="float: left; margin-top: 5px;" runat="server" Text='<%# Eval("empprs") %>'>
                                                            </telerik:RadTextBox></td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px">
                                                            <asp:Label ID="Label15" Style="padding-left: 13px; width: 250px; margin-top: 5px;" runat="server" Text='Suffix  - Sec Lang'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempsfs" MaxLength="50" Style="float: left; margin-top: 5px;" runat="server" Text='<%# Eval("empsfs") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label16" Style="padding-left: 13px; margin-top: 5px; width: 250px" runat="server" Text='Religion'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px">
                                                            <asp:HiddenField ID="hfReligionId" runat="server" Value='<%# Eval("relidd") %>' />
                                                            <asp:HiddenField ID="hfReligionCode" runat="server" Value='<%# Eval("relcod") %>' />
                                                            <telerik:RadComboBox ID="ddlReligion" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px" Style="margin-top: 5px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelReligion" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelReligion" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdReligion4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdReligion4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="relidd,relcod,relds1" ClientDataKeyNames="relidd,relcod,relds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="relidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="relcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="relcod">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="relds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="relds1">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnReligionRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelReligion" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label18" Style="padding-left: 13px; width: 250px" runat="server" Text='Nationality'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfddlNationalityId" runat="server" Value='<%# Eval("natidd") %>' />
                                                            <asp:HiddenField ID="hfddlNationalityText" runat="server" Value='<%# Eval("natcod") %>' />
                                                            <telerik:RadComboBox ID="ddlNationality" runat="server" Style="margin-top: 5px"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelNatCode" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdNatCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdNatCode4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="natidd,natcod,natds1" ClientDataKeyNames="natidd,natcod,natds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="natidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="natcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="natds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnNatCodeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelNatCode" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator211" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlNationality"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="Label17" Style="padding-left: 13px; width: 250px" runat="server" Text='Date of Birth'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadDatePicker ID="dtpbirthdate" runat="server" DbSelectedDate='<%# Bind("empdob") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy" RangeMinDate="01/01/1900"></Calendar>
                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" MinDate="01/01/1900"></DateInput>
                                                            </telerik:RadDatePicker>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="dtpbirthdate"></asp:RequiredFieldValidator>

                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label19" Style="padding-left: 13px; width: 250px" runat="server" Text='Gender'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfGenderdllID" runat="server" Value='<%# Eval("empgnd") %>' />
                                                            <asp:HiddenField ID="hfGenderdllText" runat="server" Value='<%# Eval("empgndtext") %>' />
                                                            <telerik:RadComboBox ID="ddlGender" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelGender" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGender" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdGender4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGender4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnGenderRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGender" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator311" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlGender"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="Label20" Style="padding-left: 13px; width: 250px" runat="server" Text='Marital Status'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">

                                                            <asp:HiddenField ID="hfddlempmstId" runat="server" Value='<%# Eval("empmst") %>' />
                                                            <asp:HiddenField ID="hfddlempmsttext" runat="server" Value='<%# Eval("empmsttext") %>' />

                                                            <telerik:RadComboBox ID="ddlMaritalStatus" runat="server" Style="margin-top: 5px"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelMaritalStatus" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelMaritalStatus" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdMaritalStatus4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdMaritalStatus4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnMaritalStatusRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelMaritalStatus" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlMaritalStatus"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label21" Style="padding-left: 13px; width: 250px" runat="server" Text='Blood Group'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfBloodGroupdllID" runat="server" Value='<%# Eval("empblg") %>' />
                                                            <asp:HiddenField ID="hfBloodGroupdllText" runat="server" Value='<%# Eval("empblgtext") %>' />
                                                            <telerik:RadComboBox ID="ddlBloodGroup" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelBloodGroup" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelBloodGroup" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdBloodGroup4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBloodGroup4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnBloodGroupRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBloodGroup" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label22" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='ID Card No.'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">

                                                            <telerik:RadTextBox ID="txtempidc" MaxLength="100" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empidc") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label24" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Father Name'></asp:Label>


                                                        </td>
                                                        <td style="width: 280px;">
                                                            <telerik:RadTextBox ID="txtempftn" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empftn") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label25" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Monther Name'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempmtn" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empmtn") %>'>
                                                            </telerik:RadTextBox>

                                                        </td>

                                                    </tr>
                                                    <tr>

                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label26" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Father Name - Sec Lang'></asp:Label>


                                                        </td>
                                                        <td style="width: 280px;">
                                                            <telerik:RadTextBox ID="txtempfts" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empfts") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label27" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Mother Name - Sec Lang'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempmts" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empmts") %>'>
                                                            </telerik:RadTextBox>

                                                        </td>

                                                    </tr>


                                                </table>
                                            </telerik:RadPageView>
                                            <telerik:RadPageView runat="server" ValidateRequestMode="Disabled" ID="RadPageView2">
                                                <table style="margin: 10px">
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label2" Style="padding-left: 13px; width: 250px" runat="server" Text='Class'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlEmployeeClassId" runat="server" Value='<%# Eval("clsidd") %>' />
                                                            <asp:HiddenField ID="hfddlEmployeeClassText" runat="server" Value='<%# Eval("clscod") %>' />
                                                            <telerik:RadComboBox ID="ddlEmployeeClass" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelEmployeeClass" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelEmployeeClass" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdEmployeeClass4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployeeClass4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="recidd,clscod,clsds1" ClientDataKeyNames="recidd,clscod,clsds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="clscod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="clsds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnEmployeeClassRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelEmployeeClass" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label3" Style="padding-left: 13px; width: 250px" runat="server" Text='Grade'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfGradedllID" runat="server" Value='<%# Eval("grdidd") %>' />
                                                            <asp:HiddenField ID="hfGradedllText" runat="server" Value='<%# Eval("grdcod") %>' />
                                                            <telerik:RadComboBox ID="ddlGrade" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelGrade" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGrade" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdGrade4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGrade4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="grdidd,grdcode,grdds1" ClientDataKeyNames="grdidd,grdcode,grdds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="grdidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdcode" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="grdds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnGradeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGrade" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator322" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlGrade"></asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label30" Style="padding-left: 13px; width: 250px" runat="server" Text='Division'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlDivisionId" runat="server" Value='<%# Eval("dividd") %>' />
                                                            <asp:HiddenField ID="hfddlDivisionText" runat="server" Value='<%# Eval("divcod") %>' />
                                                            <asp:Button ID="btnHidden" ClientIDMode="Static" runat="server" Style="display: none;" OnClick="btn_Click" CausesValidation="false" />
                                                            <telerik:RadComboBox ID="ddlDivision" runat="server" CausesValidation="false" OnSelectedIndexChanged="ddlDivision_SelectedIndexChanged"
                                                                Width="255px" Height="200px" DropDownWidth="410px" AutoPostBack="true"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDivision" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdDivision4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDivision4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="dividd,divcod,divds1" ClientDataKeyNames="dividd,divcod,divds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="dividd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="divcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="divds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnDivisionRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDivision" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                        <td style="width: 280px;">


                                                            <asp:Label ID="Label29" Style="padding-left: 13px; width: 250px" runat="server" Text='Position'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfPositiondllID" runat="server" Value='<%# Eval("posidd") %>' />
                                                            <asp:HiddenField ID="hfPositiondllText" runat="server" Value='<%# Eval("poscod") %>' />
                                                            <telerik:RadComboBox ID="ddlPosition" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelPosition" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPosition" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdPosition4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPosition4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="recidd,poscod,posds1" ClientDataKeyNames="recidd,poscod,posds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="poscod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="posds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnPositionRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPosition" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator32222" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlPosition"></asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label28" Style="padding-left: 13px; width: 250px" runat="server" Text='Department'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlDepartmentId" runat="server" Value='<%# Eval("dptidd") %>' />
                                                            <asp:HiddenField ID="hfddlDepartmentText" runat="server" Value='<%# Eval("dptcod") %>' />
                                                            <telerik:RadComboBox ID="ddlDepartment" runat="server" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelDepartment" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDepartment" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdDepartment4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="dptidd,dptcod,dptds1" ClientDataKeyNames="dptidd,dptcod,dptds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="dptidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="dptcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="dptds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnDepartmentRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDepartment" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>

                                                        <td style="width: 280px;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3222" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlDepartment"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="Label31" Style="padding-left: 13px; width: 250px" runat="server" Text='Section'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfddlSectionId" runat="server" Value='<%# Eval("secidd") %>' />
                                                            <asp:HiddenField ID="hfddlSectionText" runat="server" Value='<%# Eval("seccod") %>' />
                                                            <telerik:RadComboBox ID="ddlSection" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelSection" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelSection" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdSection4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="secidd,seccod,secds1" ClientDataKeyNames="secidd,seccod,secds1">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="secidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="seccod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="secds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnSectionRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelSection" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label32" Style="padding-left: 13px; width: 250px" runat="server" Text='Status'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfempstsdllID" runat="server" Value='<%# Eval("empsts") %>' />
                                                            <asp:HiddenField ID="hfempstsdllText" runat="server" Value='<%# Eval("empststext") %>' />

                                                            <telerik:RadComboBox ID="ddlStatus" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelStatus" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelStatus" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdStatus4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdStatus4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnStatusRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelStatus" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator34" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlStatus"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="Label33" Style="padding-left: 13px; width: 250px" runat="server" Text='Status Change Date'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <telerik:RadDatePicker ID="dpstatusdatechange" runat="server" DbSelectedDate='<%# Bind("empsdt") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                            </telerik:RadDatePicker>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label34" Style="padding-left: 13px; width: 250px" runat="server" Text='Substitute Employee'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlEmployeeId" runat="server" Value='<%# Eval("empsbi") %>' />
                                                            <asp:HiddenField ID="hfddlEmployeeText" runat="server" Value='<%# Eval("empsbc") %>' />
                                                            <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelEmployee" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdEmployee4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="recidd,empcod,empfsn" ClientDataKeyNames="recidd,empcod,empfsn">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter column3 column"
                                                                                        HeaderText="description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnEmployeeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelEmployee" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label35" Style="padding-left: 13px; width: 250px" runat="server" Text='Location'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfddlLocationId" runat="server" Value='<%# Eval("locidd") %>' />
                                                            <asp:HiddenField ID="hfddlLocationText" runat="server" Value='<%# Eval("loccod") %>' />
                                                            <telerik:RadComboBox ID="ddlLocation" runat="server" Style="margin-top: 5px"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLocation" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdLocation4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLocation4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnLocationRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLocation" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label36" Style="padding-left: 13px; width: 250px" runat="server" Text='Supervisor'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlSupervisorId" runat="server" Value='<%# Eval("supidd") %>' />
                                                            <asp:HiddenField ID="hfddlSupervisorText" runat="server" Value='<%# Eval("supcod") %>' />
                                                            <telerik:RadComboBox ID="ddlSupervisor" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelSupervisor" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdSupervisor4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdSupervisor4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="supidd,supcod,supds1" ClientDataKeyNames="supidd,supcod,supds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="supidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="supcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="supds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnSupervisorRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelSupervisor" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label37" Style="padding-left: 13px; width: 250px" runat="server" Text='Office'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:HiddenField ID="hfoffiddddlId" runat="server" Value='<%# Eval("offidd") %>' />
                                                            <asp:HiddenField ID="hfoffcodddlText" runat="server" Value='<%# Eval("offcod") %>' />

                                                            <telerik:RadComboBox ID="ddlOffice" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelOffice" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelOffice" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdOffice4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdOffice4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="brnidd,brncod,brnds1" ClientDataKeyNames="brnidd,brncod,brnds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="brnidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brncod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brnds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnOfficeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelOffice" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>


                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label38" Style="padding-left: 13px; width: 250px" runat="server" Text='Employeement Type'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlEmployeementTypeId" runat="server" Value='<%# Eval("emptyp") %>' />
                                                            <asp:HiddenField ID="hfddlEmployeementTypeText" runat="server" Value='<%# Eval("emptyptext") %>' />
                                                            <telerik:RadComboBox ID="ddlEmployeementType" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelEmployeementType" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdEmployeementType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployeementType4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnEmployeementTypeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelEmployeementType" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator31" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlEmployeementType"></asp:RequiredFieldValidator>
                                                            <asp:Label ID="Label39" Style="padding-left: 13px; width: 250px" runat="server" Text='Visa Type'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hfddlVisaTypeId" runat="server" Value='<%# Eval("visidd") %>' />
                                                            <asp:HiddenField ID="hfddlVisaTypeText" runat="server" Value='<%# Eval("viscod") %>' />
                                                            <telerik:RadComboBox ID="ddlVisaType" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelVisaType" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdVisaType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdVisaType4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnVisaTypeRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelVisaType" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label40" Style="padding-left: 13px; width: 250px" runat="server" Text='Visa Profession'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlVisaProfessionID" runat="server" Value='<%# Eval("vispidd") %>' />
                                                            <asp:HiddenField ID="hfddlVisaProfessionText" runat="server" Value='<%# Eval("vispcod") %>' />
                                                            <telerik:RadComboBox ID="ddlVisaProfession" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelVisaProfession" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdVisaProfession4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdVisaProfession4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false"  FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnVisaProfessionRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelVisaProfession" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label41" Style="padding-left: 13px; width: 250px" runat="server" Text='Active Directory User'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ID="txtactivedirectory" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empadu") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label42" Style="padding-left: 13px; width: 250px" runat="server" Text='Joining Date'></asp:Label>
                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadDatePicker ID="dpJoiningDate" runat="server" DbSelectedDate='<%# Bind("empdoj") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label43" Style="padding-left: 13px; width: 250px" runat="server" Text='Is Active'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox runat="server" ID="chkbxisactive" Text="" Checked='<%# CheckBoxValue( Eval("empisact")) %>' />

                                                        </td>

                                                    </tr>
                                                </table>
                                            </telerik:RadPageView>
                                            <telerik:RadPageView runat="server" ValidateRequestMode="Disabled" ID="RadPageView3">
                                                <table style="margin: 10px">
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label4" Style="padding-left: 13px; width: 250px" runat="server" Text='Address'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadComboBox ID="ddlAddress" runat="server"
                                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelAddress" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelAddress" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdAddress4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdAddress4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Text" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Value" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnAddressRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelAddress" runat="server">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>


                                                        </td>
                                                        <td style="width: 280px;"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label44" Style="padding-left: 13px; width: 250px" runat="server" Text='Address 1'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddln1" MaxLength="200" Style="float: left" runat="server" Text='<%# Eval("addln1") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label5" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Address 2'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px;">
                                                            <telerik:RadTextBox ID="txtaddln2" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addln2") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label45" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Address 3'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddln3" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addln3") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label46" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Address 4'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddln4" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addln4") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label47" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Address 5'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddln5" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addln5") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label51" Style="padding-left: 13px; width: 250px" runat="server" Text='Country'></asp:Label>

                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hfddlCountryID" runat="server" Value='<%# Eval("ctridd") %>' />
                                                            <asp:HiddenField ID="hfddlCountryText" runat="server" Value='<%# Eval("ctrcod") %>' />
                                                            <telerik:RadComboBox ID="ddlCountry" runat="server" Style="margin-top: 5px" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCountry" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdCountry4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdCountry4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="recidd,ctrcod,ctrnam" ClientDataKeyNames="recidd,ctrcod,ctrnam">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrnam" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnCountryRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCountry" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>

                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label49" Style="padding-left: 13px; width: 250px" runat="server" Text='City'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfddlCityID" runat="server" Value='<%# Eval("ctyidd") %>' />
                                                            <asp:HiddenField ID="hfddlCityText" runat="server" Value='<%# Eval("ctycod") %>' />
                                                            <telerik:RadComboBox ID="ddlCity" runat="server" Style="margin-top: 5px"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCity" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdCity4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="recidd,ctrcty,ctrdsc" ClientDataKeyNames="recidd,ctrcty,ctrdsc">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrcty" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrdsc" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnCityRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCity" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label48" Style="padding-left: 13px; width: 250px" runat="server" Text='Province'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddprv" MaxLength="200" Style="float: left" runat="server" Text='<%# Eval("addprv") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label50" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Postal Code'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddpsc" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addpsc") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label52" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Local Number'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddlcn" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addlcn") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label53" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Mobile Number'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <telerik:RadTextBox ID="txtaddmbn" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addmbn") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label56" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Home Number'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddhmn" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addhmn") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label57" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Building'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddbld" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addbld") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label54" Style="padding-left: 13px; width: 250px" runat="server" Text='Unit'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddunt" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addunt") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">
                                                            <asp:Label ID="Label55" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Floor'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">
                                                            <telerik:RadTextBox ID="txtaddflr" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addflr") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label58" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Personal Email'></asp:Label>

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtaddpre" MaxLength="200" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("addpre") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadPageView>
                                            <telerik:RadPageView runat="server" ValidateRequestMode="Disabled" ID="RadPageView4">
                                                <table style="margin: 10px">
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label59" Style="padding-left: 13px; width: 250px" runat="server" Text='Payslip Email'></asp:Label>
                                                            <asp:HiddenField ID="hfemppsp" runat="server" Value='<%# Eval("emppsp") %>' />

                                                        </td>
                                                        <td colspan="3" style="border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtemppse" MaxLength="200" Style="float: left" runat="server" Text='<%# Eval("emppse") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label6" Style="padding-left: 13px; width: 250px" runat="server" Text='Payslip Password'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:TextBox ID="txtemppsp" MaxLength="20" Width="255px" TextMode="Password" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("emppsp") %>'>
                                                            </asp:TextBox>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label7" Style="padding-left: 13px; width: 250px" runat="server" Text='From Bank'></asp:Label>

                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hfddlFromBankID" runat="server" Value='<%# Eval("bnkfidd") %>' />
                                                            <asp:HiddenField ID="hfddlFromBankText" runat="server" Value='<%# Eval("bnkfcod") %>' />
                                                            <telerik:RadComboBox ID="ddlFromBank" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelFromBank" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdFromBank4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBank4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="brnidd,brncod,brnds1" ClientDataKeyNames="brnidd,brncod,brnds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="brnidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brncod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brnds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnFromBankRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelFromBank" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label60" Style="padding-left: 13px; width: 250px" runat="server" Text='To Bank'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <asp:HiddenField ID="hfbnktiddddlid" runat="server" Value='<%# Eval("bnktidd") %>' />
                                                            <asp:HiddenField ID="hfbnktcodddltext" runat="server" Value='<%# Eval("bnktcod") %>' />

                                                            <telerik:RadComboBox ID="ddlToBank" runat="server"
                                                                Width="255px" Height="200px" DropDownWidth="410px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelToBank" Height="200px">
                                                                        <telerik:RadGrid ID="rGrdToBank4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBank4DDL_NeedDataSource"
                                                                            Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="brnidd,brncod,brnds1" ClientDataKeyNames="brnidd,brncod,brnds1">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridBoundColumn DataField="brnidd" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="column1">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brncod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="column2">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="brnds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="column3">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnToBankRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                    </telerik:RadAjaxPanel>
                                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelToBank" runat="server" Skin="Default" Transparency="20">
                                                                    </telerik:RadAjaxLoadingPanel>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label61" Style="padding-left: 13px; width: 250px" runat="server" Text='IBAN Number'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <telerik:RadTextBox ID="txtempibn" MaxLength="50" Style="float: left" runat="server" Text='<%# Eval("empibn") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label62" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Bank Account Number'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempact" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empact") %>'>
                                                            </telerik:RadTextBox>
                                                            </t>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label63" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Swift Code'></asp:Label>

                                                        </td>
                                                            <td style="width: 280px;">

                                                                <telerik:RadTextBox ID="txtempswf" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empswf") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label64" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Routing Code'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtemprou" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("emprou") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label65" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Branch'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <telerik:RadTextBox ID="txtempbrn" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empbrncod") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label66" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Branch Country'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                            <telerik:RadTextBox ID="txtempbct" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empbct") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td style="width: 280px;">

                                                            <asp:Label ID="Label67" Style="padding-left: 13px; width: 250px; margin-top: 5px" runat="server" Text='Currency'></asp:Label>

                                                        </td>
                                                        <td style="width: 280px;">

                                                            <telerik:RadTextBox ID="txtempcur" MaxLength="50" Style="float: left; margin-top: 5px" runat="server" Text='<%# Eval("empcurcod") %>'>
                                                            </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </telerik:RadPageView>

                                        </telerik:RadMultiPage>
                                        <table style="margin: 10px">
                                            <tr>
                                                <td align="left">
                                                    <asp:Button ID="btnUpdate" CssClass="rgUpdate" Text="" CausesValidation="true"
                                                        runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>
                                                    <asp:Button ID="btnCancel" CssClass="rgCancel" Text="" runat="server" CausesValidation="False"
                                                        CommandName="Cancel"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                    </FormTemplate>
                                    <PopUpSettings ScrollBars="None" />
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


