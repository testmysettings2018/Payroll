using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class ExpenseEmployeeAssingment : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtExpSubTypeDetail = new DataTable();
    DataTable dtExpEmpAssignmentDetail = new DataTable();
    int formType = 3130;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "ExpenseEmployeeAssingment";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvExpense_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetExpenseTypeRecords", htSearchParams).Tables[0];
        dt.TableName = "ExpenseMaster";
        gvExpense.DataSource = dt;
        gvExpense.DataMember = "ExpenseMaster";
    }

    

    // grid update command
    protected void gvExpense_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_ExpEmpAssignment(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvExpense_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        try
        {
            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                ht.Add("@exptidd", (int)((GridDataItem)e.Item).GetDataKeyValue("exptidd"));
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpEmpAssignment_detail", ht);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            {
                ht.Add("@exptidd", (int)((GridDataItem)e.Item).GetDataKeyValue("exptidd"));
                ht.Add("@expsubtidd", (int)((GridDataItem)e.Item).GetDataKeyValue("expsubtidd"));
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpenseEmployeeAssignment_detail", ht);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpEmpAssignmentDetail")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpenseEmployeeAssignment_Record", ht);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpTypeEmpAssignment")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("empidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpTypeEmpAssignment_Record", ht);
                }
            }
            ShowClientMessage("Expense employee assignment record deleted successfully.", MessageType.Success);
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to delete expense employee assignment record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }

    }

    // client side validation function for premium type master input form
    public void ValidateExpenseDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");
        
        RadComboBox ddlEmployee = (editForm.FindControl("ddlEmployee") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpenseDetail('" +
                ddlEmployee.ClientID 
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpenseDetail('" +
                ddlEmployee.ClientID 
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvExpense_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                ValidateExpenseDetail(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    

                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEmployee = (RadComboBox)editedItem.FindControl("ddlEmployee");

                    if (ddlEmployee != null)
                    {
                        Hashtable ht = new Hashtable();
                        ht.Add("@exptidd", editedItem.GetDataKeyValue("exptidd").ToString());

                        DataTable dtEmp = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpTypeEmpAssignment_detail", ht).Tables[0];

                        RadGrid grid = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            ddlEmployee.Text = string.Empty;
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;

                                    foreach (DataRow row in dtEmp.Rows)
                                    {
                                        if (row["empidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlEmployee.Text))
                                                ddlEmployee.Text = ddlEmployee.Text + ",";
                                            ddlEmployee.Text = ddlEmployee.Text + row["empcod"].ToString();
                                            dataItem.Selected = true;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    #endregion
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            {
                ValidateExpenseDetail(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    

                    #endregion
                }
                else
                {
                    #region item is about to be edited

                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlEmployee = (RadComboBox)editedItem.FindControl("ddlEmployee");

                    if (ddlEmployee != null)
                    {
                        Hashtable ht = new Hashtable();
                        ht.Add("@exptidd", editedItem.GetDataKeyValue("exptidd").ToString());
                        ht.Add("@expsubtidd", editedItem.GetDataKeyValue("expsubtidd").ToString());
                        DataTable dtEmp = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseEmployeeAssignment_detail", ht).Tables[0];

                        RadGrid grid = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            ddlEmployee.Text = string.Empty;
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;

                                    foreach (DataRow row in dtEmp.Rows)
                                    {
                                        if (row["empidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlEmployee.Text))
                                                ddlEmployee.Text = ddlEmployee.Text + ",";
                                            ddlEmployee.Text = ddlEmployee.Text + row["empcod"].ToString();
                                            dataItem.Selected = true;
                                            break;
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
                ht_Reports.Add("@formtypeid", formType); 
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

    // clear form input controls for insert/update
    // grid export functions
    protected void gvExpense_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpEmpAssignmentDetail")
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

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpEmpAssignmentDetail")
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

            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "ExpEmpAssignmentDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnOvertimePrint");
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

    // function for export formating
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

                if (column.UniqueName == "EditExpenseSubType" || column.UniqueName == "DeleteExpenseSubType"
                    || column.UniqueName == "empcod" || column.UniqueName == "DeleteExpEmpAssignment")
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
    protected void gvExpense_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_ExpEmpAssignment(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_ExpEmpAssignment(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "ExpenseMaster")
            {
                //Insert new values
                Hashtable newPaycodeValues = new Hashtable();

                newPaycodeValues["@exptidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("exptidd"));

                RadComboBox ddlEmployee = (editedItem.FindControl("ddlEmployee") as RadComboBox);
                if (ddlEmployee != null)
                {
                    if (ddlEmployee.Items.Count > 0)
                    {
                        #region delete old records

                        Hashtable ht = new Hashtable();
                        ht.Add("@exptidd", Convert.ToInt32(editedItem.GetDataKeyValue("exptidd")));
                        clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpEmpAssignment_detail", ht);

                        #endregion

                        RadGrid rgEmployee = (ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid);
                        if (rgEmployee.SelectedItems.Count > 0)
                        {
                            foreach (GridDataItem dataItem in rgEmployee.SelectedItems)
                            {
                                newPaycodeValues["@empidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                newPaycodeValues["@empcod"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["empcod"].ToString();
                                newPaycodeValues["@empfsn"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["empfsn"].ToString();
                                newPaycodeValues["@DBMessage"] = "";
                                string DBMessage = "";

                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_ExpenseEmployeeAssignment_Record", newPaycodeValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255).ToString();
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                        }
                    }
                }
                ShowClientMessage("Expense employee assignment record saved successfully.", MessageType.Success);
                gvExpense.Rebind();
            }

            else if (e.Item.OwnerTableView.DataMember == "ExpSubTypeDetail")
            { 
                //Insert new values
                Hashtable newPaycodeValues = new Hashtable();

                newPaycodeValues["@exptidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("exptidd"));
                newPaycodeValues["@expsubtidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("expsubtidd"));
                newPaycodeValues["@expsubtcod"] = editedItem.GetDataKeyValue("expsubtcod");

                RadComboBox ddlEmployee = (editedItem.FindControl("ddlEmployee") as RadComboBox);
                if (ddlEmployee != null)
                {
                    if (ddlEmployee.Items.Count > 0)
                    {
                        #region delete old records

                        Hashtable ht = new Hashtable();
                        ht.Add("@exptidd", Convert.ToInt32(editedItem.GetDataKeyValue("exptidd")));
                        ht.Add("@expsubtidd", Convert.ToInt32(editedItem.GetDataKeyValue("expsubtidd"))); ;
                        clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_ExpenseEmployeeAssignment_detail", ht);

                        #endregion

                        RadGrid rgEmployee = (ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid);
                        if (rgEmployee.SelectedItems.Count > 0)
                        {
                            foreach (GridDataItem dataItem in rgEmployee.SelectedItems)
                            {
                                newPaycodeValues["@empidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString());
                                newPaycodeValues["@empcod"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["empcod"].ToString();
                                newPaycodeValues["@empfsn"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["empfsn"].ToString();
                                newPaycodeValues["@DBMessage"] = "";
                                string DBMessage = "";

                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_ExpenseEmployeeAssignment_Record", newPaycodeValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255).ToString();
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                        }
                    }
                }
                ShowClientMessage("Expense employee assignment record saved successfully.", MessageType.Success);
                //gvExpense.Rebind();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to save expense employee assignment record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // function for displaying client side messages
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

    // overtime detail tables data loading and binding
    protected void gvExpense_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "ExpSubTypeDetail":
                {
                    string id = dataItem.GetDataKeyValue("exptidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", id);

                    dtExpSubTypeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseSubType_Records", ht).Tables[0];
                    dtExpSubTypeDetail.TableName = "ExpSubTypeDetail";
                    e.DetailTableView.DataSource = dtExpSubTypeDetail;
                    e.DetailTableView.DataMember = "ExpSubTypeDetail";
                    break;
                }
            case "ExpEmpAssignmentDetail":
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@exptidd", dataItem.GetDataKeyValue("exptidd").ToString());
                    ht.Add("@expsubtidd", dataItem.GetDataKeyValue("expsubtidd").ToString());

                    dtExpEmpAssignmentDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseEmployeeAssignment_detail", ht).Tables[0];
                    dtExpEmpAssignmentDetail.TableName = "ExpEmpAssignmentDetail";
                    e.DetailTableView.DataSource = dtExpEmpAssignmentDetail;
                    e.DetailTableView.DataMember = "ExpEmpAssignmentDetail";
                    break;
                }
            case "ExpTypeEmpAssignment":
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@exptidd", dataItem.GetDataKeyValue("exptidd").ToString());

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpTypeEmpAssignment_detail", ht).Tables[0];
                    dt.TableName = "ExpTypeEmpAssignment";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpTypeEmpAssignment";
                    break;
                }
        }
    }

    // grid header setting for exporting
    protected void gvExpense_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
   
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }
}