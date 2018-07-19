using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_LeaveBalance : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtEmpLeaves = new DataTable();

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Employee Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // employee master data loading and binding
    protected void gvEmployee_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetLeaveEmployees", htSearchParams).Tables[0];
        dt.TableName = "EmployeeMaster";
        gvEmployee.DataSource = dt;
        gvEmployee.DataMember = "EmployeeMaster";
    }

    // grid update command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Update");
    }

    // grid delete command
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("levid");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee_EmpLeavesDetail", ht);
            }
        }
    }

    // client side validation function for employee leave balance form 
    public void ValidateEmpLeaveBalance(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadDatePicker dtpdate = (editForm.FindControl("dtpdate") as RadDatePicker);
        RadNumericTextBox txtBxBalance = (editForm.FindControl("txtBxBalance") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmpLeaves('" +
                txtBxBalance.ClientID + "','" +
                dtpdate.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmpLeaves('" +
                txtBxBalance.ClientID + "','" +
                dtpdate.ClientID
                + "')");
        }
    }

    // form control setting for insert/update
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
            {
                ValidateEmpLeaveBalance(e);

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

                    RadComboBox ddlEmpLeavesType = (RadComboBox)editedItem.FindControl("ddlEmpLeavesType");
                    HiddenField hfEmpLeavesTypedllID = (HiddenField)editedItem.FindControl("hfEmpLeavesTypedllID");
                    HiddenField hfEmpLeavesTypedllText = (HiddenField)editedItem.FindControl("hfEmpLeavesTypedllText");
                    HiddenField hfEmpLeavesTypedllValue = (HiddenField)editedItem.FindControl("hfEmpLeavesTypedllValue");
                    if (ddlEmpLeavesType != null)
                    {
                        RadGrid grid = ddlEmpLeavesType.Items[0].FindControl("rGrdEmpLeavesType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfEmpLeavesTypedllID.Value) && !string.IsNullOrEmpty(hfEmpLeavesTypedllText.Value))
                        {
                            ddlEmpLeavesType.Items[0].Value = hfEmpLeavesTypedllID.Value;
                            ddlEmpLeavesType.Items[0].Text = hfEmpLeavesTypedllText.Value;
                            ddlEmpLeavesType.Text = hfEmpLeavesTypedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfEmpLeavesTypedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
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

                        if (!string.IsNullOrEmpty(hfPayPerioddllID.Value) && !string.IsNullOrEmpty(hfEmpLeavesTypedllText.Value))
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

                    RadComboBox ddlEmpLeaves = (RadComboBox)editedItem.FindControl("ddlEmpLeaves");
                    HiddenField hfddlEmpLeavesId = (HiddenField)editedItem.FindControl("hfddlEmpLeavesId");
                    HiddenField hfddlEmpLeavesText = (HiddenField)editedItem.FindControl("hfddlEmpLeavesText");

                    HiddenField hfEmpLeavesID = (HiddenField)editedItem.FindControl("hfEmpLeavesID");

                    if (ddlEmpLeaves != null)
                    {
                        RadGrid grid = ddlEmpLeaves.Items[0].FindControl("rGrdEmpLeaves4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfddlEmpLeavesId.Value) && !string.IsNullOrEmpty(hfddlEmpLeavesText.Value))
                        {
                            ddlEmpLeaves.Items[0].Value = hfddlEmpLeavesId.Value;
                            ddlEmpLeaves.Items[0].Text = hfddlEmpLeavesText.Value;
                            ddlEmpLeaves.Text = hfddlEmpLeavesText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfddlEmpLeavesId.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
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
                ht_Reports.Add("@formtypeid", 3097); // Action Sequence form type = 3097

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

    // clear form controls for insert/udpate
    // grid exporting functions
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
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

            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
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
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
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

                if (column.UniqueName == "EditEmpLeaves" || column.UniqueName == "DeleteEmpLeaves")
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

            if (e.Item.OwnerTableView.DataMember == "EmpLeavesDetail")
            {
                //Insert new values
                newValues = new Hashtable();
                if (operation == "Update")
                {
                    newValues["@lvcidd"] = (int)editedItem.GetDataKeyValue("levid");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@lvtidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["lvtidd"].ToString());
                }
                GridDataItem secondParentItem = (GridDataItem)(parentItem.OwnerTableView.ParentItem);
                if (secondParentItem != null)
                {
                    newValues["@empidd"] = Convert.ToInt32(secondParentItem.OwnerTableView.DataKeyValues[secondParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@lvcbal"] = (editedItem.FindControl("txtBxBalance") as RadNumericTextBox).Text;
                newValues["@lvcdat"] = (editedItem.FindControl("dtpdate") as RadDatePicker).SelectedDate;
                newValues["@DBMessage"] = "";

                string DBMessage = "";

                //if (operation == "Insert")
                //{
                //    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Employee_EmpLeaves", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                //}
                //else 
                if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmployeeLeaveBalance", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                ShowClientMessage("Employee Leave Balance record save successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee Leave Balance record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function to show client side message 
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

    // detail tables data loading and binding
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "EmpLeaves":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@EmpId", ID);

                    dtEmpLeaves = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecords", ht).Tables[0];
                    dtEmpLeaves.TableName = "EmpLeaves";
                    e.DetailTableView.DataSource = dtEmpLeaves;
                    e.DetailTableView.DataMember = "EmpLeaves";
                    break;
                }
            case "EmpLeavesDetail":
                {
                    int leaveTypeId = Convert.ToInt32(dataItem.GetDataKeyValue("lvtidd").ToString());
                    int empId = 0;
                    GridDataItem parentItem = (GridDataItem)(dataItem.OwnerTableView.ParentItem);
                    if (parentItem != null)
                    {
                        empId = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                    }
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmpId", empId);
                    ht.Add("@LtypId", leaveTypeId);

                    dtEmpLeaves = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveBalanceRecord", ht).Tables[0];
                    dtEmpLeaves.TableName = "EmpLeavesDetail";
                    e.DetailTableView.DataSource = dtEmpLeaves;
                    e.DetailTableView.DataMember = "EmpLeavesDetail";
                    break;
                }
        }
    }

    // get value of grid boolean column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for grid boolean column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header export settings
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}