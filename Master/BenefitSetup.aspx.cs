using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_BenefitSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // benefit master grid data loading and binding
    protected void gvBenefit_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_BenefitCode_Records", htSearchParams).Tables[0];
        dt.TableName = "BenefitMaster";
        gvBenefit.DataSource = dt;
        gvBenefit.DataMember = "BenefitMaster";
    }

    // benefit type ddl data loading and binding
    protected void rGrdBenefitType4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.BenefitType, -1, 1).Tables[0];
    }

    // frequency ddl data loading and binding
    protected void rGrdFrequency4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.BenefitFrequency, -1, 1).Tables[0];
    }

    // method ddl data loading and binding
    protected void rGrdMethod4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.BenefitMethod, -1, 1).Tables[0];
    }

    // grid update command
    protected void gvBenefit_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Update");
    }

    // pay code ddl data loading and binding
    protected void rGrdPayCode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // grid delete command
    protected void gvBenefit_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_BenefitRecord", ht);
        }
    }

    // client side validation function for benefit master input form
    public void ValidateBenefit(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtBenefitCode = (editForm.FindControl("txtBenefitCode") as RadTextBox);
        RadTextBox txtDescription = (editForm.FindControl("txtDescription") as RadTextBox);
        RadComboBox ddlBenefitType = (editForm.FindControl("ddlBenefitType") as RadComboBox);
        RadDatePicker dtpStartdate = (editForm.FindControl("dtpStartdate") as RadDatePicker);
        RadDatePicker dtpEnddate = (editForm.FindControl("dtpEnddate") as RadDatePicker);
        RadComboBox ddlMethod = (editForm.FindControl("ddlMethod") as RadComboBox);
        RadComboBox ddlFrequency = (editForm.FindControl("ddlFrequency") as RadComboBox);
        RadNumericTextBox txtMaximumBenefit = (editForm.FindControl("txtMaximumBenefit") as RadNumericTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateBenefit('" +
                txtBenefitCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlBenefitType.ClientID + "','" +
                ddlMethod.ClientID + "','" +
                dtpStartdate.ClientID + "','" +
                dtpEnddate.ClientID + "','" +
                ddlFrequency.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateBenefit('" +
                txtBenefitCode.ClientID + "','" +
                txtDescription.ClientID + "','" +
                ddlBenefitType.ClientID + "','" +
                ddlMethod.ClientID + "','" +
               dtpStartdate.ClientID + "','" +
                dtpEnddate.ClientID + "','" +
                ddlFrequency.ClientID
                + "')");
        }
    }

    // form input control setting for insert/ update
    protected void gvBenefit_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "BenefitMaster")
            {
                ValidateBenefit(e);
                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    #region  item is about to be inserted

                    GridEditableItem insertedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlBenefitType = (RadComboBox)insertedItem.FindControl("ddlBenefitType");
                    RadComboBox ddlMethod = (RadComboBox)insertedItem.FindControl("ddlMethod");
                    RadComboBox ddlFrequency = (RadComboBox)insertedItem.FindControl("ddlFrequency");
                    RadComboBox ddlNewEmoloyeeAnualLeave = (RadComboBox)insertedItem.FindControl("ddlNewEmoloyeeAnualLeave");
                    RadComboBox ddlPaycode = (RadComboBox)insertedItem.FindControl("ddlPaycode");

                    if (ddlBenefitType != null)
                    {
                        RadGrid grid = ddlBenefitType.Items[0].FindControl("rGrdBenefitType4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlFrequency != null)
                    {
                        RadGrid grid = ddlFrequency.Items[0].FindControl("rGrdFrequency4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rGrdMethod4DDL") as RadGrid;
                        grid.Rebind();
                    }
                    #endregion
                }
                else
                {
                    #region item is about to be edited
                    GridEditableItem editedItem = (GridEditableItem)e.Item;

                    RadComboBox ddlBenefitType = (RadComboBox)editedItem.FindControl("ddlBenefitType");
                    HiddenField hfBenefitTypedllID = (HiddenField)editedItem.FindControl("hfBenefitTypedllID");
                    HiddenField hfBenefitTypedllText = (HiddenField)editedItem.FindControl("hfBenefitTypedllText");
                    HiddenField hfBenefitTypedllValue = (HiddenField)editedItem.FindControl("hfBenefitTypedllValue");

                    RadComboBox ddlFrequency = (RadComboBox)editedItem.FindControl("ddlFrequency");
                    HiddenField hfFrequencydllID = (HiddenField)editedItem.FindControl("hfFrequencydllID");
                    HiddenField hfFrequencyddlText = (HiddenField)editedItem.FindControl("hfFrequencyddlText");
                    HiddenField hfFrequencyddlValue = (HiddenField)editedItem.FindControl("hfFrequencyddlValue");

                    RadComboBox ddlMethod = (RadComboBox)editedItem.FindControl("ddlMethod");
                    HiddenField hfMethoddllID = (HiddenField)editedItem.FindControl("hfMethoddllID");
                    HiddenField hfMethodddlText = (HiddenField)editedItem.FindControl("hfMethodddlText");
                    HiddenField hfMethodddlValue = (HiddenField)editedItem.FindControl("hfMethodddlValue");

                    RadComboBox ddlPaycode = (RadComboBox)editedItem.FindControl("ddlPaycode");
                    HiddenField hfddlPaycodeID = (HiddenField)editedItem.FindControl("hfddlPaycodeID");
                    HiddenField hfddlPaycodeText = (HiddenField)editedItem.FindControl("hfddlPaycodeText");

                    HiddenField hfBenefitID = (HiddenField)editedItem.FindControl("hfBenefitID");


                    if (ddlBenefitType != null)
                    {
                        RadGrid grid = ddlBenefitType.Items[0].FindControl("rGrdBenefitType4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfBenefitTypedllID.Value) && !string.IsNullOrEmpty(hfBenefitTypedllText.Value))
                        {
                            ddlBenefitType.Items[0].Value = hfBenefitTypedllID.Value;
                            ddlBenefitType.Items[0].Text = hfBenefitTypedllText.Value;
                            ddlBenefitType.Text = hfBenefitTypedllText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfBenefitTypedllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlFrequency != null)
                    {
                        RadGrid grid = ddlFrequency.Items[0].FindControl("rGrdFrequency4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfFrequencydllID.Value) && !string.IsNullOrEmpty(hfBenefitTypedllText.Value))
                        {
                            ddlFrequency.Items[0].Value = hfFrequencydllID.Value;
                            ddlFrequency.Items[0].Text = hfFrequencyddlText.Value;
                            ddlFrequency.Text = hfFrequencyddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfFrequencydllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (ddlMethod != null)
                    {
                        RadGrid grid = ddlMethod.Items[0].FindControl("rGrdMethod4DDL") as RadGrid;
                        grid.Rebind();

                        if (!string.IsNullOrEmpty(hfMethoddllID.Value) && !string.IsNullOrEmpty(hfMethodddlText.Value))
                        {
                            ddlMethod.Items[0].Value = hfMethoddllID.Value;
                            ddlMethod.Items[0].Text = hfMethodddlText.Value;
                            ddlMethod.Text = hfMethodddlText.Value;

                            foreach (GridItem item in grid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    GridDataItem dataItem = (GridDataItem)item;
                                    if (hfMethoddllID.Value.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                                    {
                                        dataItem.Selected = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if (ddlPaycode != null)
                    {
                        if (hfBenefitID != null)
                        {
                            Hashtable ht_PayCodesfilters = new Hashtable();
                            ht_PayCodesfilters.Add("@ID", Convert.ToInt32(hfBenefitID.Value));
                            DataTable dt_PayCodes = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_BenefitPayCodes", ht_PayCodesfilters).Tables[0];

                            RadGrid grid = ddlPaycode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid;
                            if (grid != null)
                            {
                                grid.Rebind();
                                ddlPaycode.Text = string.Empty;
                                foreach (GridItem item in grid.MasterTableView.Items)
                                {
                                    if (item is GridDataItem)
                                    {
                                        GridDataItem dataItem = (GridDataItem)item;

                                        foreach (DataRow row in dt_PayCodes.Rows)
                                        {
                                            if (row["pcdidd"].ToString().Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                                            {
                                                if (!string.IsNullOrEmpty(ddlPaycode.Text))
                                                    ddlPaycode.Text = ddlPaycode.Text + ",";
                                                ddlPaycode.Text = ddlPaycode.Text + row["paycod"].ToString();
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

    // grid header setting for exporting
    protected void gvBenefit_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

    // clear form fields for insert/update
    // exporting functions
    protected void gvBenefit_ItemCommand(object sender, GridCommandEventArgs e)
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

            grid.MasterTableView.GetColumn("EditBenefit").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBenefit").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditBenefit").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBenefit").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditBenefit").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBenefit").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnBenefitPrint");
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

    // grid insert command
    protected void gvBenefit_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_User(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_User(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;

        //Insert new values
        Hashtable newValues = new Hashtable();

        if (operation == "Update")
        {
            newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
        }

        newValues["@bftcod"] = (editedItem.FindControl("txtBenefitCode") as RadTextBox).Text.Trim();
        newValues["@bftds1"] = (editedItem.FindControl("txtDescription") as RadTextBox).Text;
        newValues["@bftds2"] = (editedItem.FindControl("txtArabicDescription") as RadTextBox).Text;
        newValues["@bfttyp"] = (editedItem.FindControl("ddlBenefitType") as RadComboBox).Items[0].Value.Trim();
        newValues["@bftstr"] = (editedItem.FindControl("dtpStartdate") as RadDatePicker).SelectedDate;
        newValues["@bftend"] = (editedItem.FindControl("dtpEnddate") as RadDatePicker).SelectedDate;
        newValues["@bftmth"] = (editedItem.FindControl("ddlMethod") as RadComboBox).Items[0].Value.Trim();
        newValues["@bftfrq"] = (editedItem.FindControl("ddlFrequency") as RadComboBox).Items[0].Value.Trim();
        newValues["@bftmax"] = string.IsNullOrEmpty((editedItem.FindControl("txtMaximumBenefit") as RadNumericTextBox).Text) ? "0" : (editedItem.FindControl("txtMaximumBenefit") as RadNumericTextBox).Text;
        newValues["@bftact"] = (editedItem.FindControl("chkbxInclude") as CheckBox).Checked;
        newValues["@DBMessage"] = "";

        try
        {
            string DBMessage = "";

            if (operation == "Insert")
            {
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Benefit", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            }
            else if (operation == "Update")
            {
                DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Benefit", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            }

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage(DBMessage, MessageType.Error);
                e.Canceled = true;
            }
            else
            {
            #region Pay Codes

            int benefitId = 0;

            if (operation == "Insert")
            {
                if (!string.IsNullOrEmpty(DBMessage))
                    benefitId = Convert.ToInt32(DBMessage);
            }
            else
            {
                benefitId = (int)editedItem.GetDataKeyValue("recidd");
            }

            RadComboBox ddlPayCode = (editedItem.FindControl("ddlPayCode") as RadComboBox);
            if (ddlPayCode != null)
            {
                if (ddlPayCode.Items.Count > 0)
                {

                    #region delete old records

                    //Delete existing code Values
                    Hashtable deleteValues = new Hashtable();
                    deleteValues["@ID"] = benefitId;
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_BenefitPayCode", deleteValues);

                    #endregion

                    RadGrid rgPayCodes = (ddlPayCode.Items[0].FindControl("rGrdPayCode4DDL") as RadGrid);
                    if (rgPayCodes.SelectedItems.Count > 0)
                    {

                        #region Insert new records

                        foreach (GridDataItem dataItem in rgPayCodes.SelectedItems)
                        {
                            //Insert new valuesd
                            Hashtable newDetailValues = new Hashtable();

                            newDetailValues["@bftidd"] = Convert.ToInt32(benefitId);
                            newDetailValues["@pcdidd"] = Convert.ToInt32(dataItem["recidd"].Text);
                            newDetailValues["@paycod"] = dataItem["paycod"].Text.ToString();

                            newDetailValues["@DBMessage"] = "";

                            DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_BenefitPayCode", newDetailValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                        }

                        #endregion
                    }
                }
            }


            #endregion

            gvBenefit.Rebind();
            ShowClientMessage("Benefit record save successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Benefit: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // displaying client side messages
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

    // get boolean column value for grid
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

}