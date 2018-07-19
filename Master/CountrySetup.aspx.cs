using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_CountrySetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    DataTable dtCity = new DataTable();
    DataTable dtProvince = new DataTable();

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Country Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // country master grid data loading and binding
    protected void gvCountry_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_payroll_getallcountries", htSearchParams).Tables[0];
        dt.TableName = "CountryMaster";
        gvCountry.DataSource = dt;
        gvCountry.DataMember = "CountryMaster";
    }

    // grid update command
    protected void gvCountry_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Country(ref e, "Update");
    }

    // category ddl data loading and binding
    protected void rGrdCategory4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.CountryCategory, -1, 1).Tables[0];
    }

    // groupd ddl data loading and binding
    protected void rGrdGroup4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.CountryGroup, -1, 1).Tables[0];
    }

    // grid delete command
    protected void gvCountry_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Country", ht);
            }
            else if (e.Item.OwnerTableView.DataMember == "City")
            {
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_CountryCity", ht);
            }
            else if (e.Item.OwnerTableView.DataMember == "Province")
            {
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_CountryProvince", ht);
            }
        }
    }

    // client side validtion function for country input form
    public void ValidateCountry(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtctrcod = (editForm.FindControl("txtctrcod") as RadTextBox);
        RadTextBox txtctrnam = (editForm.FindControl("txtctrnam") as RadTextBox);
        RadTextBox txtctrnts = (editForm.FindControl("txtctrnts") as RadTextBox);
        RadComboBox ddlGroup = (RadComboBox)editForm.FindControl("ddlGroup");
        RadComboBox ddlCategory = (RadComboBox)editForm.FindControl("ddlCategory");

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateCountry('" +
                txtctrcod.ClientID + "','" +
                txtctrnam.ClientID + "','" +
                txtctrnts.ClientID + "','" +
                ddlGroup.ClientID + "','" +
                ddlCategory.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateCountry('" +
                txtctrcod.ClientID + "','" +
                txtctrnam.ClientID + "','" +
                txtctrnts.ClientID + "','" +
                ddlGroup.ClientID + "','" +
                ddlCategory.ClientID
                + "')");
        }
    }

    // client side validation function for city input form
    public void ValidateCity(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtctrcty = (editForm.FindControl("txtctrcty") as RadTextBox);
        RadTextBox txtBxctrnam = (editForm.FindControl("txtBxctrnam") as RadTextBox);
        RadTextBox txtBxctrdsc = (editForm.FindControl("txtBxctrdsc") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateCity('" +
                txtctrcty.ClientID + "','" +
                txtBxctrnam.ClientID + "','" +
                txtBxctrdsc.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateCity('" +
                txtctrcty.ClientID + "','" +
                txtBxctrnam.ClientID + "','" +
                txtBxctrdsc.ClientID
                + "')");
        }
    }

    // client side validation function for province input form
    public void ValidateProvince(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtprvcod = (editForm.FindControl("txtprvcod") as RadTextBox);
        RadTextBox txtprvnam = (editForm.FindControl("txtprvnam") as RadTextBox);
        RadTextBox txtprvdsc = (editForm.FindControl("txtprvdsc") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateCity('" +
                txtprvcod.ClientID + "','" +
                txtprvnam.ClientID + "','" +
                txtprvdsc.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateCity('" +
                txtprvcod.ClientID + "','" +
                txtprvnam.ClientID + "','" +
                txtprvdsc.ClientID
                + "')");
        }
    }

    // Setting of input controls for insert/update
    protected void gvCountry_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                ValidateCountry(e);
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

                    RadComboBox ddlGroup = (RadComboBox)editedItem.FindControl("ddlGroup");
                    HiddenField hfGroupdllID = (HiddenField)editedItem.FindControl("hfGroupdllID");
                    HiddenField hfGroupdllText = (HiddenField)editedItem.FindControl("hfGroupdllText");
                    if (ddlGroup != null)
                    {
                        RadGrid grid = ddlGroup.Items[0].FindControl("rGrdGroup4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfGroupdllID.Value) && !string.IsNullOrEmpty(hfGroupdllText.Value))
                        {
                            ddlGroup.Items[0].Value = hfGroupdllID.Value;
                            ddlGroup.Items[0].Text = hfGroupdllText.Value;
                            ddlGroup.Text = hfGroupdllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfGroupdllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlCategory = (RadComboBox)editedItem.FindControl("ddlCategory");
                    HiddenField hfCategorydllID = (HiddenField)editedItem.FindControl("hfCategorydllID");
                    HiddenField hfCategorydllText = (HiddenField)editedItem.FindControl("hfCategorydllText");

                    if (ddlCategory != null)
                    {
                        RadGrid grid = ddlCategory.Items[0].FindControl("rGrdCategory4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfCategorydllID.Value) && !string.IsNullOrEmpty(hfCategorydllText.Value))
                        {
                            ddlCategory.Items[0].Value = hfCategorydllID.Value;
                            ddlCategory.Items[0].Text = hfCategorydllText.Value;
                            ddlCategory.Text = hfCategorydllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfCategorydllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
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
            else if (e.Item.OwnerTableView.DataMember == "City")
            {
                ValidateCity(e);
            }
            else if (e.Item.OwnerTableView.DataMember == "Province")
            {
                ValidateProvince(e);
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

    // clear form input controls for insert/update
    // exporting functions
    protected void gvCountry_ItemCommand(object sender, GridCommandEventArgs e)
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

            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                grid.MasterTableView.GetColumn("EditCountry").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCountry").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "City")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }
            grid.MasterTableView.ExportToExcel();
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

            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                grid.MasterTableView.GetColumn("EditCountry").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCountry").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "City")
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

            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                grid.MasterTableView.GetColumn("EditCountry").Visible = false;
                grid.MasterTableView.GetColumn("DeleteCountry").Visible = false;
            }
            else if (e.Item.OwnerTableView.DataMember == "City")
            {
                GridTableHierarchySetEditability(grid.MasterTableView, true);
            }

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnCountryCityPrint");
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

                if (column.UniqueName == "EditCity" || column.UniqueName == "DeleteCity")
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
    protected void gvCountry_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Country(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Country(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            //Insert new values
            Hashtable newValues = new Hashtable();

            if (e.Item.OwnerTableView.DataMember == "CountryMaster")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@ctrcod"] = (editedItem.FindControl("txtctrcod") as RadTextBox).Text.Trim();
                newValues["@ctrnam"] = (editedItem.FindControl("txtctrnam") as RadTextBox).Text;
                newValues["@ctrsnm"] = (editedItem.FindControl("txtctrsnm") as RadTextBox).Text;
                newValues["@ctrnat"] = (editedItem.FindControl("txtctrnat") as RadTextBox).Text;
                newValues["@ctrnts"] = (editedItem.FindControl("txtctrnts") as RadTextBox).Text;
                newValues["@ctrcat"] = (editedItem.FindControl("ddlCategory") as RadComboBox).Items[0].Value.Trim();
                newValues["@ctrgrp"] = (editedItem.FindControl("ddlGroup") as RadComboBox).Items[0].Value.Trim();
                newValues["@ctramt"] = (editedItem.FindControl("txtctramount") as RadNumericTextBox).Text;
                newValues["@defval"] = (editedItem.FindControl("cbDefVal") as CheckBox).Checked;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Country", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Country", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Country record saved successfully.", MessageType.Success);
                    gvCountry.Rebind();
                }
            }
            else if (e.Item.OwnerTableView.DataMember == "City")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@ctridd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@ctrnam"] = (editedItem.FindControl("txtBxctrnam") as RadTextBox).Text.Trim();
                newValues["@ctrcty"] = (editedItem.FindControl("txtctrcty") as RadTextBox).Text.Trim();
                newValues["@ctrdsc"] = (editedItem.FindControl("txtBxctrdsc") as RadTextBox).Text;
                newValues["@ctyamt"] = (editedItem.FindControl("txtctyamount") as RadNumericTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_CountryCity", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_CountryCity", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                    ShowClientMessage("Country city record saved successfully.", MessageType.Success);
            }
            else if (e.Item.OwnerTableView.DataMember == "Province")
            {
                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                GridDataItem parentItem = (GridDataItem)(e.Item.OwnerTableView.ParentItem);
                if (parentItem != null)
                {
                    newValues["@ctridd"] = Convert.ToInt32(parentItem.OwnerTableView.DataKeyValues[parentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@prvnam"] = (editedItem.FindControl("txtprvnam") as RadTextBox).Text.Trim();
                newValues["@prvcod"] = (editedItem.FindControl("txtprvcod") as RadTextBox).Text.Trim();
                newValues["@prvdsc"] = (editedItem.FindControl("txtprvdsc") as RadTextBox).Text;
                newValues["@defval"] = (editedItem.FindControl("cbdefval") as CheckBox).Checked;

                newValues["@tx1lbl"] = (editedItem.FindControl("txttx1lbl") as RadTextBox).Text.Trim();
                if ((editedItem.FindControl("txttx1val") as RadNumericTextBox).Text != "")
                {
                    newValues["@tx1val"] = (editedItem.FindControl("txttx1val") as RadNumericTextBox).Text;
                }
                newValues["@tx1enb"] = (editedItem.FindControl("cbtx1enb") as CheckBox).Checked;

                newValues["@tx2lbl"] = (editedItem.FindControl("txttx2lbl") as RadTextBox).Text.Trim();
                if ((editedItem.FindControl("txttx2val") as RadNumericTextBox).Text!="")
                {
                newValues["@tx2val"] = (editedItem.FindControl("txttx2val") as RadNumericTextBox).Text;
                }
                newValues["@tx2enb"] = (editedItem.FindControl("cbtx2enb") as CheckBox).Checked;

                newValues["@tx3lbl"] = (editedItem.FindControl("txttx3lbl") as RadTextBox).Text.Trim();
                if ((editedItem.FindControl("txttx3val") as RadNumericTextBox).Text != "")
                {
                    newValues["@tx3val"] = (editedItem.FindControl("txttx3val") as RadNumericTextBox).Text;
                }
                newValues["@tx3enb"] = (editedItem.FindControl("cbtx3enb") as CheckBox).Checked;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_CountryProvince", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_CountryProvince", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                    ShowClientMessage("Country province record saved successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Country. Reason: " + ex.Message, MessageType.Error);
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

    // detail grid data loading and binding
    protected void gvCountry_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "City":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtCity = clsDAL.GetDataSet_Payroll("sp_payroll_GetCountryCities", ht).Tables[0];
                    dtCity.TableName = "City";
                    e.DetailTableView.DataSource = dtCity;
                    e.DetailTableView.DataMember = "City";
                    break;
                }
            case "Province":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);

                    dtProvince = clsDAL.GetDataSet_Payroll("sp_payroll_GetCountryProvinces", ht).Tables[0];
                    dtProvince.TableName = "Province";
                    e.DetailTableView.DataSource = dtProvince;
                    e.DetailTableView.DataMember = "Province";
                    break;
                }
        }


    }

    // get value of boolean grid column
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

    // grid header formating for exporting
    protected void gvCountry_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

}