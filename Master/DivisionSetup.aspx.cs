using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_Division : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    public bool exportingDepartment = false;
    public bool exportingSection = false;
    DataTable dtDepartments = new DataTable();
    DataTable dtSections = new DataTable();

    // base page iniatilization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Division Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // division grid data loading and binding
    protected void gvDivision_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Divisions", htSearchParams).Tables[0];
        dt.TableName = "DivisionMaster";
        gvDivision.DataSource = dt;
        gvDivision.DataMember = "DivisionMaster";
    }

    // grid update command
    protected void gvDivision_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Division(ref e, "Update");
    }

    // grid delete command for all master detail tabels
    protected void gvDivision_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        Hashtable ht = new Hashtable();
        if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("dividd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Division", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "Departments")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("dptidd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Department", ht);
            }
        }
        else if (e.Item.OwnerTableView.DataMember == "Sections")
        {
            int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("secidd");

            if (ID > 0)
            {
                ht.Add("@ID", ID);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Section", ht);
            }
        }

    }

    // client side validation function for division input form
    public void ValidateDivision(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtDivCode = (editForm.FindControl("txtDivCode") as RadTextBox);
        RadTextBox txtdivds1 = (editForm.FindControl("txtdivds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateDivision('" +
                txtDivCode.ClientID + "','" +
                txtdivds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateDivision('" +
                txtDivCode.ClientID + "','" +
                txtdivds1.ClientID
                + "')");
        }
    }

    // client side validation function for department input form
    public void ValidateDepartment(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtdptCode = (editForm.FindControl("txtdptCode") as RadTextBox);
        RadTextBox txtdptds1 = (editForm.FindControl("txtdptds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateDepartment('" +
                txtdptCode.ClientID + "','" +
                txtdptds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateDepartment('" +
                txtdptCode.ClientID + "','" +
                txtdptds1.ClientID
                + "')");
        }
    }

    // client side validation function for section input form
    public void ValidateSection(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtsecCode = (editForm.FindControl("txtsecCode") as RadTextBox);
        RadTextBox txtsecds1 = (editForm.FindControl("txtsecds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateSection('" +
                txtsecCode.ClientID + "','" +
                txtsecds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateSection('" +
                txtsecCode.ClientID + "','" +
                txtsecds1.ClientID
                + "')");
        }
    }

    // form input control settings for insert/update
    protected void gvDivision_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
            {
                ValidateDivision(e);
            }
            else if (e.Item.OwnerTableView.DataMember == "Departments")
            {
                ValidateDepartment(e);
            }
            else if (e.Item.OwnerTableView.DataMember == "Sections")
            {
                ValidateSection(e);
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

    // grid export functions
    protected void gvDivision_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);

        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnDepartmentPrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    string reportName = ddlPrintOptions.Text;
                    String qstring = clsEncryption.EncryptData(reportName);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
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

            if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
            {
                grid.MasterTableView.GetColumn("EditDivision").Visible = false;
                grid.MasterTableView.GetColumn("DeleteDivision").Visible = false;
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "Departments")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
                grid.MasterTableView.ExportToExcel();
            }
            else if (e.Item.OwnerTableView.DataMember == "Sections")
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

            if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
            {
                grid.MasterTableView.GetColumn("EditDivision").Visible = false;
                grid.MasterTableView.GetColumn("DeleteDivision").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Departments")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Sections")
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

            if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
            {
                grid.MasterTableView.GetColumn("EditDivision").Visible = false;
                grid.MasterTableView.GetColumn("DeleteDivision").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "Departments")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            else if (e.Item.OwnerTableView.DataMember == "Sections")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToPdf();
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

                if (column.UniqueName == "EditDepartment" || column.UniqueName == "DeleteDepartment")
                {
                    column.Display = false;
                    column.Visible = false;
                }
                if (column.UniqueName == "EditSection" || column.UniqueName == "DeleteSection")
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

    // function for export formating
    void HideCommandColumns(GridTableView gridTableView)
    {
        foreach (GridNestedViewItem nestedViewItem in gridTableView.GetItems(GridItemType.NestedView))
        {
            if (nestedViewItem.NestedTableViews.Length > 0)
            {
                foreach (GridColumn column in gridTableView.Columns)
                {
                    if (column.UniqueName == "EditDepartment" || column.UniqueName == "DeleteDepartment")
                    {
                        column.Display = false;
                        column.Visible = false;
                    }
                    if (column.UniqueName == "EditSection" || column.UniqueName == "DeleteSection")
                    {
                        column.Display = false;
                        column.Visible = false;
                    }
                }
                HideCommandColumns(nestedViewItem.NestedTableViews[0]);
            }
        }
    }

    // grid insert/update command
    protected void gvDivision_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Division(ref e, "Insert");
    }

    // insert/update function for all master and detail grids
    private void Insert_or_Update_Division(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();
            if (e.Item.OwnerTableView.DataMember == "DivisionMaster")
            {
                if (operation == "Update")
                {
                    newValues["@dividd"] = (int)editedItem.GetDataKeyValue("dividd");
                }
                newValues["@divcod"] = (editedItem.FindControl("txtDivCode") as RadTextBox).Text.Trim();
                newValues["@divds1"] = (editedItem.FindControl("txtdivds1") as RadTextBox).Text;
                newValues["@divdv2"] = (editedItem.FindControl("txtdivdv2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Division", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Division", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Division saved successfully.", MessageType.Success);
                gvDivision.Rebind();
            }
            }
            else if (e.Item.OwnerTableView.DataMember == "Departments")
            {
                if (operation == "Update")
                {
                    newValues["@dptidd"] = (int)editedItem.GetDataKeyValue("dptidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@dividd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["dividd"].ToString());
                }
                newValues["@dptcod"] = (editedItem.FindControl("txtdptCode") as RadTextBox).Text.Trim();
                newValues["@dptds1"] = (editedItem.FindControl("txtdptds1") as RadTextBox).Text;
                newValues["@dptds2"] = (editedItem.FindControl("txtdptdv2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Department", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Department", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Department saved successfully.", MessageType.Success);
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "Sections")
            {
                if (operation == "Update")
                {
                    newValues["@secidd"] = (int)editedItem.GetDataKeyValue("secidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@dptidd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["dptidd"].ToString());
                }
                newValues["@seccod"] = (editedItem.FindControl("txtsecCode") as RadTextBox).Text.Trim();
                newValues["@secds1"] = (editedItem.FindControl("txtsecds1") as RadTextBox).Text;
                newValues["@secds2"] = (editedItem.FindControl("txtsecdv2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Section", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Section", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Section saved successfully.", MessageType.Success);
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Division. Reason: " + ex.Message, MessageType.Error);
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

    // get value for boolean grid column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for boolean grid column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header setting for exporting
    protected void gvDivision_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting)
        {
            if ((e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem) || (e.Item.ItemType == Telerik.Web.UI.GridItemType.CommandItem))
            {
                e.Item.Visible = false;
            }
        }
    }

    // detail tables data loading and binding
    protected void gvDivision_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "Departments":
                {
                    string ID = dataItem.GetDataKeyValue("dividd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@DivisionID", ID);

                    dtDepartments = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Departments", ht).Tables[0];
                    dtDepartments.TableName = "Department";
                    e.DetailTableView.DataSource = dtDepartments;
                    e.DetailTableView.DataMember = "Departments";
                    break;
                }
            case "Sections":
                {
                    string ID = dataItem.GetDataKeyValue("dptidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@DepartmentID", ID);

                    dtSections = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Sections", ht).Tables[0];
                    dtSections.TableName = "Sections";
                    e.DetailTableView.DataSource = dtSections;
                    e.DetailTableView.DataMember = "Sections";
                    break;
                }
        }
    }
}