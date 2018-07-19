using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_AttendanceSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Attendance Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    // display message on client side
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

    // Att grid data loading and binding
    protected void gvAtt_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (ddlEmployee.Text != "" &&
           dtpStartDate.SelectedDate != null &&
           dtpEndDate.SelectedDate != null)
        {
            if (lblCalender.Text != "" && lblShift.Text != "")
            {
                htSearchParams = new Hashtable();
                htSearchParams.Add("@EmpId", ddlEmployee.Items[0].Value);
                htSearchParams.Add("@StartDate", dtpStartDate.SelectedDate);
                if (((DateTime)dtpEndDate.SelectedDate) > ((DateTime)dtpStartDate.SelectedDate).AddDays(30))
                    dtpEndDate.SelectedDate = ((DateTime)dtpStartDate.SelectedDate).AddDays(30);
                htSearchParams.Add("@EndDate", dtpEndDate.SelectedDate);

                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpAtt", htSearchParams).Tables[0];
                dt.TableName = "AttMaster";
                gvAtt.DataSource = dt;
                gvAtt.DataMember = "AttMaster";
            }
            else
            {
                if (lblCalender.Text == "" && lblShift.Text == "")
                    ShowClientMessage(" calendar and shift values not assigned to employee ", MessageType.Error);
                else if (lblCalender.Text == "")
                    ShowClientMessage(" calendar not assigned to employee ", MessageType.Error);
                else if (lblShift.Text == "")
                    ShowClientMessage("shift not assigned to employee ", MessageType.Error);
            }
        }
    }

    // proj ddl data loading and binding
    protected void rGrdProject4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Projects", htSearchParams).Tables[0];
    }

    // grid update command
    protected void gvAtt_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Update");
    }

    // grid delete command
    protected void gvAtt_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);
            int resp = clsDAL.ExecuteNonQuery_payroll("sp_Budget_Delete_EmpAttDetail", ht);

            if (resp == 2000 || resp == 0)  // 2000 for reference error
                ShowClientMessage("Unable to delete Employee Attendance Detail record due to reference error.", MessageType.Error);
            else if (resp == 3000) // 3000 for other db error  
                ShowClientMessage("Unable to delete Employee Attendance Detail record due to db error.", MessageType.Error);
            else
                ShowClientMessage("Employee Attendance Detail record deleted successfully.", MessageType.Success);
        }
    }

    // client side validation function for Att form
    public void ValidateAtt(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadNumericTextBox txtNormalHours = (editForm.FindControl("txtNormalHours") as RadNumericTextBox);
        RadNumericTextBox txtOvertime1 = (editForm.FindControl("txtOvertime1") as RadNumericTextBox);
        RadNumericTextBox txtOvertime2 = (editForm.FindControl("txtOvertime2") as RadNumericTextBox);
        RadNumericTextBox txtTotalOverTime = (editForm.FindControl("txtTotalOverTime") as RadNumericTextBox);
        RadNumericTextBox txtTotalHours = (editForm.FindControl("txtTotalHours") as RadNumericTextBox);
        RadTextBox txtattcmt = (editForm.FindControl("txtattcmt") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateAtt('" +
                txtNormalHours.ClientID + "','" +
                txtOvertime1.ClientID + "','" +
                txtOvertime2.ClientID + "','" +
                txtTotalOverTime.ClientID + "','" +
                txtTotalHours.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateAtt('" +
                txtNormalHours.ClientID + "','" +
                txtOvertime1.ClientID + "','" +
                txtOvertime2.ClientID + "','" +
                txtTotalOverTime.ClientID + "','" +
                txtTotalHours.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
    }

    // client side validation function for Att form
    public void ValidateAttDetail(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadComboBox ddlProject = (editForm.FindControl("ddlProject") as RadComboBox);
        RadNumericTextBox txtNormalHours = (editForm.FindControl("txtNormalHours") as RadNumericTextBox);
        RadNumericTextBox txtOvertime1 = (editForm.FindControl("txtOvertime1") as RadNumericTextBox);
        RadNumericTextBox txtOvertime2 = (editForm.FindControl("txtOvertime2") as RadNumericTextBox);
        RadNumericTextBox txtTotalOverTime = (editForm.FindControl("txtTotalOverTime") as RadNumericTextBox);
        RadNumericTextBox txtTotalHours = (editForm.FindControl("txtTotalHours") as RadNumericTextBox);
        RadTextBox txtattcmt = (editForm.FindControl("txtattcmt") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateAttDetail('" +
                ddlProject.ClientID + "','" +
                txtNormalHours.ClientID + "','" +
                txtOvertime1.ClientID + "','" +
                txtOvertime2.ClientID + "','" +
                txtTotalOverTime.ClientID + "','" +
                txtTotalHours.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateAttDetail('" +
                               ddlProject.ClientID + "','" +

                txtNormalHours.ClientID + "','" +
                txtOvertime1.ClientID + "','" +
                txtOvertime2.ClientID + "','" +
                txtTotalOverTime.ClientID + "','" +
                txtTotalHours.ClientID + "','" +
                txtattcmt.ClientID
                + "')");
        }
    }

    // set form input controls for insert/update
    protected void gvAtt_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                (e.Item as GridEditableItem)["IsWeekend"].Parent.Visible = false;
                (e.Item as GridEditableItem)["IsPublicHoliday"].Parent.Visible = false;
                ValidateAtt(e);
            }
            if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
            {
                ValidateAttDetail(e);

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;
                    
                    GridDataItem parentItem = (GridDataItem) insertedItem.OwnerTableView.ParentItem;
                    if (parentItem != null)
                    {
                       DateTime date = DateTime.Parse( parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["Date"].ToString());
                       int empId = Convert.ToInt32(ddlEmployee.Items[0].Value);
                       htSearchParams = new Hashtable();
                       htSearchParams.Add("@empidd", empId);
                       htSearchParams.Add("@date", date);
                       htSearchParams.Add("@idd", 0);
                       DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpAttPendingNormalHrs", htSearchParams).Tables[0];
                       if (dt.Rows.Count > 0)
                       {
                           decimal pendinghrs = Convert.ToDecimal(dt.Rows[0]["phrs"].ToString());
                           TextBox hfphrs = (TextBox)insertedItem.FindControl("hfphrs");
                           if (hfphrs != null)
                           {
                               hfphrs.Text = pendinghrs.ToString();
                           }

                           decimal pendingot1 = Convert.ToDecimal(dt.Rows[0]["pot1"].ToString());
                           TextBox hfpot1 = (TextBox)insertedItem.FindControl("hfpot1");
                           if (hfpot1 != null)
                           {
                               hfpot1.Text = pendingot1.ToString();
                           }

                           decimal pendingot2 = Convert.ToDecimal(dt.Rows[0]["pot2"].ToString());
                           TextBox hfpot2 = (TextBox)insertedItem.FindControl("hfpot2");
                           if (hfpot2 != null)
                           {
                               hfpot2.Text = pendingot2.ToString();
                           }
                       }
                    }

                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    int recidd = Convert.ToInt32( editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["recidd"].ToString());
                    GridDataItem parentItem = (GridDataItem)editedItem.OwnerTableView.ParentItem;
                    if (parentItem != null)
                    {
                        DateTime date = DateTime.Parse(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["Date"].ToString());
                        int empId = Convert.ToInt32(ddlEmployee.Items[0].Value);
                        htSearchParams = new Hashtable();
                        htSearchParams.Add("@empidd", empId);
                        htSearchParams.Add("@date", date);
                        htSearchParams.Add("@idd", recidd);
                        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpAttPendingNormalHrs", htSearchParams).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            decimal pendinghrs = Convert.ToDecimal(dt.Rows[0]["phrs"].ToString());
                            TextBox hfphrs = (TextBox)editedItem.FindControl("hfphrs");
                            if (hfphrs != null)
                            {
                                hfphrs.Text = pendinghrs.ToString();
                            }

                            decimal pendingot1 = Convert.ToDecimal(dt.Rows[0]["pot1"].ToString());
                            TextBox hfpot1 = (TextBox)editedItem.FindControl("hfpot1");
                            if (hfpot1 != null)
                            {
                                hfpot1.Text = pendingot1.ToString();
                            }

                            decimal pendingot2 = Convert.ToDecimal(dt.Rows[0]["pot2"].ToString());
                            TextBox hfpot2 = (TextBox)editedItem.FindControl("hfpot2");
                            if (hfpot2 != null)
                            {
                                hfpot2.Text = pendingot2.ToString();
                            }
                        }
                    }

                    RadComboBox ddlProject = (RadComboBox)editedItem.FindControl("ddlProject");
                    HiddenField hfprjidd = (HiddenField)editedItem.FindControl("hfprjidd");
                    HiddenField hfprjcod = (HiddenField)editedItem.FindControl("hfprjcod");

                    if (ddlProject != null)
                    {
                        RadGrid grid = ddlProject.Items[0].FindControl("rGrdProject4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfprjidd.Value) && !string.IsNullOrEmpty(hfprjcod.Value))
                        {
                            ddlProject.Items[0].Value = hfprjidd.Value;
                            ddlProject.Items[0].Text = hfprjcod.Value;
                            ddlProject.Text = hfprjcod.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfprjidd.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["prjidd"].ToString()))
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

        // color days
        if (e.Item is GridDataItem)
        {
            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                if (dataItem["IsWeekend"].Text == "1")
                {
                    dataItem.BackColor = System.Drawing.Color.Silver;
                }
                if (dataItem["IsPublicHoliday"].Text == "1")
                {
                    dataItem.BackColor = System.Drawing.Color.GreenYellow;
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
                ht_Reports.Add("@formtypeid", 3103); // Att Setup form type = 3103

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

    // clear grid input form for insert/update
    // exporting functions
    protected void gvAtt_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);

        if (e.CommandName == "UpdateAll")
        {
            try
            {
                //Insert new values
                Hashtable newValues = new Hashtable();
                newValues["@empidd"] = Convert.ToInt32(ddlEmployee.Items[0].Value);
                newValues["@attfdt"] = (DateTime)dtpStartDate.SelectedDate;
                newValues["@atttdt"] = (DateTime)dtpEndDate.SelectedDate;
                newValues["@DBMessage"] = "";

                string DBMessage = "";
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAttNormalHours", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Employee Attendance Normal hours updated successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to update employee attendance normal hours. Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
        }

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

            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
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

            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
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

            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                grid.MasterTableView.GetColumn("EditFiles").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
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

                if (column.UniqueName == "EditFiles" || column.UniqueName == "DeleteFiles")
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

    // export formating functions
    void HideCommandColumns(GridTableView gridTableView)
    {
        foreach (GridNestedViewItem nestedViewItem in gridTableView.GetItems(GridItemType.NestedView))
        {
            if (nestedViewItem.NestedTableViews.Length > 0)
            {
                foreach (GridColumn column in gridTableView.Columns)
                {
                    if (column.UniqueName == "EditAttendanceDetail" || column.UniqueName == "DeleteAttendanceDetail")
                    {
                        column.Display = false;
                        column.Visible = false;
                    }

                }
                HideCommandColumns(nestedViewItem.NestedTableViews[0]);
            }
        }

    }

    // grid insert command
    protected void gvAtt_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Att(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "AttMaster")
            {
                #region Att Master

                newValues["@empidd"] = Convert.ToInt32(ddlEmployee.Items[0].Value);
                if (operation == "Update")
                {
                    newValues["@attdat"] = DateTime.Parse(editedItem.GetDataKeyValue("Date").ToString());
                }
                newValues["@atthrs"] = (editedItem.FindControl("txtNormalHours") as RadNumericTextBox).Text;
                newValues["@attcmt"] = (editedItem.FindControl("txtattcmt") as RadTextBox).Text;
                newValues["@attot1"] = (editedItem.FindControl("txtOvertime1") as RadNumericTextBox).Text;
                newValues["@attot2"] = (editedItem.FindControl("txtOvertime2") as RadNumericTextBox).Text;
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                newValues["@DBMessage"] = "";
                string DBMessage = "";
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmpAtt", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAtt", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Employee Attendance saved successfully.", MessageType.Success);
                    gvAtt.Rebind();
                }

                #endregion
            }
            else if (e.Item.OwnerTableView.DataMember == "AttendanceDetail")
            {
                #region Attendance Detail

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@attdat"] = DateTime.Parse(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["Date"].ToString());
                }
                newValues["@empidd"] = Convert.ToInt32(ddlEmployee.Items[0].Value);
                newValues["@prjidd"] = (editedItem.FindControl("ddlProject") as RadComboBox).Items[0].Value;
                newValues["@prjcod"] = (editedItem.FindControl("ddlProject") as RadComboBox).Text;
                newValues["@atthrs"] = (editedItem.FindControl("txtNormalHours") as RadNumericTextBox).Text;
                newValues["@attcmt"] = (editedItem.FindControl("txtattcmt") as RadTextBox).Text;
                newValues["@attot1"] = (editedItem.FindControl("txtOvertime1") as RadNumericTextBox).Text;
                newValues["@attot2"] = (editedItem.FindControl("txtOvertime2") as RadNumericTextBox).Text;
                newValues["@atttyp"] = 1;
                newValues["@atttcd"] = "Daily";
                newValues["@DBMessage"] = "";
                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_EmpAttDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAttDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }

                #endregion

                ShowClientMessage("Employee Attendance detail saved successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employee Attendance . Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // detail grid data binding
    protected void gvAtt_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "AttendanceDetail":
                {
                    DateTime date = DateTime.Parse(dataItem.GetDataKeyValue("Date").ToString());
                    Hashtable ht = new Hashtable();
                    ht.Add("@EmpId", Convert.ToInt32(ddlEmployee.Items[0].Value));
                    ht.Add("@Date", date);
                    DataTable dtAttDetail = new DataTable();
                    dtAttDetail = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpAttDetail", ht).Tables[0];
                    dtAttDetail.TableName = "AttendanceDetail";
                    e.DetailTableView.DataSource = dtAttDetail;
                    e.DetailTableView.DataMember = "AttendanceDetail";
                    break;
                }
        }
    }

    // grid header formating for exporting
    protected void gvAtt_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

    // employee ddl data binding event
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }

    // hidden button click
    protected void btnHidden_Click(object sender, EventArgs e)
    {
        htSearchParams = new Hashtable();
        htSearchParams.Add("@EmpId", ddlEmployee.SelectedValue);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpDetail", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Calidd"] != null)
                if (dt.Rows[0]["Calidd"] != "")
                    lblCalender.Text = dt.Rows[0]["Calidd"].ToString();
                else
                    lblCalender.Text = "";
            else
                lblCalender.Text = "";
        }
    }

    // search button click
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (lblCalender.Text == "" || lblShift.Text == "")
        {
            if (lblCalender.Text == "" && lblShift.Text == "")
                ShowClientMessage(" calendar and shift values not assigned to employee ", MessageType.Error);
            else if (lblCalender.Text == "")
                ShowClientMessage(" calendar not assigned to employee ", MessageType.Error);
            else if (lblShift.Text == "")
                ShowClientMessage("shift not assigned to employee ", MessageType.Error);
        }
        else
        {
            gvAtt.Rebind();
        }
    }

    // ddl employee selected index change event
    protected void ddlEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        htSearchParams = new Hashtable();
        htSearchParams.Add("@EmpId", ddlEmployee.Items[0].Value);
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpDetail", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Calidd"] != null && dt.Rows[0]["shfcod"] != null)
                if (dt.Rows[0]["Calidd"] != "" && dt.Rows[0]["shfcod"] != "")
                {
                    lblCalender.Text = dt.Rows[0]["Calidd"].ToString();
                    lblShift.Text = dt.Rows[0]["shfcod"].ToString();
                }
                else
                {
                    lblCalender.Text = "";
                    lblShift.Text = "";
                }
            else
            {
                lblCalender.Text = "";
                lblShift.Text = "";
            }
            gvAtt.Rebind();
        }
    }
}