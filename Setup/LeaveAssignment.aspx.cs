using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.Device.Detection;

public partial class Payroll_LeaveAssignment : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtEmpLeaves = new DataTable();

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Employee Leave Assignment Form";
        base.Page_Init(sender, e);
        DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);
        myFunction(screenDimensions);
    }

    private void myFunction(DeviceScreenDimensions screenDimensions)
    {

        if (screenDimensions.Width < 680 && screenDimensions.Width != 0)
        {
            gvEmployee.PagerStyle.Mode = GridPagerMode.NextPrev;        

        }
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

    // leave type ddl data loading and binding
    protected void rGrdLeaveType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_LeaveTypeSetup", htSearchParams).Tables[0];
    }

    // leave ddl data loading and binding
    protected void rGrdLeave4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        //sender.da
        //HiddenField temp = hfEmployeeLevId

        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetAllLeaveRecords", htSearchParams).Tables[0];
    }

    // grid insert command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employee(ref e, "Update");
    }

    // grid delete command for all master and detail tables
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();

        //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
        //{
        //    int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
        //    if (ID > 0)
        //    {
        //        ht.Add("@ID", ID);
        //        clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee", ht);
        //    }
        //}
        if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee_EmpLeaves", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employee_EmpLeavesDetail", ht);
            }
        }
    }

    // client side validation function for leave type input form 
    public void ValidateEmpLeaveTypes(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlLeaveType = (editForm.FindControl("ddlLeaveType") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmpLeaveTypes('" +
                ddlLeaveType.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmpLeaveTypes('" +
                ddlLeaveType.ClientID
                + "')");
        }
    }

    // client side validation function for leaves code form input
    public void ValidateEmpLeaves(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlLeave = (editForm.FindControl("ddlLeave") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmpLeaves('" +
                ddlLeave.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmpLeaves('" +
                ddlLeave.ClientID
                + "')");
        }
    }

    // form controls setting for insert/update
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            //{

            //}
            //else 
            if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
            {
                ValidateEmpLeaveTypes(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeaveType = (RadComboBox)insertedItem.FindControl("ddlLeaveType");
                    HiddenField hfEmployeeId = (HiddenField)insertedItem.FindControl("hfEmployeeId");
                    if (hfEmployeeId.Value == "")
                        hfEmployeeId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlLeaveType != null)
                    {
                        if (hfEmployeeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmpId", ID);
                            DataTable dt_LeaveTypes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecords", ht).Tables[0];

                            RadGrid grid = ddlLeaveType.Items[0].FindControl("rGrdLeaveType4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlLeaveType.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_LeaveTypes.Rows)
                                        {
                                            if (row["lvtidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlLeaveType.Text))
                                                    ddlLeaveType.Text = ddlLeaveType.Text + ",";
                                                ddlLeaveType.Text = ddlLeaveType.Text + row["lvtcod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeaveType = (RadComboBox)editedItem.FindControl("ddlLeaveType");
                    HiddenField hfEmployeeId = (HiddenField)editedItem.FindControl("hfEmployeeId");
                    if (hfEmployeeId.Value == "")
                        hfEmployeeId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlLeaveType != null)
                    {
                        if (hfEmployeeId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmpId", ID);
                            DataTable dt_LeaveTypes = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecords", ht).Tables[0];

                            RadGrid grid = ddlLeaveType.Items[0].FindControl("rGrdLeaveType4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlLeaveType.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_LeaveTypes.Rows)
                                        {
                                            if (row["lvtidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlLeaveType.Text))
                                                    ddlLeaveType.Text = ddlLeaveType.Text + ",";
                                                ddlLeaveType.Text = ddlLeaveType.Text + row["lvtcod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                ValidateEmpLeaves(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeave = (RadComboBox)insertedItem.FindControl("ddlLeave");
                    HiddenField hfEmployeeLevId = (HiddenField)insertedItem.FindControl("hfEmployeeLevId");
                    if (hfEmployeeLevId.Value == "")
                        hfEmployeeLevId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlLeave != null)
                    {
                        if (hfEmployeeLevId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeLevId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmpLevId", ID);
                            DataTable dt_Leave = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecordsDetail", ht).Tables[0];

                            RadGrid grid = ddlLeave.Items[0].FindControl("rGrdLeave4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlLeave.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_Leave.Rows)
                                        {
                                            if (row["lvcidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlLeave.Text))
                                                    ddlLeave.Text = ddlLeave.Text + ",";
                                                ddlLeave.Text = ddlLeave.Text + row["lvccod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlLeave = (RadComboBox)editedItem.FindControl("ddlLeave");
                    HiddenField hfEmployeeLevId = (HiddenField)editedItem.FindControl("hfEmployeeLevId");
                    if (hfEmployeeLevId.Value == "")
                        hfEmployeeLevId.Value = e.Item.OwnerTableView.ParentItem.GetDataKeyValue("recidd").ToString();

                    if (ddlLeave != null)
                    {
                        if (hfEmployeeLevId != null)
                        {
                            Int32 ID = Convert.ToInt32(hfEmployeeLevId.Value);
                            Hashtable ht = new Hashtable();
                            ht.Add("@EmpLevId", ID);
                            DataTable dt_Leave = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecordsDetail", ht).Tables[0];

                            RadGrid grid = ddlLeave.Items[0].FindControl("rGrdLeave4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlLeave.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_Leave.Rows)
                                        {
                                            if (row["lvcidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlLeave.Text))
                                                    ddlLeave.Text = ddlLeave.Text + ",";
                                                ddlLeave.Text = ddlLeave.Text + row["lvccod"].ToString();
                                                dataItem.Selected = true;
                                                break;
                                            }
                                        }
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

    // clear form input controls for insert/udpate
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

            //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            //{
            //    grid.MasterTableView.ExportToExcel();
            //}
            //else 
            if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
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

            //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            //{
            //}
            //else 
            if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
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
            //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            //{
            //}
            //else 
            if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
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

    // function for export setting
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

            if (e.Item.OwnerTableView.DataMember == "EmpLeaveTypes")
            {
                newValues = new Hashtable();
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@empidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@DBMessage"] = "";
                RadComboBox ddlLeaveType = (editedItem.FindControl("ddlLeaveType") as RadComboBox);
                if (ddlLeaveType != null)
                {
                    if (ddlLeaveType.Items.Count > 0)
                    {
                        RadGrid rgrLeaveTypes = (ddlLeaveType.Items[0].FindControl("rGrdLeaveType4DDL") as RadGrid);
                        if (rgrLeaveTypes.SelectedItems.Count > 0)
                        {
                            #region delete old records

                            Hashtable ht = new Hashtable();
                            ht.Add("@empID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeLeaveTypeRecords", ht);

                            #endregion

                            foreach (GridDataItem dataItem in rgrLeaveTypes.SelectedItems)
                            {
                                newValues["@lvtidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                newValues["@DBMessage"] = "";

                                string DBMessage = "";
                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmployeeLeaveTypeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                            ShowClientMessage("Employee Leave Type record save successfully.", MessageType.Success);
                        }
                    }
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpLeaves")
            {
                newValues = new Hashtable();
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@emplevidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@DBMessage"] = "";
                RadComboBox dt_Leave = (editedItem.FindControl("ddlLeave") as RadComboBox);
                if (dt_Leave != null)
                {
                    if (dt_Leave.Items.Count > 0)
                    {
                        RadGrid rgrLeave = (dt_Leave.Items[0].FindControl("rGrdLeave4DDL") as RadGrid);
                        if (rgrLeave.SelectedItems.Count > 0)
                        {
                            #region delete old records

                            Hashtable ht = new Hashtable();
                            ht.Add("@emplevID", Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString()));
                            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeLeaveCodeRecords", ht);

                            #endregion

                            foreach (GridDataItem dataItem in rgrLeave.SelectedItems)
                            {
                                newValues["@lvcidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                newValues["@DBMessage"] = "";

                                string DBMessage = "";
                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_EmployeeLeaveCodeRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                            ShowClientMessage("Employee Leave Code record save successfully.", MessageType.Success);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee Leave record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function to display client side messages
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

    // leaves ddl data loading and binding
    protected void rGrdEmpLeaves4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpLeaves_Records", htSearchParams).Tables[0];
    }

    // grid detail tables data loading and binding
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "EmpLeaveTypes":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@EmpId", ID);

                    dtEmpLeaves = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecords", ht).Tables[0];
                    dtEmpLeaves.TableName = "EmpLeaveTypes";
                    e.DetailTableView.DataSource = dtEmpLeaves;
                    e.DetailTableView.DataMember = "EmpLeaveTypes";
                    break;
                }
            case "EmpLeaves":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@EmplevId", ID);

                    dtEmpLeaves = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveRecordsDetail", ht).Tables[0];
                    dtEmpLeaves.TableName = "EmpLeaves";
                    e.DetailTableView.DataSource = dtEmpLeaves;
                    e.DetailTableView.DataMember = "EmpLeaves";
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

    // grid header setting for exporting
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}