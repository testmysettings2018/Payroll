using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class EmployeeExpenseAssingment : BasePage
{

    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtEmpExpTypeDetail = new DataTable();
    DataTable dtEmpExpSubTypeDetail = new DataTable();
    int formType = 3130;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "EmployeeExpenseAssingment";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // overtime master grid data loading and binding
    protected void gvEmployee_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
        dt.TableName = "EmployeeMaster";
        gvEmployee.DataSource = dt;
        gvEmployee.DataMember = "EmployeeMaster";
    }

    

    // grid update command
    protected void gvEmployee_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_EmpExpAssignment(ref e, "Update");
    }

    // grid delete command for master and detail grid
    protected void gvEmployee_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        try
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                ht.Add("@ID", (int)((GridDataItem)e.Item).GetDataKeyValue("recidd"));
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeExpenseAssignment_detail", ht);
            }
            if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            {
                ht.Add("@exptidd", (int)((GridDataItem)e.Item).GetDataKeyValue("exptidd"));
                ht.Add("@empidd", (int)((GridDataItem)e.Item).GetDataKeyValue("empidd"));
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeExpenseAssignment_recordDetail", ht);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpSubTypeDetail")
            {
                int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");
                if (ID > 0)
                {
                    ht.Add("@ID", ID);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeExpenseSubTypeAssignment_record", ht);
                }
            }
            ShowClientMessage("Employee expense assignment record deleted successfully.", MessageType.Success);
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to delete  employee expense assignment record. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }

    }

    // client side validation function for employee master edit form
    public void ValidateEmployeeMaster(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlExpenseType = (editForm.FindControl("ddlExpenseType") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmployeeMaster('" +
                ddlExpenseType.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmployeeMaster('" +
                ddlExpenseType.ClientID
                + "')");
        }
    }

    // client side validation function for premium type master input form
    public void ValidateExpenseDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlExpenseSubType = (editForm.FindControl("ddlExpenseSubType") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpenseDetail('" +
                ddlExpenseSubType.ClientID 
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpenseDetail('" +
                ddlExpenseSubType.ClientID 
                + "')");
        }
    }

    // form input control settings for insert/udpate
    protected void gvEmployee_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                ValidateEmployeeMaster(e);
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

                    RadComboBox ddlExpenseType = (RadComboBox)editedItem.FindControl("ddlExpenseType");

                    if (ddlExpenseType != null)
                    {
                        Hashtable ht = new Hashtable();
                        ht.Add("@ID", editedItem.GetDataKeyValue("recidd").ToString());
                        DataTable dtEmp = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseTypeAssignment_Records", ht).Tables[0];

                        RadGrid grid = ddlExpenseType.Items[0].FindControl("rGrdExpenseType4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            ddlExpenseType.Text = string.Empty;
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;

                                    foreach (DataRow row in dtEmp.Rows)
                                    {
                                        if (row["exptidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["exptidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlExpenseType.Text))
                                                ddlExpenseType.Text = ddlExpenseType.Text + ",";
                                            ddlExpenseType.Text = ddlExpenseType.Text + row["exptcod"].ToString();
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
            else if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
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

                    RadComboBox ddlExpenseSubType = (RadComboBox)editedItem.FindControl("ddlExpenseSubType");

                    if (ddlExpenseSubType != null)
                    {
                        Hashtable ht = new Hashtable();
                        ht.Add("@exptidd", editedItem.GetDataKeyValue("exptidd").ToString());
                        ht.Add("@empidd", editedItem.GetDataKeyValue("empidd").ToString());
                        DataTable dtEmp = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseSubTypeAssignment_Records", ht).Tables[0];

                        RadGrid grid = ddlExpenseSubType.Items[0].FindControl("rGrdExpenseSubType4DDL") as RadGrid;
                        if (grid != null)
                        {
                            grid.Rebind();
                            ddlExpenseSubType.Text = string.Empty;
                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;

                                    foreach (DataRow row in dtEmp.Rows)
                                    {
                                        if (row["expsubtidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["expsubtidd"].ToString()))
                                        {
                                            if (!string.IsNullOrEmpty(ddlExpenseSubType.Text))
                                                ddlExpenseSubType.Text = ddlExpenseSubType.Text + ",";
                                            ddlExpenseSubType.Text = ddlExpenseSubType.Text + row["expsubtcod"].ToString();
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
            grid.ExportSettings.HideStructureColumns = true;
            grid.ExportSettings.FileName = "noDetailTable";
            grid.ExportSettings.IgnorePaging = true;
            grid.ExportSettings.ExportOnlyData = true;
            grid.ExportSettings.OpenInNewWindow = true;
            grid.MasterTableView.UseAllDataFields = true;
            grid.ExportSettings.Excel.Format = GridExcelExportFormat.Xlsx;
            foreach (GridDataItem item in grid.Items)
            {
                item["ExpandColumn"].Visible = false;
            }
                        
            //have the nested tables render only when the user expands them via the UI, so they are not present in the export output
            grid.MasterTableView.HierarchyLoadMode = GridChildLoadMode.ServerOnDemand;
            grid.MasterTableView.DetailTables[0].HierarchyLoadMode = GridChildLoadMode.ServerOnDemand;
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                grid.MasterTableView.GetColumn("ExpType").Visible = false;
                grid.MasterTableView.GetColumn("defval").Visible = false;
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
                int NofCols = (e.Item.OwnerTableView.Columns.Count)-5;
                Session["_NOfColumns"] = NofCols;

            }

            else if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            {
                e.Item.OwnerTableView.GetColumn("EditExpenseType").Visible = false;
                e.Item.OwnerTableView.GetColumn("DeleteExpenseType").Visible = false;
                e.Item.OwnerTableView.GetColumn("ExpSubType").Visible = false;
                int NofCols = (e.Item.OwnerTableView.Columns.Count) - 3;
                Session["_NOfColumns"] = NofCols;
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpSubTypeDetail")
            {
                e.Item.OwnerTableView.GetColumn("DeleteExpenseSubType").Visible = false;
                int NofCols = (e.Item.OwnerTableView.Columns.Count) - 2;
                Session["_NOfColumns"] = NofCols;
            }
            grid.MasterTableView.ExportToExcel();

            //grid.GridLines = GridLines.Both;
            //grid.BorderStyle = BorderStyle.Solid;
            //grid.BorderWidth = Unit.Pixel(1);
            //grid.ExportSettings.ExportOnlyData = true;
            //grid.ExportSettings.HideStructureColumns = true;
            //grid.MasterTableView.HierarchyLoadMode = GridChildLoadMode.ServerOnDemand;
            //grid.MasterTableView.DetailTables[0].HierarchyLoadMode = GridChildLoadMode.ServerOnDemand;

            //foreach (GridDataItem item in grid.Items)
            //{
            //    item["ExpandColumn"].Visible = false;
            //}

            //if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            //{
            //    grid.MasterTableView.GetColumn("ExpType").Visible = false;
            //    grid.MasterTableView.GetColumn("defval").Visible = false;
            //    grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
            //    grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
            //    grid.MasterTableView.ExportToExcel();
            //}
            //else if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            //{
            //    GridTableHierarchySetEditability(grid.MasterTableView, true);
            //    grid.MasterTableView.ExportToExcel();
            //}
            //else if (e.Item.OwnerTableView.DataMember == "EmpExpSubTypeDetail")
            //{
            //    GridTableHierarchySetEditability(grid.MasterTableView, true);
            //    grid.MasterTableView.ExportToExcel();
            //}
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
                grid.MasterTableView.GetColumn("ExpType").Visible = false;
                grid.MasterTableView.GetColumn("defval").Visible = false;
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpSubTypeDetail")
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
                grid.MasterTableView.GetColumn("ExpType").Visible = false;
                grid.MasterTableView.GetColumn("defval").Visible = false;
                grid.MasterTableView.GetColumn("EditEmployee").Visible = false;
                grid.MasterTableView.GetColumn("DeleteEmployee").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "EmpExpSubTypeDetail")
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

                if (column.UniqueName == "EditExpenseType" || column.UniqueName == "DeleteExpenseType"
                    || column.UniqueName == "ExpSubType" || column.UniqueName == "DeleteExpenseSubType")
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
        Insert_or_Update_EmpExpAssignment(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_EmpExpAssignment(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "EmployeeMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                newValues["@empidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd"));
                newValues["@empcod"] = Convert.ToInt32(editedItem.GetDataKeyValue("empcod"));
                newValues["@empfsn"] = editedItem.GetDataKeyValue("empfsn");
                newValues["@defval"] = (editedItem.FindControl("cbDefVal") as CheckBox).Checked;

                RadComboBox ddlExpenseType = (editedItem.FindControl("ddlExpenseType") as RadComboBox);
                if (ddlExpenseType != null)
                {
                    if (ddlExpenseType.Items.Count > 0)
                    {
                        
                        Hashtable ht = new Hashtable();
                        ht.Add("@ID", editedItem.GetDataKeyValue("recidd").ToString());
                        DataTable dtET = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseTypeAssignment_Records", ht).Tables[0];


                        RadGrid rgExp = (ddlExpenseType.Items[0].FindControl("rGrdExpenseType4DDL") as RadGrid);
                        if (rgExp.SelectedItems.Count > 0)
                        {
                            foreach (GridDataItem dataItem in rgExp.SelectedItems)
                            {
                                bool match = false;
                                for (int i = dtET.Rows.Count - 1; i >= 0; i--)
                                {
                                    DataRow row = dtET.Rows[i];
                                    if (row["exptidd"].ToString() == dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["exptidd"].ToString())
                                    {
                                        match = true;
                                        dtET.Rows.Remove(row);
                                    }
                                }

                                if (match == false)
                                {
                                    newValues["@exptidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["exptidd"].ToString());
                                    newValues["@DBMessage"] = "";
                                    string DBMessage = "";

                                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeExpenseTypeAssignment_Record", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255).ToString();
                                    if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                    {
                                        ShowClientMessage(DBMessage, MessageType.Error);
                                        e.Canceled = true;
                                    }
                                }
                            }

                            for (int i = dtET.Rows.Count - 1; i >= 0; i--)
                            {
                                Hashtable htValues = new Hashtable();
                                DataRow row = dtET.Rows[i];
                                htValues.Add("@exptidd", Convert.ToInt32(row["exptidd"].ToString()));
                                htValues.Add("@empidd", Convert.ToInt32(editedItem.GetDataKeyValue("recidd")));
                                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeExpenseAssignment_recordDetail", htValues);
                                
                            }

                        }
                    }
                }
                ShowClientMessage("Employee expense assignment record saved successfully.", MessageType.Success);
                //gvEmployee.Rebind();
            }


            if (e.Item.OwnerTableView.DataMember == "EmpExpTypeDetail")
            { 
                //Insert new values
                Hashtable newValues = new Hashtable();

                newValues["@empidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("empidd"));
                newValues["@exptidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("exptidd"));
                GridDataItem ParentItem = e.Item.OwnerTableView.ParentItem as GridDataItem;
                newValues["@empcod"] = ParentItem.GetDataKeyValue("empcod");
                newValues["@empfsn"] = ParentItem.GetDataKeyValue("empfsn");

                RadComboBox ddlExpenseSubType = (editedItem.FindControl("ddlExpenseSubType") as RadComboBox);
                if (ddlExpenseSubType != null)
                {
                    if (ddlExpenseSubType.Items.Count > 0)
                    {
                        #region delete old records

                        Hashtable ht = new Hashtable();
                        ht.Add("@empidd", Convert.ToInt32(editedItem.GetDataKeyValue("empidd")));
                        ht.Add("@exptidd", Convert.ToInt32(editedItem.GetDataKeyValue("exptidd")));
                        clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_EmployeeExpenseAssignment_recordDetail", ht);

                        #endregion

                        RadGrid rgEmployee = (ddlExpenseSubType.Items[0].FindControl("rGrdExpenseSubType4DDL") as RadGrid);
                        if (rgEmployee.SelectedItems.Count > 0)
                        {
                            foreach (GridDataItem dataItem in rgEmployee.SelectedItems)
                            {
                                newValues["@expsubtidd"] = Convert.ToInt32(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["expsubtidd"].ToString());
                                newValues["@expsubtcod"] = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["expsubtcod"].ToString();
                                newValues["@DBMessage"] = "";
                                string DBMessage = "";

                                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmployeeExpenseSubTypeAssignment_Record", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255).ToString();
                                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                                {
                                    ShowClientMessage(DBMessage, MessageType.Error);
                                    e.Canceled = true;
                                }
                            }
                        }
                    }
                }
                ShowClientMessage("Employee expense assignment record saved successfully.", MessageType.Success);
                //gvEmployee.Rebind();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to save employee expense assignment record. Reason: " + ex.Message, MessageType.Error);
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
    protected void gvEmployee_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "EmpExpTypeDetail":
                {
                    string id = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", id);

                    dtEmpExpTypeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseTypeAssignment_Records", ht).Tables[0];
                    dtEmpExpTypeDetail.TableName = "EmpExpTypeDetail";
                    e.DetailTableView.DataSource = dtEmpExpTypeDetail;
                    e.DetailTableView.DataMember = "EmpExpTypeDetail";
                    break;
                }
            case "EmpExpSubTypeDetail":
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@exptidd", dataItem.GetDataKeyValue("exptidd").ToString());
                    ht.Add("@empidd", dataItem.GetDataKeyValue("empidd").ToString());

                    dtEmpExpSubTypeDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseSubTypeAssignment_Records", ht).Tables[0];
                    dtEmpExpSubTypeDetail.TableName = "EmpExpSubTypeDetail";
                    e.DetailTableView.DataSource = dtEmpExpSubTypeDetail;
                    e.DetailTableView.DataMember = "EmpExpSubTypeDetail";
                    break;
                }
        }
    }

    // grid header setting for exporting
    protected void gvEmployee_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
        if (exporting)
            ApplyStylesToPDFExport(e.Item);

    }

    private void ApplyStylesToPDFExport(GridItem item)
    {
        if (item is GridHeaderItem)
            foreach (TableCell cell in item.Cells)
            {
                //cell.Style["font-family"] = "Verdana";
                cell.Style["text-align"] = "left";
                cell.Style["font-size"] = "9pt";
                cell.Style["border-size"] = "1px";
                cell.Style["width"] = "200px";
            }
        if (item is GridDataItem)
        {
            item.Style["font-size"] = "10px";
            item.Style["border-size"] = "1px";
            item.Style["background-color"] = item.ItemType == GridItemType.AlternatingItem ? "#DDDDDD" : "#AAAAAA";
        }
    }
   
    protected void rGrdExpenseType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetExpenseTypeRecords", htSearchParams).Tables[0];
    }
    protected void rGrdExpenseSubType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        RadComboBox ddlExpSub = grid.Parent.Parent as RadComboBox;
        if (ddlExpSub != null)
        {
            GridEditFormItem editedItem = ddlExpSub.NamingContainer as GridEditFormItem;
            if (editedItem != null)
            {
                int id = (Int32)editedItem.GetDataKeyValue("exptidd");
                htSearchParams = new Hashtable();
                htSearchParams["@ID"] = id;
                grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseSubType_Records", htSearchParams).Tables[0];
            }
        }
        
    }

    protected void gvEmployee_InfrastructureExporting(object sender, GridInfrastructureExportingEventArgs e)
    {
        Telerik.Web.UI.ExportInfrastructure.Table tbl = e.ExportStructure.Tables[0];
        int width = 595 / Convert.ToInt32(Session["_NOfColumns"].ToString());
        for (int i = 1; i <= Convert.ToInt32(Session["_NOfColumns"].ToString()); i++)
        {
            tbl.Columns[i].Width = width;
            tbl.Columns[i].Style.BorderBottomStyle = BorderStyle.Solid;
            tbl.Columns[i].Style.BorderBottomWidth = 2;
            tbl.Columns[i].Style.BorderBottomColor = System.Drawing.Color.Black;
            tbl.Columns[i].Style.BorderTopStyle = BorderStyle.Solid;
            tbl.Columns[i].Style.BorderTopWidth = 2;
            tbl.Columns[i].Style.BorderTopColor = System.Drawing.Color.Black;
            tbl.Columns[i].Style.BorderLeftStyle = BorderStyle.Solid;
            tbl.Columns[i].Style.BorderLeftWidth = 2;
            tbl.Columns[i].Style.BorderLeftColor = System.Drawing.Color.Black;
            tbl.Columns[i].Style.BorderRightStyle = BorderStyle.Solid;
            tbl.Columns[i].Style.BorderRightWidth = 2;
            tbl.Columns[i].Style.BorderRightColor = System.Drawing.Color.Black;
        }
        
        Telerik.Web.UI.ExportInfrastructure.Row row = e.ExportStructure.Tables[0].Rows[1];
        row.Style.Font.Bold = true;
        row.Style.BorderBottomStyle = BorderStyle.Solid;
        row.Style.BorderBottomWidth = 4;
        row.Style.BorderBottomColor = System.Drawing.Color.Black;
        row.Style.BorderTopStyle = BorderStyle.Solid;
        row.Style.BorderTopWidth = 4;
        row.Style.BorderTopColor = System.Drawing.Color.Black;

        
    }
}