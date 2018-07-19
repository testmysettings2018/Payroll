using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_EmployeePayCodeSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtPayCodes = new DataTable();

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Employee Pay Code Setup Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // employee master grid data loading and binding
    protected void gvEmployee_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
        dt.TableName = "EmployeeMaster";
        gvEmployee.DataSource = dt;
        gvEmployee.DataMember = "EmployeeMaster";
    }

    // employee ddl data loading and binding
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }

    // supervisor ddl data loading and binding
    protected void rGrdSupervisor4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Supervisors", htSearchParams).Tables[0];
    }

    // date format ddl data loading and binding
    protected void rGrdDateFormat4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.AttDateFormat, -1, 1).Tables[0];
    }

    // location ddl data loading and binding
    protected void rGrdLocation4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.Location, -1, 1).Tables[0];
    }

    // status ddl data loading and binding
    protected void rGrdStatus4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.EmployeeStatus, -1, 1).Tables[0];
    }

    // gender ddl data loading and binding
    protected void rGrdGender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.Gender, -1, 1).Tables[0];
    }

    // marital status ddl data loading and binding
    protected void rGrdMaritalStatus4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.MaritalStatus, -1, 1).Tables[0];
    }

    // employement type ddl data loading and binding
    protected void rGrdEmployeementType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.ECEmploymentType, -1, 1).Tables[0];
    }

    // visa type ddl data loading and binding
    protected void rGrdVisaType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.VisaType, -1, 1).Tables[0];
    }

    // address ddl data loading and binding
    protected void rGrdAddress4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.EmployeeAddress, -1, 1).Tables[0];
    }

    // blood group ddl data loading and binding
    protected void rGrdBloodGroup4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.BloodGroup, -1, 1).Tables[0];
    }

    // visa profession ddl data loading and binding
    protected void rGrdVisaProfession4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.VisaProfession, -1, 1).Tables[0];
    }

    // country ddl data loading and binding
    protected void rGrdCountry4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_getallcountries", htSearchParams).Tables[0];
    }

    // bank ddl data loading and binding
    protected void rGrdBank4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Branches", htSearchParams).Tables[0];
    }

    // office ddl data loading and binding
    protected void rGrdOffice4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Branches", htSearchParams).Tables[0];
    }

    // position ddl data loading and binding
    protected void rGrdPosition4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllPositions", htSearchParams).Tables[0];
    }

    // division ddl data loading and binding
    protected void rGrdDivision4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Divisions", htSearchParams).Tables[0];
    }

    // grade ddl data loading and binding
    protected void rGrdGrade4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Grades", htSearchParams).Tables[0];
    }

    // department ddl data loading and binding
    protected void rGrdDepartment4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetAllDepartments", htSearchParams).Tables[0];
    }

    // nationality ddl data loading and binding
    protected void rGrdNatCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Nationalities", htSearchParams).Tables[0];
    }

    // religion ddl data loading and binding
    protected void rGrdReligion4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Religions", htSearchParams).Tables[0];
    }

    // employee class ddl data loading and binding
    protected void rGrdEmployeeClass4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_EmployeeClassess", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Update");
    }

    // grid delete command for all master and detail grids.
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "PayCodes")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee_PayCode", ht);
            }
        }
    }

    // client side validation function for paycodes form input controls
    public void ValidatePayCodes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlPayCode = (editForm.FindControl("ddlPayCode") as RadComboBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);
        RadComboBox ddlPayCodeType = (editForm.FindControl("ddlPayCodeType") as RadComboBox);
        RadComboBox ddlPayPeriod = (editForm.FindControl("ddlPayPeriod") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidatePayCode('" +
                ddlPayCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlPayCodeType.ClientID + "','" +
                ddlPayPeriod.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidatePayCode('" +
                ddlPayCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlPayCodeType.ClientID + "','" +
                ddlPayPeriod.ClientID
                + "')");
        }
    }

    // set form controls for insert/update
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                ValidatePayCodes(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlFileType = (RadComboBox)insertedItem.FindControl("ddlFileType");

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlPayCodeType = (RadComboBox)editedItem.FindControl("ddlPayCodeType");
                    HiddenField hfPayCodeTypedllID = (HiddenField)editedItem.FindControl("hfPayCodeTypedllID");
                    HiddenField hfPayCodeTypedllText = (HiddenField)editedItem.FindControl("hfPayCodeTypedllText");
                    HiddenField hfPayCodeTypedllValue = (HiddenField)editedItem.FindControl("hfPayCodeTypedllValue");
                    if (ddlPayCodeType != null)
                    {
                        RadGrid grid = ddlPayCodeType.Items[0].FindControl("rGrdPayCodeType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPayCodeTypedllID.Value) && !string.IsNullOrEmpty(hfPayCodeTypedllText.Value))
                        {
                            ddlPayCodeType.Items[0].Value = hfPayCodeTypedllID.Value;
                            ddlPayCodeType.Items[0].Text = hfPayCodeTypedllText.Value;
                            ddlPayCodeType.Text = hfPayCodeTypedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPayCodeTypedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlPayPeriod = (RadComboBox)editedItem.FindControl("ddlPayPeriod");
                    HiddenField hfPayPerioddllID = (HiddenField)editedItem.FindControl("hfPayPerioddllID");
                    HiddenField hfPayPeriodddlText = (HiddenField)editedItem.FindControl("hfPayPeriodddlText");
                    HiddenField hfPayPeriodddlValue = (HiddenField)editedItem.FindControl("hfPayPeriodddlValue");
                    if (ddlPayPeriod != null)
                    {
                        RadGrid grid = ddlPayPeriod.Items[0].FindControl("rGrdPayPeriod4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfPayPerioddllID.Value) && !string.IsNullOrEmpty(hfPayCodeTypedllText.Value))
                        {
                            ddlPayPeriod.Items[0].Value = hfPayPerioddllID.Value;
                            ddlPayPeriod.Items[0].Text = hfPayPeriodddlText.Value;
                            ddlPayPeriod.Text = hfPayPeriodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfPayPerioddllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlPayCode = (RadComboBox)editedItem.FindControl("ddlPayCode");
                    HiddenField hfddlPayCodeId = (HiddenField)editedItem.FindControl("hfddlPayCodeId");
                    HiddenField hfddlPayCodeText = (HiddenField)editedItem.FindControl("hfddlPayCodeText");

                    HiddenField hfPayCodeID = (HiddenField)editedItem.FindControl("hfPayCodeID");

                    if (ddlPayCode != null)
                    {
                        RadGrid grid = ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlPayCodeId.Value) && !string.IsNullOrEmpty(hfddlPayCodeText.Value))
                        {
                            ddlPayCode.Items[0].Value = hfddlPayCodeId.Value;
                            ddlPayCode.Items[0].Text = hfddlPayCodeText.Value;
                            ddlPayCode.Text = hfddlPayCodeText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlPayCodeId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    #endregion
                }
            }
        }
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            RadComboBox ddlPrintOptions = (RadComboBox)commandItem.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                Hashtable ht_Reports = new Hashtable();
                ht_Reports.Add("@userid", Session["_UserID"].ToString());
                ht_Reports.Add("@formtypeid", Request.QueryString["FormType"]);
                DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];
                if (ddlPrintOptions != null)
                {
                    ddlPrintOptions.DataSource = dt_Reports;
                    ddlPrintOptions.DataTextField = "reportname";
                    ddlPrintOptions.DataValueField = "idd";
                    ddlPrintOptions.DataBind();
                    ddlPrintOptions.SelectedIndex = 0;
                }
            }
        }
    }

    // clear form controls for insert/update
    // grid exporting functions for master and detail tables
    protected void gvEmployee_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();

        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;

        }
        if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = true;
            grid.ExportSettings.HideStructureColumns = true;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.EnableHierarchyExpandAll = false;

            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }

            if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnEmployeePrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    String qstring = clsEncryption.EncryptData(ddlPrintOptions.Text);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    // export formating function
    protected void GridTableHierarchySetEditability(GridTableView view, bool editAllowed)
    {
        foreach (GridFilteringItem item in view.GetItems(GridItemType.FilteringItem))
            item.Visible = false;

        foreach (GridHeaderItem item in view.GetItems(GridItemType.Header))
        {
            if (item.Cells[0].Text == "&nbsp;")
            {
                item.Cells[0].Visible = false;
            }
        }

        //If editing is not allowed, remove any edit or command-button columns.  
        if (editAllowed)
        {

            //Remove editing columns in the current view  
            foreach (GridColumn column in view.Columns)
            {
                if (column.UniqueName == "ExpandColumn")
                {
                    column.Display = false;
                    column.Visible = false;
                }

                if (column.UniqueName == "EditPayCode" || column.UniqueName == "DeletePayCode")
                {
                    column.Display = false;
                    column.Visible = false;
                }

            }
        }

        if (view.HasDetailTables)
        {
            foreach (GridDataItem item in view.Items)
            {
                if (item.HasChildItems)
                {
                    foreach (GridTableView innerView in item.ChildItem.NestedTableViews)
                    {
                        GridTableHierarchySetEditability(innerView, true);
                    }
                }
            }
        }
    }

    // grid insert command
    protected void gvEmployee_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Employee(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "PayCodes")
            {
                //Insert new values
                newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@empidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@payidd"] = (editedItem.FindControl("ddlPayCode") as RadComboBox).Items[0].Value.Trim();
                newValues["@payds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
                newValues["@payds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
                newValues["@paytyp"] = (editedItem.FindControl("ddlPayCodeType") as RadComboBox).Items[0].Value.Trim();
                newValues["@payrat"] = string.IsNullOrEmpty((editedItem.FindControl("txtPayrate") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtPayrate") as RadNumericTextBox).Text;
                newValues["@payunp"] = ""; // (editedItem.FindControl("txtUnitofPay") as RadTextBox).Text;
                newValues["@payper"] = (editedItem.FindControl("ddlPayPeriod") as RadComboBox).Items[0].Value.Trim();
                newValues["@payppr"] = string.IsNullOrEmpty((editedItem.FindControl("txtpayperpriod") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtpayperpriod") as RadNumericTextBox).Text;
                newValues["@payact"] = (editedItem.FindControl("chkbxInclude") as CheckBox).Checked;
                newValues["@paydft"] = (editedItem.FindControl("chkbxDefault") as CheckBox).Checked;
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Employee_Paycode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Employee_PayCode", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Employee Pay Code record save successfully.", MessageType.Success);
            }
        }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee Pay Code record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // display client side messages
    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000)", true);
        }
    }

    // pay code type ddl data loading and binding
    protected void rGrdPayCodeType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.PayCodeType, -1, 1).Tables[0];
    }

    // Pay per period ddl data loading and binding
    protected void rGrdPayPeriod4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.PayCodePeriod, -1, 1).Tables[0];
    }

    // paycode ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // data loading and binding for all detail grids
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "PayCodes":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtPayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmployeePayCode_RecordDetail", ht).Tables[0];
                    dtPayCodes.TableName = "PayCodes";
                    e.DetailTableView.DataSource = dtPayCodes;
                    e.DetailTableView.DataMember = "PayCodes";
                    break;
                }
        }
    }

    // get value of grid boolean columns
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for boolean grid columns
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header setting for exporting
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}