<%@ Page Title="Leave Provision" MetaDescription="You can enter Leave Provision here." Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="LeaveProvision.aspx.cs" Inherits="LeaveProvision" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .fluid:before, .fluid:after {
            content: "";
            display: table;
            line-height: 0;
        }

        .fluid:after {
            clear: both;
        }

        .fluid:before, .fluid:after {
            content: "";
            display: table;
            line-height: 0;
        }

        /************************************************/

        .fluid [class*="span"]:first-child {
            margin-left: 0;
        }

        .fluid .span8 {
            width: 60%;
        }

        .fluid .span4 {
            width: 40%;
        }

        .fluid .span8 .formCol {
            width: 90% !important;
        }

        .fluid [class*="span"] {
            box-sizing: border-box;
            display: block;
            float: left;
            /*margin-left: 2.12766%;
            width: 100%;*/
        }


        .emp-data {
            float: left;
        }

            .emp-data label {
                float: left;
                /*width: 30px;*/
            }

        .emp-picture {
            float: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <!-- this for dropdown grid common functions-->
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            window.onload = function () {
                var grid = $('#<%=rCmbDepartments.Items[0].FindControl("rGrdDepartments4DDL").ClientID%>');
                    $("div.checker", grid).each(function () {
                        var td = $(this).parent();
                        var chk = $("input", $(this)).clone();
                        chk.css("opacity", "1");
                        $(this).remove();
                        td.append(chk);
                    });
                }

            function ShowTab(tab) {
                var wd = $("div[class^='widget']");
                if (wd != null && wd != undefined) {
                    if (typeof wd.contentTabs !== 'undefined' && $.isFunction(wd.contentTabs)) {
                        wd.contentTabs();
                        if (tab != "#tab1") {
                            wd.find("ul.tabs li:first").removeClass("activeTab").show(); //Activate first tab
                            wd.find(".tab_content:first").hide(); //Show first tab content

                            wd.find('a[href="' + tab + '"]').parent().addClass("activeTab"); //Add "active" class to selected tab
                            $(tab).show(); //Fade in the active content
                        }
                    }
                }
            };

            var isSorted = false;
            var ctrlId = "";
            function setSorted(senderID) {
                isSorted = true;
                ctrlId = senderID;
            }

            function OnClientDropDownClosing(sender, eventArgs) {
                if (sender.get_id() == ctrlId && isSorted) {
                    eventArgs.set_cancel(true);
                }
                else {
                    eventArgs.set_cancel(false);
                }
                isSorted = false;
                ctrlId = "";
                if (sender.get_value() == "")
                    sender.set_text("");
            }

            function RowSelect(row, senderID) {
                var combo = $find(senderID);
                setTimeout(function () {
                    combo.set_text($(row).find('td.text').text().trim());
                    combo.set_value($(row).find('td.value').text().trim());
                }, 50);
            }

            function OnClientLoad(editor, args) {
                editor.add_modeChange(function (editor, args) {
                    var mode = editor.get_mode();
                    if (mode == 2) {
                        var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                        htmlMode.disabled = "true";
                    }
                });
            }

            function RowSelectDepartment(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "dptds1")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }

                var combo = $find(sender.ClientID.replace('_i0_rGrdDepartments4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(headerValues);
                combo.get_items().getItem(0).set_value(headerValues);
                combo.commitChanges();
                //}, 50);
            }

            function RowSelectEmployee(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "empcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(headerValues);
                combo.get_items().getItem(0).set_value(headerValues);
                combo.commitChanges();
                //}, 50);
            }

            function ConfirmCalculateButton(button) {
                function aspButtonCallbackFn(arg) {
                    if (arg) {
                        __doPostBack(button.name, "");
                    }
                }
                radconfirm("Are you confirm to Calculate Leave Provision?", aspButtonCallbackFn, 330, 180, null, "Confirm Process");
            }

            var currentLoadingPanel = null;
            var currentUpdatedControl = null;

            function RequestStart(sender, args) {
                currentLoadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                currentUpdatedControl = "<%= pnlAjaxForm.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }

            function ResponseEnd() {
                //hide the loading panel and clean up the global variables
                if (currentLoadingPanel != null)
                    currentLoadingPanel.hide(currentUpdatedControl);
                currentUpdatedControl = null;
                currentLoadingPanel = null;
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdDepartments4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rCmbEmployee" />
                    <telerik:AjaxUpdatedControl ControlID="hfdps" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator1" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator2" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator3" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rBtnCalculate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rBtnCalculate" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator1" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator2" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator3" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
        <ul class="tabs">
            <li class="Tab1">
                <a href="#tab1">Leave Provision</a>
            </li>
        </ul>

        <div class="tab_container">
            <telerik:RadAjaxPanel ID="RadAjaxPanel11" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
                <div id="tab1" class="tab_content">
                    <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                        <asp:HiddenField ID="hfdps" runat="server" />

                        <div class="widget">

                            <div class="title">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6>Details</h6>
                            </div>

                            <div class="formRow">
                                <div class="formCol">
                                    <label>Department</label>
                                    <div class="formRight">
                                        <table>
                                            <tr>
                                                <td>

                                                    <telerik:RadComboBox ID="rCmbDepartments" runat="server" Width="254px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; max-height: 300px;">
                                                                <telerik:RadGrid ID="rGrdDepartments4DDL" runat="server" AllowMultiRowSelection="true" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True"
                                                                    OnNeedDataSource="rGrdDepartments4DDL_NeedDataSource" OnSelectedIndexChanged="rGrdDepartments4DDL_SelectedIndexChanged">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="dptidd,dptcod" ClientDataKeyNames="dptidd,dptcod,dptds1">
                                                                        <Columns>
                                                                            <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                            <telerik:GridBoundColumn DataField="dptidd" FilterControlAltText="Filter column column"
                                                                                HeaderText="ID" UniqueName="dptidd">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="dptcod" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="Code" UniqueName="dptcod">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="dptds1" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Name" UniqueName="dptds1">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                    <ClientSettings EnablePostBackOnRowClick="true">
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        <ClientEvents OnRowSelected="RowSelectDepartment" OnRowDeselected="RowSelectDepartment"></ClientEvents>
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
                                                </td>

                                                <td>
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator1"
                                                        ControlToValidate="rCmbDepartments"
                                                        ErrorMessage="*"
                                                        Display="Dynamic"
                                                        CssClass="requiredvalidators"
                                                        ValidationGroup="FrmSubmit"
                                                        SetFocusOnError="False"
                                                        runat="server"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div class="formCol">
                                    <label>Employee</label>
                                    <div class="formRight">
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rCmbEmployee" runat="server" Width="254px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; max-height: 300px;">
                                                                <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowMultiRowSelection="true" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True" OnNeedDataSource="rGrdEmployees4DDL_NeedDataSource">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,empcod,empfsn" ClientDataKeyNames="recidd,empcod,empfsn">
                                                                        <Columns>
                                                                            <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="recidd">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="empcod">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter column3 column"
                                                                                HeaderText="description" UniqueName="empfsn">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        <ClientEvents OnRowDeselected="RowSelectEmployee" OnRowSelected="RowSelectEmployee"></ClientEvents>
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

                                                </td>

                                                <td>
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator2"
                                                        ControlToValidate="rCmbEmployee"
                                                        ErrorMessage="*"
                                                        Display="Dynamic"
                                                        CssClass="requiredvalidators"
                                                        ValidationGroup="FrmSubmit"
                                                        SetFocusOnError="False"
                                                        runat="server"></asp:RequiredFieldValidator>

                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>

                            <div class="formRow">
                                <div class="formCol">
                                    <label>Till Date</label>
                                    <div class="formRight">
                                        <table>
                                            <tr>
                                                <td>

                                                    <telerik:RadDatePicker ID="txtDate" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                </td>

                                                <td>
                                                    <asp:RequiredFieldValidator
                                                        ID="RequiredFieldValidator3"
                                                        ControlToValidate="txtDate"
                                                        ErrorMessage="*"
                                                        Display="Dynamic"
                                                        CssClass="requiredvalidators"
                                                        ValidationGroup="FrmSubmit"
                                                        SetFocusOnError="False"
                                                        runat="server"></asp:RequiredFieldValidator>

                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>

                                <div class="clear"></div>
                            </div>

                        </div>
                        <div class="clear"></div>

                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnCalculate" OnClientClick="ConfirmCalculateButton(this); return false;" runat="server" OnClick="rBtnCalculate_Click"
                                    Text="Calculate Leave Provision" ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="True"></asp:Button>
                            </span>
                        </div>

                        <div class="clear"></div>
                    </asp:Panel>
                </div>
            </telerik:RadAjaxPanel>
        </div>
        <div class="clear"></div>
    </div>


    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 10000;">
    </telerik:RadWindowManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Width="256px" Height="64px">
    </telerik:RadAjaxLoadingPanel>
</asp:Content>
