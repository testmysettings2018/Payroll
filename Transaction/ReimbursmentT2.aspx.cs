using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;
using System.Data.SqlClient;
using System.Configuration;


public partial class ReimbursmentT2 : BasePage
{

    #region Startup
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    int formType = 3132;
    
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "ReimbursementT2 Form";
        base.Page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ApprovalPanel.Visible = false;
            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
            ht_nextnumber.Add("@TRX_ID", null);
            //sp_User_Increment_Seq_Number
            string trxNo = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            if (trxNo != null)
            {
                Session["_ReimbCurrtrxNumber"] = trxNo;
            }
            Session["_ReimbTab1Function"] = "New";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "pageLoad", "pageLoad();", true);
            
        }

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        
    }

    #endregion

    #region  Misc. Functions

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

    protected string getImagePathForTrue(string status)
    {
        if (status == "In Process")
            return "~/Images/16x16_process.png";
        if (status == "Sucessfull")
            return "~/Images/16x16_approved.png";
        if (status == "Rejected")
            return "~/Images/16x16_rejected.png";
        else
            return "";
    }

    protected string GetUserFullName(int EmployeeUserID, string EmployeeFullName)
    {
        if (EmployeeUserID == int.Parse(Session["_UserID"].ToString()))
            return "Self";
        else
            return EmployeeFullName;
    }

    protected bool isCompletedVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Completed:
                return true;

            default:
                return false;
        }
    }

    protected bool isEditVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }

        }
        else
            return false;
    }

    protected bool isInProcessVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRecallVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                case clsCommon.RequestStatus.Approved:
                    return true;

                case clsCommon.RequestStatus.Canceled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRejectedVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Rejected:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isSubmitVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {

            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

     

    public string GetDate()
    {
        return System.DateTime.Now.ToString();
    }

    protected void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        refreshGrids();
    }

    public void refreshGrids()
    {
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }

    #endregion

    #region Tab1 - New Requests

    // get value of grid boolean column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    protected void rGrdEmployeeOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }

    protected void ddlEmployeeOuter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlProjectOuter.Items[0].Value = "";
        ddlProjectOuter.Items[0].Text = "";
        ddlProjectOuter.SelectedValue = "";
        RadGrid pgrid = ddlProjectOuter.Items[0].FindControl("rGrdProjectOuter4DDL") as RadGrid;
        pgrid.Rebind();
        ddlExpenseTypeOuter.Items[0].Value = "";
        ddlExpenseTypeOuter.Items[0].Text = "";
        ddlExpenseTypeOuter.SelectedValue = "";
        RadGrid expgrid = ddlExpenseTypeOuter.Items[0].FindControl("rGrdExpenseTypeOuter4DDL") as RadGrid;
        expgrid.Rebind();
    }
    protected void rGrdProjectOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!String.IsNullOrEmpty(ddlEmployeeOuter.Items[0].Value))
        {
            htSearchParams = new Hashtable();
            RadGrid grid = sender as RadGrid;
            htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployeeOuter.Items[0].Value);
            grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ProjectEmployeeAssignment", htSearchParams).Tables[0];

        }
    }

    protected void rGrdExpenseTypeOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!String.IsNullOrEmpty(ddlEmployeeOuter.Items[0].Value))
        {
            htSearchParams = new Hashtable();
            RadGrid grid = sender as RadGrid;
            htSearchParams["@ID"] = Convert.ToInt32(ddlEmployeeOuter.Items[0].Value);
            grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseTypeAssignment_Records", htSearchParams).Tables[0];

        }
    }

    protected void ddlExpenseTypeOuter_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlExpSubTypeOuter.Items[0].Value = "";
        ddlExpSubTypeOuter.Items[0].Text = "";
        ddlExpSubTypeOuter.SelectedValue = "";
        RadGrid grid = ddlExpSubTypeOuter.Items[0].FindControl("rGrdExpSubTypeOuter4DDL") as RadGrid;
        grid.Rebind();
        
    }

    protected void rGrdExpSubTypeOuter4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!String.IsNullOrEmpty(ddlExpenseTypeOuter.Items[0].Value) && !String.IsNullOrEmpty(ddlEmployeeOuter.Items[0].Value))
        {
            htSearchParams = new Hashtable();
            RadGrid grid = sender as RadGrid;
            htSearchParams["@exptidd"] = Convert.ToInt32(ddlExpenseTypeOuter.Items[0].Value);
            htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployeeOuter.Items[0].Value);
            grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseSubTypeAssignment_Records", htSearchParams).Tables[0];

        }
    }


    // Att grid data loading and binding
    protected void gvReimbursment_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        htSearchParams["@prmtrx"] =  Session["_ReimbCurrtrxNumber"];
        DataTable dt = clsDAL.GetDataSet_Payroll("[sp_Payroll_Get_EmpReimbT2]", htSearchParams).Tables[0];
        dt.TableName = "ReimbMaster";
        gvReimbursment.DataSource = dt;
        gvReimbursment.DataMember = "ReimbMaster";

    }

    protected void gvReimbursment_PreRender(object sender, EventArgs e)
    {
        
    }


    // proj ddl data loading and binding
    protected void rGrdProject4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid prjgrid = sender as RadGrid;
        RadComboBox ddlProject = prjgrid.Parent.Parent as RadComboBox;
        if (ddlProject != null)
        {
            RadComboBox ddlEmployee = ddlProject.Parent.FindControl("ddlEmployee") as RadComboBox;
            if (ddlEmployee != null)
            {
                if (!String.IsNullOrEmpty(ddlEmployee.Items[0].Value))
                {
                    htSearchParams = new Hashtable();
                    htSearchParams["@employeeIDD"] = Convert.ToInt32(ddlEmployee.Items[0].Value);
                    prjgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ProjectEmployeeAssignment", htSearchParams).Tables[0];
                }
            }
        }
        
    }

    // grid update command
    protected void gvReimbursment_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Update");
    }

    // grid delete command
    protected void gvReimbursment_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        GridDataItem item = (GridDataItem)e.Item;
        
        if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_delete_ReimbT2mst", newValues);
            gvReimbursment.Rebind();
        }
        if (e.Item.OwnerTableView.DataMember == "ExpenseType")
        {
            Hashtable newValues = new Hashtable();
            newValues["@recidd"] = Int32.Parse(item.GetDataKeyValue("recidd").ToString());
            newValues["@userid"] = Session["_UserID"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_Delete_ReimbDetail", newValues);
        }
        if (e.Item.OwnerTableView.DataMember == "Attachments")
        {
            Hashtable newValues = new Hashtable();
            newValues["@Id"] = Int32.Parse(item.GetDataKeyValue("idd").ToString());
            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Attachment", newValues);
        }
        
    }

    // client side validation function for Reimbursment form
    public void ValidateReimb(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("btnInsert");

        RadComboBox ddlEmployee = (editForm.FindControl("ddlEmployee") as RadComboBox);
        RadComboBox ddlEmpPos = (editForm.FindControl("ddlEmpPos") as RadComboBox);
        RadComboBox ddlProject = (editForm.FindControl("ddlProject") as RadComboBox);
        RadDatePicker dtpDate = (editForm.FindControl("dtpDate") as RadDatePicker);
        //RadTextBox txtreimcmt = (editForm.FindControl("txtreimcmt") as RadTextBox);
        TextBox txtreimcmt = (editForm.FindControl("txtreimcmt") as TextBox);
        RadComboBox ddlCountry = (editForm.FindControl("ddlCountry") as RadComboBox);
        RadComboBox ddlProvince = (editForm.FindControl("ddlProvince") as RadComboBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateReimb('" +
                ddlEmployee.ClientID + "','" +
                ddlEmpPos.ClientID + "','" +
                ddlProject.ClientID + "','" +
                dtpDate.ClientID + "','" +
                ddlCountry.ClientID + "','" +
                ddlProvince.ClientID + "','" +
                txtreimcmt.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateReimb('" +
                ddlEmployee.ClientID + "','" +
                ddlEmpPos.ClientID + "','" +
                ddlProject.ClientID + "','" +
                dtpDate.ClientID + "','" +
                ddlCountry.ClientID + "','" +
                ddlProvince.ClientID + "','" +
                txtreimcmt.ClientID
                + "')");
        }
    }

    // client side validation function for Expense Type detail form
    public void ValidateExpenseType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("btnInsert");

        RadComboBox ddlExpenseType = (editForm.FindControl("ddlExpenseType") as RadComboBox);
        RadComboBox ddlExpSubType = (editForm.FindControl("ddlExpSubType") as RadComboBox);
        RadNumericTextBox txtExpenseValue = (editForm.FindControl("txtExpenseValue") as RadNumericTextBox);
        RadNumericTextBox txtTotalValue = (editForm.FindControl("txtTotalValue") as RadNumericTextBox);
        
        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateExpenseType('" +
                ddlExpenseType.ClientID + "','" +
                ddlExpSubType.ClientID + "','" +
                txtExpenseValue.ClientID + "','" +
                txtTotalValue.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateExpenseType('" +
                ddlExpenseType.ClientID + "','" +
                ddlExpSubType.ClientID + "','" +
                txtExpenseValue.ClientID + "','" +
                txtTotalValue.ClientID
                + "')");
        }
    }

    // set form input controls for insert/update
    protected void gvReimbursment_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadGrid grid = sender as RadGrid;

        Hashtable htt = new Hashtable();
        DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ReimbT2Configs", htt).Tables[0];
        if (dtConfigs.Rows.Count > 0)
        {
            if (dtConfigs.Rows[0]["isprjvis"].ToString() != "True")
            {
                grid.MasterTableView.GetColumn("prjcod").Visible = false;
            }
        }
        
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            // insert
            
            if (e.Item is GridEditFormInsertItem && e.Item.OwnerTableView.IsItemInserted)
            //if the grid is in insert mode
            {
                GridEditFormInsertItem editItem = (GridEditFormInsertItem)e.Item;
                
                //Hashtable htt = new Hashtable();
                //DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ReimbT2Configs", htt).Tables[0];
                if (dtConfigs.Rows.Count > 0)
                {
                    if (dtConfigs.Rows[0]["isprjvis"].ToString() != "True")
                    {
                        RadComboBox ddlProject = editItem.FindControl("ddlProject") as RadComboBox;
                        if (ddlProject != null)
                        {
                            (editItem.FindControl("ddlProject") as RadComboBox).Visible = false;
                            (editItem.FindControl("lblProject") as Label).Visible = false;
                            (editItem.FindControl("rfvddlProject") as RequiredFieldValidator).Enabled = false;
                        }
                    }
                    if (dtConfigs.Rows[0]["isvndrvis"].ToString() != "True")
                    {
                        TextBox txtvendor = editItem.FindControl("txtvendor") as TextBox;
                        if (txtvendor != null)
                        {
                            (editItem.FindControl("txtvendor") as TextBox).Visible = false;
                            (editItem.FindControl("lblVendor") as Label).Visible = false;
                        }
                    }

                }
                
                if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
                {
                    if (grid.MasterTableView.Items.Count > 0)
                    {
                        RadDatePicker datepicker = (RadDatePicker)editItem.FindControl("dtpDate");
                        if (datepicker != null)
                        {
                            datepicker.SelectedDate = Convert.ToDateTime(grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("Date").ToString());
                        }
                    }
                    else
                    {
                        RadDatePicker datepicker = (RadDatePicker)editItem.FindControl("dtpDate");
                        if (datepicker != null)
                        {
                            datepicker.SelectedDate = DateTime.Now;
                        }
                    }

                    if (ddlEmployeeOuter.Items[0].Value != null && rcbEmployeeddl.Checked == true)
                    {
                        RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                        if (ddlemp != null)
                        {
                            string value = ddlEmployeeOuter.Items[0].Value.ToString();
                            string text = ddlEmployeeOuter.Items[0].Text.ToString();
                            ddlemp.Items[0].Value = value;
                            ddlemp.Items[0].Text = text;
                            ddlemp.SelectedValue = value;
                            if (!string.IsNullOrEmpty(text))
                            {
                                htSearchParams["@employeeCode"] = text;
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                if (dt.Rows.Count > 0)
                                {
                                    DataRow row = dt.Rows[0];
                                    string id = row[0].ToString();
                                    string code = row[1].ToString();
                                    RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                    if (ddlPos != null)
                                    {
                                        ddlPos.Items[0].Value = id;
                                        ddlPos.Items[0].Text = code;
                                        ddlPos.SelectedValue = id;
                                    }
                                }
                            }
                        }

                    }
                    else if (grid.MasterTableView.Items.Count > 0)
                    {
                        RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                        if (ddlemp != null)
                        {
                            string value = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("empidd").ToString();
                            string text = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("empcod").ToString();
                            ddlemp.Items[0].Value = value;
                            ddlemp.Items[0].Text = text;
                            ddlemp.SelectedValue = value;
                            if (!string.IsNullOrEmpty(text))
                            {
                                htSearchParams["@employeeCode"] = text;
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                if (dt.Rows.Count > 0)
                                {
                                    DataRow row = dt.Rows[0];
                                    string id = row[0].ToString();
                                    string code = row[1].ToString();
                                    RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                    if (ddlPos != null)
                                    {
                                        ddlPos.Items[0].Value = id;
                                        ddlPos.Items[0].Text = code;
                                        ddlPos.SelectedValue = id;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        RadComboBox ddlemp = (RadComboBox)editItem.FindControl("ddlEmployee");
                        if (ddlemp != null)
                        {
                            if (!string.IsNullOrEmpty(Session["_UserID"].ToString()))
                            {
                                string id = Session["_UserID"].ToString();
                                htSearchParams = new Hashtable();
                                htSearchParams["@empid"] = id;
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpCodeByUserId", htSearchParams).Tables[0];
                                if (dt.Rows.Count > 0)
                                {
                                    DataRow row = dt.Rows[0];
                                    string idd = row[0].ToString();
                                    string code = row[1].ToString();

                                    ddlemp.Items[0].Value = idd;
                                    ddlemp.Items[0].Text = code;
                                    ddlemp.SelectedValue = idd;
                                    htSearchParams = new Hashtable();
                                    htSearchParams["@employeeCode"] = code;
                                    DataTable dt1 = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
                                    if (dt1.Rows.Count > 0)
                                    {
                                        DataRow row1 = dt1.Rows[0];
                                        string Posid = row1[0].ToString();
                                        string Poscod = row1[1].ToString();
                                        RadComboBox ddlPos = (RadComboBox)editItem.FindControl("ddlEmpPos");
                                        if (ddlPos != null)
                                        {
                                            ddlPos.Items[0].Value = Posid;
                                            ddlPos.Items[0].Text = Poscod;
                                            ddlPos.SelectedValue = Posid;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    string prjid = "";
                    string prjcod = "";
                    if (ddlProjectOuter.Items[0].Value != null && rcbProject.Checked == true)
                    {
                        prjid = ddlProjectOuter.Items[0].Value.ToString();
                        prjcod = ddlProjectOuter.Items[0].Text.ToString();
                    }
                    else if (grid.MasterTableView.Items.Count > 0)
                    {
                        prjid = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("prjidd").ToString();
                        prjcod = grid.Items[grid.MasterTableView.Items.Count - 1].GetDataKeyValue("prjcod").ToString();
                    }
                    RadComboBox ddlProj = (RadComboBox)e.Item.FindControl("ddlProject");
                    if (ddlProj != null)
                    {
                        RadGrid gridproj = (RadGrid)ddlProj.Items[0].FindControl("rGrdProject4DDL");
                        if (gridproj != null)
                        {
                            gridproj.Rebind();
                            foreach (GridItem item in gridproj.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    if (prjid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString()))
                                    {
                                        ddlProj.Items[0].Value = prjid;
                                        ddlProj.Items[0].Text = prjcod;
                                        ddlProj.SelectedValue = prjid;
                                        break;
                                    }
                                    else if (item.ItemIndex == 0)
                                    {
                                        ddlProj.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                                        ddlProj.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjcod"].ToString();
                                        ddlProj.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                                    }
                                }
                            }
                        }
                    }


                    RadComboBox ddlCountry = (editItem.FindControl("ddlCountry") as RadComboBox);
                    if (ddlCountry != null)
                    {
                        RadGrid ctrGrid = ddlCountry.Items[0].FindControl("rGrdCountry4DDL") as RadGrid;
                        if (ctrGrid != null)
                        {
                            string id = "True";
                            foreach (GridItem item in ctrGrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["defval"].ToString()))
                                    {
                                        ddlCountry.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        ddlCountry.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["ctrcod"].ToString();
                                        ddlCountry.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        break;
                                    }
                                    else if (item.ItemIndex == 0)
                                    {
                                        ddlCountry.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        ddlCountry.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["ctrcod"].ToString();
                                        ddlCountry.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                    }
                                }
                            }
                        }
                    }

                    RadComboBox ddlProvince = (editItem.FindControl("ddlProvince") as RadComboBox);
                    if (ddlProvince != null)
                    {
                        RadGrid PrvGrid = ddlProvince.Items[0].FindControl("rGrdProvince4DDL") as RadGrid;
                        if (PrvGrid != null)
                        {
                            PrvGrid.Rebind();

                            string id = "True";
                            foreach (GridItem item in PrvGrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["defval"].ToString()))
                                    {
                                        ddlProvince.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        ddlProvince.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prvcod"].ToString();
                                        ddlProvince.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        break;
                                    }
                                    else if (item.ItemIndex == 0)
                                    {
                                        ddlProvince.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                        ddlProvince.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prvcod"].ToString();
                                        ddlProvince.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                                    }
                                }
                            }
                        }
                    }

                }

                if (e.Item.OwnerTableView.DataMember == "ExpenseType")
                {
                    ValidateExpenseType(e);

                    RadNumericTextBox txtExpenseValue = (RadNumericTextBox)editItem.FindControl("txtExpenseValue");
                    if (txtExpenseValue != null)
                    {
                        txtExpenseValue.Text = "0";
                    }

                    Label lbltx1 = (Label)editItem.FindControl("lbltx1");
                    RadNumericTextBox txttx1 = (RadNumericTextBox)editItem.FindControl("txttx1");
                    Label lbltx2 = (Label)editItem.FindControl("lbltx2");
                    RadNumericTextBox txttx2 = (RadNumericTextBox)editItem.FindControl("txttx2");
                    Label lbltx3 = (Label)editItem.FindControl("lbltx3");
                    RadNumericTextBox txttx3 = (RadNumericTextBox)editItem.FindControl("txttx3");

                    GridDataItem ParentItem = editItem.OwnerTableView.ParentItem;
                    
                        Hashtable ht= new Hashtable();
                        ht["@Id"] = Convert.ToInt32(ParentItem.GetDataKeyValue("prvidd").ToString());
                    DataTable dt1 = clsDAL.GetDataSet_Payroll("sp_payroll_GetProvinceDetailById", ht).Tables[0];
                    if (dt1 != null)
                    {
                        if (dt1.Rows[0]["tx1enb"].ToString() == "True")
                        {
                            lbltx1.Visible = true;
                            lbltx1.Text = dt1.Rows[0]["tx1lbl"].ToString();
                            txttx1.Visible = true;
                            txttx1.Text = dt1.Rows[0]["tax1val"].ToString();
                        }
                        else 
                        {
                            lbltx1.Visible = false;
                            txttx1.Visible = false;
                        }
                        if (dt1.Rows[0]["tx2enb"].ToString() == "True")
                        { 
                            lbltx2.Visible = true;
                            lbltx2.Text = dt1.Rows[0]["tx2lbl"].ToString();
                            txttx2.Visible = true;
                            txttx2.Text = dt1.Rows[0]["tax2val"].ToString();
                        }
                        else
                        {
                            lbltx2.Visible = false;
                            txttx2.Visible = false;
                        }
                        if (dt1.Rows[0]["tx3enb"].ToString() == "True")
                            {
                            lbltx3.Visible = true;
                            lbltx3.Text = dt1.Rows[0]["tx3lbl"].ToString();
                            txttx3.Visible = true;
                            txttx3.Text = dt1.Rows[0]["tax3val"].ToString();
                            }
                        else
                        {
                            lbltx3.Visible = false;
                            txttx3.Visible = false;
                        }
                    }

                    string expid = "";
                    string expcode = "";
                    if (ddlExpenseTypeOuter.Items[0].Value != null && rcbExpenseType.Checked == true)
                    {
                        expid = ddlExpenseTypeOuter.Items[0].Value.ToString();
                        expcode = ddlExpenseTypeOuter.Items[0].Text.ToString();
                    }
                    else if (e.Item.OwnerTableView.Items.Count > 0)
                    {
                        expid = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("exptidd").ToString();
                        expcode = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("exptcod").ToString();
                    }
                    RadComboBox ddlExpenseType = (RadComboBox)editItem.FindControl("ddlExpenseType");
                    if (ddlExpenseType != null)
                    {
                        RadGrid expgrid = ddlExpenseType.Items[0].FindControl("rGrdExpenseType4DDL") as RadGrid;
                        if (expgrid != null)
                        {
                            foreach (GridItem item in expgrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    if (expid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["exptidd"].ToString()))
                                    {
                                        ddlExpenseType.Items[0].Value = expid;
                                        ddlExpenseType.Items[0].Text = expcode;
                                        ddlExpenseType.SelectedValue = expid;
                                        break;
                                    }
                                    else if (item.ItemIndex == 0)
                                    {
                                        ddlExpenseType.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["exptidd"].ToString();
                                        ddlExpenseType.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["exptcod"].ToString();
                                        ddlExpenseType.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["exptidd"].ToString();
                                    }
                                }
                            }
                        }
                    }

                    string expsid = "";
                    string expscode = "";

                    if (ddlExpSubTypeOuter.Items[0].Value != null && ddlExpSubTypeOuter.Items[0].Value != "" && rcbExpSubType.Checked == true)
                    {
                        expsid = ddlExpSubTypeOuter.Items[0].Value.ToString();
                        expscode = ddlExpSubTypeOuter.Items[0].Text.ToString();
                    }
                    else if (e.Item.OwnerTableView.Items.Count > 0)
                    {
                        expsid = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("expsubtidd").ToString();
                        expscode = e.Item.OwnerTableView.Items[e.Item.OwnerTableView.Items.Count - 1].GetDataKeyValue("expsubtcod").ToString();
                    }

                    Label lblExpSubType = editItem.FindControl("lblExpSubType") as Label;
                    RequiredFieldValidator RFVExpSubType = editItem.FindControl("RFVExpSubType") as RequiredFieldValidator;
                    RadComboBox ddlExpSubType = (RadComboBox)editItem.FindControl("ddlExpSubType");
                    if (ddlExpSubType != null)
                    {
                        RadGrid expsubgrid = ddlExpSubType.Items[0].FindControl("rGrdExpSubType4DDL") as RadGrid;
                        if (expsubgrid != null)
                        {
                            expsubgrid.Rebind();
                            if (expsubgrid.Items.Count > 0)
                            {
                            foreach (GridItem item in expsubgrid.MasterTableView.Items)
                            {
                                if (item is GridDataItem)
                                {
                                    if (expsid.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["expsubtidd"].ToString()))
                                    {
                                        ddlExpSubType.Items[0].Value = expsid;
                                        ddlExpSubType.Items[0].Text = expscode;
                                        ddlExpSubType.SelectedValue = expsid;
                                        break;
                                    }
                                    else if (item.ItemIndex == 0)
                                    {
                                        ddlExpSubType.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["expsubtidd"].ToString();
                                        ddlExpSubType.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["expsubtcod"].ToString();
                                        ddlExpSubType.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["expsubtidd"].ToString();
                                    }
                                }
                            }

                                int id = Convert.ToInt32(ddlExpSubType.Items[0].Value.ToString());
                                htSearchParams = new Hashtable();
                                htSearchParams["@expsubtidd"] = id;
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpSubTypeDetailById", htSearchParams).Tables[0];
                                if (dt.Rows.Count > 0)
                                {
                                    DataRow row = dt.Rows[0];
                                    string measurmenttcod = row["measurmenttcod"].ToString();
                                    if (!string.IsNullOrEmpty(measurmenttcod))
                                    {
                                        Label lblExpenseValue = editItem.FindControl("lblExpenseValue") as Label;
                                        Label lblRate = editItem.FindControl("lblRate") as Label;
                                        RadNumericTextBox txtRate = editItem.FindControl("txtRate") as RadNumericTextBox;
                                        Label lblSubTotal = editItem.FindControl("lblSubTotal") as Label;
                                        RadNumericTextBox txtSubTotal = editItem.FindControl("txtSubTotal") as RadNumericTextBox;

                                        if (measurmenttcod.ToLower() == "money")
                                        {
                                            lblExpenseValue.Text = "Amount:";
                                            lblRate.Visible = false;
                                            txtRate.Visible = false;
                                            lblSubTotal.Visible = false;
                                            txtSubTotal.Visible = false;
                                        }
                                        else
                                        {
                                            lblExpenseValue.Text = row["unittype"].ToString();
                                            lblRate.Visible = true;
                                            txtRate.Visible = true;
                                            txtRate.Text = row["unitval"].ToString();
                                            lblSubTotal.Visible = true;
                                            txtSubTotal.Visible = true;
                                        }
                                    }

                                }
                            }
                            else 
                            {

                                lblExpSubType.Visible = false;
                                ddlExpSubType.Visible = false;
                                RFVExpSubType.Enabled = false;

                                int id = Convert.ToInt32(ddlExpenseType.Items[0].Value.ToString());

                                htSearchParams = new Hashtable();
                                htSearchParams["@exptidd"] = id;
                                DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpTypeDetailById", htSearchParams).Tables[0];
                                if (dt.Rows.Count > 0)
                                {
                                    DataRow row = dt.Rows[0];
                                    string measurmenttcod = row["measurmenttcod"].ToString();
                                    if (!string.IsNullOrEmpty(measurmenttcod))
                                    {
                                        Label lblExpenseValue = editItem.FindControl("lblExpenseValue") as Label;
                                        Label lblRate = editItem.FindControl("lblRate") as Label;
                                        RadNumericTextBox txtRate = editItem.FindControl("txtRate") as RadNumericTextBox;
                                        Label lblSubTotal = editItem.FindControl("lblSubTotal") as Label;
                                        RadNumericTextBox txtSubTotal = editItem.FindControl("txtSubTotal") as RadNumericTextBox;

                                        if (measurmenttcod.ToLower() == "money")
                                        {
                                            lblExpenseValue.Text = "Amount:";
                                            lblRate.Visible = false;
                                            txtRate.Visible = false;
                                            lblSubTotal.Visible = false;
                                            txtSubTotal.Visible = false;
                                        }
                                        else
                                        {
                                            lblExpenseValue.Text = row["unittype"].ToString();
                                            lblRate.Visible = true;
                                            txtRate.Visible = true;
                                            txtRate.Text = row["unitval"].ToString();
                                            lblSubTotal.Visible = true;
                                            txtSubTotal.Visible = true;
                                        }
                                    }

                        }

                            }

                        }
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OnValueChanged", "OnValueChanged();", true);
                }
            }
            else
            {
                // update

                

                if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
                {

                    (e.Item.FindControl("ddlEmployee") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "empidd").ToString();
                    (e.Item.FindControl("ddlEmployee") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "empcod").ToString();
                    (e.Item.FindControl("ddlEmployee") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "empidd").ToString();
                    (e.Item.FindControl("ddlEmployee") as RadComboBox).Enabled = false;

                    (e.Item.FindControl("ddlEmpPos") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "posidd").ToString();
                    (e.Item.FindControl("ddlEmpPos") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "poscod").ToString();
                    (e.Item.FindControl("ddlEmpPos") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "posidd").ToString();

                    RadComboBox ddlprj = (RadComboBox)e.Item.FindControl("ddlProject");
                    RadGrid gridprj = (RadGrid)ddlprj.Items[0].FindControl("rGrdProject4DDL");
                    gridprj.Rebind();
                    (e.Item.FindControl("ddlProject") as RadComboBox).Items[0].Value = DataBinder.Eval(e.Item.DataItem, "prjidd").ToString();
                    (e.Item.FindControl("ddlProject") as RadComboBox).Items[0].Text = DataBinder.Eval(e.Item.DataItem, "prjcod").ToString();
                    (e.Item.FindControl("ddlproject") as RadComboBox).SelectedValue = DataBinder.Eval(e.Item.DataItem, "prjidd").ToString();

                    RadComboBox ddlCountry = (e.Item.FindControl("ddlCountry") as RadComboBox);
                    if (ddlCountry != null)
                    {
                        ddlCountry.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "ctridd").ToString();
                        ddlCountry.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "ctrcod").ToString();
                        ddlCountry.SelectedValue = DataBinder.Eval(e.Item.DataItem, "ctridd").ToString();
                    }

                    RadComboBox ddlProvince = (e.Item.FindControl("ddlProvince") as RadComboBox);
                    if (ddlProvince != null)
                    {
                        RadGrid PrvGrid = ddlProvince.Items[0].FindControl("rGrdProvince4DDL") as RadGrid;
                        if (PrvGrid != null)
                        {
                            PrvGrid.Rebind();
                        }
                        ddlProvince.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "prvidd").ToString();
                        ddlProvince.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "prvcod").ToString();
                        ddlProvince.SelectedValue = DataBinder.Eval(e.Item.DataItem, "prvidd").ToString();
                    }

                    if (dtConfigs.Rows.Count > 0)
                    {
                        if (dtConfigs.Rows[0]["isprjvis"].ToString() != "True")
                        {
                            (e.Item.FindControl("ddlProject") as RadComboBox).Visible = false;
                            (e.Item.FindControl("lblProject") as Label).Visible = false;
                            (e.Item.FindControl("rfvddlProject") as RequiredFieldValidator).Enabled = false;
                        }
                        if (dtConfigs.Rows[0]["isvndrvis"].ToString() != "True")
                        {
                            (e.Item.FindControl("txtvendor") as TextBox).Visible = false;
                            (e.Item.FindControl("lblVendor") as Label).Visible = false;
                        }

                    }

                }

                if (e.Item.OwnerTableView.DataMember == "ExpenseType")
                {
                    ValidateExpenseType(e);
                    RadComboBox ddlExpenseType = (RadComboBox)e.Item.FindControl("ddlExpenseType");
                    ddlExpenseType.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "exptidd").ToString();
                    ddlExpenseType.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "exptcod").ToString();
                    ddlExpenseType.SelectedValue = DataBinder.Eval(e.Item.DataItem, "exptidd").ToString();


                    Label lblExpSubType = e.Item.FindControl("lblExpSubType") as Label;
                    RequiredFieldValidator RFVExpSubType = e.Item.FindControl("RFVExpSubType") as RequiredFieldValidator;
                    RadComboBox ddlExpSubType = (RadComboBox)e.Item.FindControl("ddlExpSubType");
                    RadGrid gvExpSub = ddlExpSubType.Items[0].FindControl("rGrdExpSubType4DDL") as RadGrid;
                    gvExpSub.Rebind();
                    if (gvExpSub.Items.Count > 0)
                    {
                        ddlExpSubType.Items[0].Value = DataBinder.Eval(e.Item.DataItem, "expsubtidd").ToString();
                        ddlExpSubType.Items[0].Text = DataBinder.Eval(e.Item.DataItem, "expsubtcod").ToString();
                        ddlExpSubType.SelectedValue = DataBinder.Eval(e.Item.DataItem, "expsubtidd").ToString();
                        
                        int id = Convert.ToInt32(ddlExpSubType.Items[0].Value.ToString());
                        htSearchParams = new Hashtable();
                        htSearchParams["@expsubtidd"] = id;
                        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpSubTypeDetailById", htSearchParams).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            string measurmenttcod = row["measurmenttcod"].ToString();
                            if (!string.IsNullOrEmpty(measurmenttcod))
                            {
                                Label lblExpenseValue = e.Item.FindControl("lblExpenseValue") as Label;
                                Label lblRate = e.Item.FindControl("lblRate") as Label;
                                RadNumericTextBox txtRate = e.Item.FindControl("txtRate") as RadNumericTextBox;
                                Label lblSubTotal = e.Item.FindControl("lblSubTotal") as Label;
                                RadNumericTextBox txtSubTotal = e.Item.FindControl("txtSubTotal") as RadNumericTextBox;

                                if (measurmenttcod.ToLower() == "money")
                                {
                                    lblExpenseValue.Text = "Amount:";
                                    lblRate.Visible = false;
                                    txtRate.Visible = false;
                                    lblSubTotal.Visible = false;
                                    txtSubTotal.Visible = false;
                                }
                                else
                                {
                                    lblExpenseValue.Text = row["unittype"].ToString();
                                    lblRate.Visible = true;
                                    txtRate.Visible = true;
                                    //txtRate.Text = row["unitval"].ToString();
                                    lblSubTotal.Visible = true;
                                    txtSubTotal.Visible = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        lblExpSubType.Visible = false;
                        ddlExpSubType.Visible = false;
                        RFVExpSubType.Enabled = false;
                        int idd = Convert.ToInt32(ddlExpenseType.Items[0].Value.ToString());

                        htSearchParams = new Hashtable();
                        htSearchParams["@exptidd"] = idd;
                        DataTable dtt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpTypeDetailById", htSearchParams).Tables[0];
                        if (dtt.Rows.Count > 0)
                        {
                            DataRow row = dtt.Rows[0];
                            string measurmenttcod = row["measurmenttcod"].ToString();
                            if (!string.IsNullOrEmpty(measurmenttcod))
                            {
                                Label lblExpenseValue = e.Item.FindControl("lblExpenseValue") as Label;
                                Label lblRate = e.Item.FindControl("lblRate") as Label;
                                RadNumericTextBox txtRate = e.Item.FindControl("txtRate") as RadNumericTextBox;
                                Label lblSubTotal = e.Item.FindControl("lblSubTotal") as Label;
                                RadNumericTextBox txtSubTotal = e.Item.FindControl("txtSubTotal") as RadNumericTextBox;

                                if (measurmenttcod.ToLower() == "money")
                                {
                                    lblExpenseValue.Text = "Amount:";
                                    lblRate.Visible = false;
                                    txtRate.Visible = false;
                                    lblSubTotal.Visible = false;
                                    txtSubTotal.Visible = false;
                                }
                                else
                                {
                                    lblExpenseValue.Text = row["unittype"].ToString();
                                    lblRate.Visible = true;
                                    txtRate.Visible = true;
                                    //txtRate.Text = row["unitval"].ToString();
                                    lblSubTotal.Visible = true;
                                    txtSubTotal.Visible = true;
                                }
                            }
                        }
                    }

                    Label lbltx1 = (Label)e.Item.FindControl("lbltx1");
                    RadNumericTextBox txttx1 = (RadNumericTextBox)e.Item.FindControl("txttx1");
                    Label lbltx2 = (Label)e.Item.FindControl("lbltx2");
                    RadNumericTextBox txttx2 = (RadNumericTextBox)e.Item.FindControl("txttx2");
                    Label lbltx3 = (Label)e.Item.FindControl("lbltx3");
                    RadNumericTextBox txttx3 = (RadNumericTextBox)e.Item.FindControl("txttx3");

                    if (string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx1lbl").ToString()) || string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx1val").ToString()))
                    {
                        lbltx1.Visible = false;
                        txttx1.Visible = false;
                    }
                    if (string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx2lbl").ToString()) || string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx2val").ToString()))
                    {
                        lbltx2.Visible = false;
                        txttx2.Visible = false;
                    }
                    if (string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx3lbl").ToString()) || string.IsNullOrEmpty(DataBinder.Eval(e.Item.DataItem, "tx3val").ToString()))
                    {
                        lbltx3.Visible = false;
                        txttx3.Visible = false;
                    }


                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "OnValueChanged", "OnValueChanged();", true);

                    GridEditableItem item = e.Item as GridEditableItem;
                    int ID = Convert.ToInt32(item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString());
                    
                    Hashtable ht = new Hashtable(); 
                    ht.Add("@ID", ID);
                    ht.Add("@transactioname", "ReimbursmentT2");
                    DataTable dtAttachs = clsDAL.GetDataSet_Payroll("sp_User_Get_attach_ByID", ht).Tables[0];
                    RadAsyncUpload ruDocument = (e.Item.FindControl("ruDocument") as RadAsyncUpload);
                    Label lblFiles = (e.Item.FindControl("lblFiles") as Label);
                    int noOfAttachs = dtAttachs.Rows.Count;
                    int noOfMoreAttachs=5-noOfAttachs;
                    if (noOfMoreAttachs < 1)
                    {
                        ruDocument.Visible = false;
                        lblFiles.Visible = true;
                    }
                    ruDocument.MaxFileInputsCount = noOfMoreAttachs;
                }

            }

            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
            {
                //(e.Item as GridEditableItem)["IsWeekend"].Parent.Visible = false;
                //(e.Item as GridEditableItem)["IsPublicHoliday"].Parent.Visible = false;
                
                

                ValidateReimb(e);
            }
        }

        // color days
        if (e.Item is GridDataItem)
        {
            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
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
                ht_Reports.Add("@formtypeid", Request.QueryString["FormType"]); // Att Setup form type = 3103

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
    protected void gvReimbursment_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);

        if (e.CommandName == "InitInsert" && e.Item.OwnerTableView.DataMember == "ExpenseType")
        {
            if (Session["_Empid"] != null)
            {
                Session["_Empid"] = null;
            }
        }

        if (e.CommandName == "ExpandCollapse" && e.Item.OwnerTableView.DataMember == "ReimbMaster")
        {
            if (e.Item.Expanded)
            {
            }
            else
            {
                foreach (GridItem item in e.Item.OwnerTableView.Items)
                {
                    if (item.Expanded && item != e.Item)
                    {
                        GridDataItem item1 = (GridDataItem)e.Item;
                        if (item1 is GridDataItem)
                        {
                            GridTableView detailtable = (GridTableView)item1.ChildItem.NestedTableViews[0];
                            detailtable.IsItemInserted = false;
                            detailtable.Rebind(); 
                        }
                        item.Expanded = false;
                    }
                }

            }
        }

        if (e.CommandName == "View" && e.Item.OwnerTableView.DataMember == "Attachments")
        {
            GridDataItem item = e.Item as GridDataItem;
            int id = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
            try
            {
                byte[] bytes;
                string fileName, contentType;
                string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select documentname Name, document Data,documenttype ContentType from eb_prlattach where idd=@Id";
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Connection = con;
                        con.Open();
                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            sdr.Read();
                            bytes = (byte[])sdr["Data"];
                            contentType = sdr["ContentType"].ToString();
                            fileName = sdr["Name"].ToString();
                        }
                        con.Close();
                    }
                }
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        if (e.CommandName == "Download" && e.Item.OwnerTableView.DataMember == "Attachments")
        {
            GridDataItem item = e.Item as GridDataItem;
            int id = Convert.ToInt32(item.GetDataKeyValue("idd").ToString());
            try
            {
                byte[] bytes;
                string fileName, contentType;
                string constr = ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "select documentname Name, document Data,documenttype ContentType from eb_prlattach where idd=@Id";
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Connection = con;
                        con.Open();
                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            sdr.Read();
                            bytes = (byte[])sdr["Data"];
                            contentType = sdr["ContentType"].ToString();
                            fileName = sdr["Name"].ToString();
                        }
                        con.Close();
                    }
                }
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        if (e.CommandName == "PrintRecord")
        {
            GridDataItem item = e.Item as GridDataItem;
            int requestId = Convert.ToInt32(item.GetDataKeyValue("prmidd").ToString());
            string rptName = clsEncryption.EncryptData("ReimbursmentT2byID");


            //string rptName = "ReimbursmentT2byID";
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);


            //string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            //// bring report from formtype
            //string rptName = clsEncryption.EncryptData("LeaveTrxEntryByID");
            //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
            
        }

        if (e.CommandName == "CopyToToday")
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                Hashtable newValues = new Hashtable();
                newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                newValues["@employeeIDD"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                newValues["@employeeCode"] = item.GetDataKeyValue("empcod").ToString();

                newValues["@posidd"] = Convert.ToInt32(item.GetDataKeyValue("posidd").ToString());
                newValues["@poscod"] = item.GetDataKeyValue("poscod").ToString();
                if (!string.IsNullOrEmpty(item.GetDataKeyValue("prjidd").ToString()))
                {
                    newValues["@prjidd"] = Convert.ToInt32(item.GetDataKeyValue("prjidd").ToString());
                    newValues["@prjcod"] = item.GetDataKeyValue("prjcod").ToString();
                }
                newValues["@reimdat"] = item.GetDataKeyValue("Date").ToString();

                newValues["@reimcmt"] = item.GetDataKeyValue("reimcmt").ToString();
                newValues["@reimtyp"] = 1;
                newValues["@reimtcd"] = "Daily";
                                
                newValues["@DBMessage"] = "";
                newValues["@prmtrx"] = Session["_ReimbCurrtrxNumber"];
                newValues["@subtrx"] = "subtrans";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;
                
                string DBMessage = "";

                DBMessage = clsDAL.ExecuteNonQuery_payroll("[sp_payroll_Copy_ReimbT2mst_Record]", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
               
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Employee Attendance copied/saved successfully.", MessageType.Success);
                    gvReimbursment.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to copy/insert Employee Attendance . Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            gvReimbursment.Rebind();

        }

        if (e.CommandName == "CopyToTomorrow")
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                Hashtable newValues = new Hashtable();
                newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                newValues["@employeeIDD"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                newValues["@employeeCode"] = item.GetDataKeyValue("empcod").ToString();
                newValues["@posidd"] = Convert.ToInt32(item.GetDataKeyValue("posidd").ToString());
                newValues["@poscod"] = item.GetDataKeyValue("poscod").ToString();
                if (!string.IsNullOrEmpty(item.GetDataKeyValue("prjidd").ToString()))
                {
                    newValues["@prjidd"] = Convert.ToInt32(item.GetDataKeyValue("prjidd").ToString());
                    newValues["@prjcod"] = item.GetDataKeyValue("prjcod").ToString();
                }
                newValues["@reimdat"] = Convert.ToDateTime(item.GetDataKeyValue("Date").ToString()).AddDays(1); 
                newValues["@reimcmt"] = item.GetDataKeyValue("reimcmt").ToString();
                newValues["@reimtyp"] = 1;
                newValues["@reimtcd"] = "Daily";
                newValues["@DBMessage"] = "";
                newValues["@prmtrx"] = Session["_ReimbCurrtrxNumber"];
                newValues["@subtrx"] = "subtrans";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;

                string DBMessage = "";

                DBMessage = clsDAL.ExecuteNonQuery_payroll("[sp_payroll_Copy_ReimbT2mst_Record]", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Reimbursement entry copied/saved successfully.", MessageType.Success);
                    gvReimbursment.Rebind();
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Unable to copy/insert Reimbursement entry. Reason: " + ex.Message, MessageType.Error);
                e.Canceled = true;
            }
            gvReimbursment.Rebind();

        }

        if (e.CommandName == "UpdateAll")
        {
            try
            {
                string DBMessage = "";
                foreach (GridDataItem item in grid.MasterTableView.Items)
                {
                    Hashtable newValues = new Hashtable();
                    newValues["@recidd"] = Convert.ToInt32(item.GetDataKeyValue("recidd").ToString());
                    newValues["@employeeIDD"] = Convert.ToInt32(item.GetDataKeyValue("empidd").ToString());
                    newValues["@attdat"] = item.GetDataKeyValue("Date").ToString();
                    newValues["@DBMessage"] = "";
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_EmpAttNormalHours", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Employee Attendance Normal hours updated successfully.", MessageType.Success);
                    gvReimbursment.Rebind();
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

            if (e.Item.OwnerTableView.DataMember == "ExpenseType")
            {
                if (Session["_Empid"] != null)
                {
                    Session["_Empid"] = null;
                }
            }
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

            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
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

            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
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

            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
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
    protected void gvReimbursment_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Att(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Att(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "ReimbMaster")
            {
                #region Reimbursment Master

                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                }
                                
                newValues["@employeeIDD"] = Convert.ToInt32((editedItem.FindControl("ddlEmployee") as RadComboBox).Items[0].Value);
                newValues["@employeeCode"] = (editedItem.FindControl("ddlEmployee") as RadComboBox).Items[0].Text.ToString();

                newValues["@posidd"] = Convert.ToInt32((editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Value);
                newValues["@poscod"] = (editedItem.FindControl("ddlEmpPos") as RadComboBox).Items[0].Text.ToString();

                if ((editedItem.FindControl("ddlProject") as RadComboBox).Visible)
                {
                    newValues["@prjidd"] = Convert.ToInt32((editedItem.FindControl("ddlProject") as RadComboBox).Items[0].Value);
                    newValues["@prjcod"] = (editedItem.FindControl("ddlProject") as RadComboBox).Items[0].Text.ToString();
                }
                newValues["@reimdat"] = (editedItem.FindControl("dtpDate") as RadDatePicker).SelectedDate.Value;
                newValues["@ctridd"] = Convert.ToInt32((editedItem.FindControl("ddlCountry") as RadComboBox).Items[0].Value);
                newValues["@ctrcod"] = (editedItem.FindControl("ddlCountry") as RadComboBox).Items[0].Text.ToString();
                newValues["@prvidd"] = Convert.ToInt32((editedItem.FindControl("ddlProvince") as RadComboBox).Items[0].Value);
                newValues["@prvcod"] = (editedItem.FindControl("ddlProvince") as RadComboBox).Items[0].Text.ToString();
                if ((editedItem.FindControl("txtvendor") as TextBox).Visible)
                {
                    newValues["@vendor"] = (editedItem.FindControl("txtvendor") as TextBox).Text;
                }
                newValues["@reimcmt"] = (editedItem.FindControl("txtreimcmt") as TextBox).Text;

                newValues["@reimtyp"] = 1;
                newValues["@reimtcd"] = "Daily";
                newValues["@DBMessage"] = "";
                newValues["@userid"] = Session["_UserID"].ToString();
                newValues["@requestdate"] = DateTime.Now;
                if (operation == "Insert")
                {
                    newValues["@FormTypeID"] = Request.QueryString["FormType"];
                    newValues["@SubmittedByUserID"] = (string)Session["_UserID"];
                    newValues["@TransRemarks"] = "";
                    newValues["@ReimbursmentID"] = 0;
                    newValues["@prmtrx"] = Session["_ReimbCurrtrxNumber"];
                    newValues["@subtrx"] = "subtrans";
                    newValues["@DBOperation"] = 1;
                }
                string DBMessage = "";
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_reimbT2mst", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    //newValues["@DBOperation"] = 2;

                    DBMessage = clsDAL.ExecuteNonQuery_payroll("[sp_payroll_Update_reimbT2mst]", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    ShowClientMessage("Reimbursement entry saved successfully.", MessageType.Success);
                    gvReimbursment.Rebind();
                }

                #endregion
            }

            if (e.Item.OwnerTableView.DataMember == "ExpenseType")
            {
                #region Expense Type
                int error = 0;

                Hashtable ht = new Hashtable();
                RadComboBox ddlExpSubType = editedItem.FindControl("ddlExpSubType") as RadComboBox;
                RadGrid gvExpSub = ddlExpSubType.Items[0].FindControl("rGrdExpSubType4DDL") as RadGrid;
                if (gvExpSub.Items.Count > 0)
                {
                    ht["@expsubtidd"] = Convert.ToInt32(ddlExpSubType.Items[0].Value);
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpSubType_records", ht).Tables[0];
                
                if (dt != null)
                {
                    if (!string.IsNullOrEmpty(dt.Rows[0]["fromval"].ToString()) && !string.IsNullOrEmpty(dt.Rows[0]["toval"].ToString()))
                    {
                        double fromVal = Convert.ToDouble(dt.Rows[0]["fromval"].ToString());
                        double toVal = Convert.ToDouble(dt.Rows[0]["toval"].ToString());
                        double expval = Convert.ToDouble((editedItem.FindControl("txtExpenseValue") as RadNumericTextBox).Text);
                        if (expval < fromVal || expval > toVal)
                        {
                            ShowClientMessage("Expense value is out of range:"+fromVal+"-"+toVal, MessageType.Error);
                            e.Canceled = true;
                                error = 1;
                            }
                        }
                    }
                }
                else 
                {
                    RadComboBox ddlExpenseType = editedItem.FindControl("ddlExpenseType") as RadComboBox;
                    int idd = Convert.ToInt32(ddlExpenseType.Items[0].Value.ToString());

                    htSearchParams = new Hashtable();
                    htSearchParams["@exptidd"] = idd;
                    DataTable dtt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpTypeDetailById", htSearchParams).Tables[0];
                    if (dtt.Rows.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(dtt.Rows[0]["fromval"].ToString()) && !string.IsNullOrEmpty(dtt.Rows[0]["toval"].ToString()))
                        {
                            double fromVal = Convert.ToDouble(dtt.Rows[0]["fromval"].ToString());
                            double toVal = Convert.ToDouble(dtt.Rows[0]["toval"].ToString());
                            double expval = Convert.ToDouble((editedItem.FindControl("txtExpenseValue") as RadNumericTextBox).Text);
                            if (expval < fromVal || expval > toVal)
                            {
                                ShowClientMessage("Expense value is out of range:" + fromVal + "-" + toVal, MessageType.Error);
                                e.Canceled = true;
                                error = 1;
                            }
                        }
                    }
                }
                
                if (error != 1)
                {
                //Insert new values
                Hashtable newValues = new Hashtable();
                
                if (operation == "Update")
                {
                    newValues["@recidd"] = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                }
                if (operation == "Insert")
                {
                    newValues["@mrecidd"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["recidd"].ToString());
                }
                newValues["@exptidd"] = Convert.ToInt32((editedItem.FindControl("ddlExpenseType") as RadComboBox).Items[0].Value);
                newValues["@exptcod"] = (editedItem.FindControl("ddlExpenseType") as RadComboBox).Items[0].Text.ToString();

                    if (!string.IsNullOrEmpty((editedItem.FindControl("ddlExpSubType") as RadComboBox).Items[0].Value))
                    {
                newValues["@expsubtidd"] = Convert.ToInt32((editedItem.FindControl("ddlExpSubType") as RadComboBox).Items[0].Value);
                newValues["@expsubtcod"] = (editedItem.FindControl("ddlExpSubType") as RadComboBox).Items[0].Text.ToString();
                    }
                    RadNumericTextBox txtSubTotal = editedItem.FindControl("txtSubTotal") as RadNumericTextBox;
                    if (txtSubTotal.Visible)
                    {
                    newValues["@subtotal"] = (editedItem.FindControl("txtSubTotal") as RadNumericTextBox).Text;
                    newValues["@unitval"] = (editedItem.FindControl("txtRate") as RadNumericTextBox).Text;
                    }
                newValues["@expval"] = (editedItem.FindControl("txtExpenseValue") as RadNumericTextBox).Text;

                    RadNumericTextBox txttx1 = editedItem.FindControl("txttx1") as RadNumericTextBox;
                    if (txttx1.Visible)
                    {
                        newValues["@tx1lbl"] = (editedItem.FindControl("lbltx1") as Label).Text;
                        newValues["@tx1val"] = (editedItem.FindControl("txttx1") as RadNumericTextBox).Text;
                    }
                    RadNumericTextBox txttx2 = editedItem.FindControl("txttx2") as RadNumericTextBox;
                    if (txttx2.Visible)
                    {
                        newValues["@tx2lbl"] = (editedItem.FindControl("lbltx2") as Label).Text;
                        newValues["@tx2val"] = (editedItem.FindControl("txttx2") as RadNumericTextBox).Text;
                    }
                    RadNumericTextBox txttx3 = editedItem.FindControl("txttx3") as RadNumericTextBox;
                    if (txttx3.Visible)
                    {
                        newValues["@tx3lbl"] = (editedItem.FindControl("lbltx3") as Label).Text;
                        newValues["@tx3val"] = (editedItem.FindControl("txttx3") as RadNumericTextBox).Text;
                    }

                newValues["@totalval"] = (editedItem.FindControl("txtTotalValue") as RadNumericTextBox).Text;
                newValues["@expcmt"] = (editedItem.FindControl("txtexpcmt") as TextBox).Text;
                newValues["@DBMessage"] = "";
                newValues["@userid"] = Session["_UserID"].ToString();
                string DBMessage = "";
                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_ReimbDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Update_ReimbDetail", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                    int recidd;
                    if (operation == "Update")
                    {
                        recidd = Convert.ToInt32(editedItem.GetDataKeyValue("recidd").ToString());
                    }
                    else
                    {
                        recidd = Convert.ToInt32(DBMessage);
                    }
                    RadAsyncUpload ruDocument = editedItem.FindControl("ruDocument") as RadAsyncUpload;
                    Hashtable ht_attachments = new Hashtable();

                    if (ruDocument.UploadedFiles.Count > 0)
                    {
                        for (int l = 0; l <= ruDocument.UploadedFiles.Count - 1; l++)
                        {
                            var currentFile = ruDocument.UploadedFiles[l];
                            var filedsc = currentFile.GetFieldValue("TextBox").ToString();
                            var filename = ruDocument.UploadedFiles[l].FileName;
                            var imgStream = currentFile.InputStream;
                            int imgLen = int.Parse(currentFile.ContentLength.ToString());

                            byte[] imgBinaryData = new byte[imgLen];
                            int n = imgStream.Read(imgBinaryData, 0, imgLen);

                            // Image to Base64 string and save in database
                            // Convert byte[] to Base64 String

                            string base64String = Convert.ToBase64String(imgBinaryData);

                            ht_attachments = new Hashtable();
                            ht_attachments.Add("@transactionname", "ReimbursementT2");
                            ht_attachments.Add("@transactionidd", recidd);
                            ht_attachments.Add("@transactioncode", "Expense");
                            ht_attachments.Add("@description", filedsc);

                            ht_attachments["@File"] = imgBinaryData;
                            ht_attachments["@Filetype"] = currentFile.ContentType;
                            ht_attachments["@Filename"] = filename;

                            clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                        }
                    }

                    ShowClientMessage("Expense detail saved successfully.", MessageType.Success);
                }
                }

                #endregion
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Expense detail. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // grid header formating for exporting
    protected void gvReimbursment_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "ReimbMaster")
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            GridTableView table = (GridTableView)e.Item.OwnerTableView;
            if (Session["_ReimbTab1Function"].ToString() != "New")
            {
                //ImageButton DeleteAtt = dataItem.FindControl("DeleteAtt") as ImageButton;
                Hashtable ht = new Hashtable();
                ht["@prmtrx"] = Session["_ReimbCurrtrxNumber"].ToString();
                DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_RequestStatusIDs_Byprmtrx", ht).Tables[0];
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                        if (row[0].ToString() == "10")
                        {
                            table.GetColumn("DeleteAtt").Display = false;
                            break;
                        }
                }
            }
            else
            {
                table.GetColumn("DeleteAtt").Display = true;
            }

        }






        if (Session["_ReimbTab1Function"].ToString() == "View")
        {
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "ReimbMaster")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;

                table.GetColumn("EditFiles").Display = false;
            }
            GridCommandItem cmdItem = (GridCommandItem)gvReimbursment.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            ((Button)cmdItem.FindControl("btnUpdateNH")).Visible = false;

        }
        else
        {
            if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "ReimbMaster")
            {
                GridTableView table = (GridTableView)e.Item.OwnerTableView;

                table.GetColumn("EditFiles").Display = true;
            }

        }

        if (Session["_ReimbTab1Function"].ToString() == "View" || Session["_ReimbTab1Function"].ToString() == "Edit")
        {
            GridCommandItem cmdItem = (GridCommandItem)gvReimbursment.MasterTableView.GetItems(GridItemType.CommandItem)[0];
            ((Button)cmdItem.FindControl("Button1")).Visible = false;
        }
        
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

    // employee Position ddl data binding event
    protected void rGrdEmpPos4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmpPos", htSearchParams).Tables[0];
    }

       
    protected void btnNewEntries_Click(object sender, EventArgs e)
    {
        Hashtable ht_nextnumber = new Hashtable();
        ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
        ht_nextnumber.Add("@TRX_ID", null);
        //sp_User_Increment_Seq_Number
        Session["_ReimbCurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
        Session["_ReimbTab1Function"] = "New";
        gvReimbursment.Rebind();
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        rBtnSave.Visible = true;
        rBtnSaveAndSubmit.Visible = true;
        TopPanel.Visible = true;
        ApprovalPanel.Visible = false;
    }
    
    //Save buuton operations
    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        if (gvReimbursment.MasterTableView.Items.Count > 0)
        {
            save(1);
            Hashtable newValues = new Hashtable();
            clsDAL.ExecuteNonQuery_payroll("sp_User_Increment_ReimbSeq_Number", newValues);
            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
            ht_nextnumber.Add("@TRX_ID", null);
            Session["_ReimbCurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            gvReimbursment.Rebind();
            gvSavedRequests.Rebind();
            gvSubmittedRequests.Rebind();
        }
        else 
        {
            ShowClientMessage("No records to save", MessageType.Error);
        }
        

    }

    //Save & Submit buuton operations
    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        if (gvReimbursment.MasterTableView.Items.Count > 0)
        {
            save(2);
            if(Session["_ReimbTab1Function"].ToString() == "New")
            {
                Hashtable newValues = new Hashtable();
                clsDAL.ExecuteNonQuery_payroll("sp_User_Increment_ReimbSeq_Number", newValues);
                Hashtable ht_nextnumber = new Hashtable();
                ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
                ht_nextnumber.Add("@TRX_ID", null);
                Session["_ReimbCurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            }
            else 
            {
                Session["_ReimbCurrtrxNumber"] = "";
                rBtnSaveAndSubmit.Visible = false;
            }
            gvReimbursment.Rebind();
            gvSavedRequests.Rebind();
            gvSubmittedRequests.Rebind();
        }
        else
        {
            ShowClientMessage("No records to save & submit", MessageType.Error);
        }
    }


    private void save(int saveStatus)
    {
        try
        {
            Hashtable ht = new Hashtable();
            if(saveStatus == 1)
            {
                ht["@action"] = "Save";
            }
            else if (saveStatus == 2)
            {
                ht["@action"] = "SaveAndSubmit";
            }
            ht["@prmtrx"] = Session["_ReimbCurrtrxNumber"].ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_Submit_ReimbursmentT2", ht);
            int Recidd = 2; //dummy value should be returned from the sp above
            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", formType);
            ht_message.Add("@SubmittedByUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", "0");

            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

            if (saveStatus == 2 && wfid > 0)
            {
                ht = null;
                ht = new Hashtable();
                ht.Add("@SuggestionID", Recidd);
                ht.Add("@RedirectURL", Request.Url.AbsoluteUri);
                clsCommon.SendMail(3, ht);
            }
            
            if (wfid == 0)
            {
                ShowClientMessage("Transaction saved but cannot be Sumbitted due to missing workflow.", MessageType.Warning);
            }
            else if (wfid > 0 && saveStatus == 2)
            {
                ShowClientMessage("Transaction saved and submitted successfully.", MessageType.Success);
            }
            else if (wfid > 0 && saveStatus == 1)
            {
                ShowClientMessage("Transaction saved and can be submitted from tab.", MessageType.Info);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Sorry! some error has occurred. Please try again later.<br/>" + ex.Message, MessageType.Error);
            Logger.LogError(ex);
        }
    }

    protected void ddlEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlEmp = sender as RadComboBox;

        RadComboBox ddlProject = (((RadComboBox)sender).Parent.FindControl("ddlProject") as RadComboBox);
        if (ddlProject != null)
        {
            ddlProject.Items[0].Value = "";
            ddlProject.Items[0].Text = "";
            ddlProject.SelectedValue = "";
            RadGrid PrjGrid = ddlProject.Items[0].FindControl("rGrdProject4DDL") as RadGrid;
            if (PrjGrid != null)
            {
                PrjGrid.Rebind();
                string id = "";
                string code = "";

                if (ddlProjectOuter.Items[0].Value != null && rcbProject.Checked == true)
                {
                    id = ddlProjectOuter.Items[0].Value.ToString();
                    code = ddlProjectOuter.Items[0].Text.ToString();
                }
                else if (gvReimbursment.MasterTableView.Items.Count > 0)
                {
                    id = gvReimbursment.Items[gvReimbursment.MasterTableView.Items.Count - 1].GetDataKeyValue("prjidd").ToString();
                    code = gvReimbursment.Items[gvReimbursment.MasterTableView.Items.Count - 1].GetDataKeyValue("prjcod").ToString();
                }

                foreach (GridItem item in PrjGrid.MasterTableView.Items)
                {
                    if (item is GridDataItem)
                    {
                        if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString()))
                        {
                            ddlProject.Items[0].Value = id;
                            ddlProject.Items[0].Text = code;
                            ddlProject.SelectedValue = id;
                            break;
                        }
                        else if (item.ItemIndex == 0)
                        {
                            ddlProject.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                            ddlProject.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjcod"].ToString();
                            ddlProject.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prjidd"].ToString();
                        }
                    }
                }
            }
        }

        string empcod = ddlEmp.Items[0].Text;
        htSearchParams = new Hashtable();
        htSearchParams["@employeeCode"] = empcod;
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_EmpPosDetail", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            string id = row[0].ToString();
            string code = row[1].ToString();
            RadComboBox ddlEmpPosition = (((RadComboBox)sender).Parent.FindControl("ddlEmpPos") as RadComboBox);
            if (ddlEmpPosition != null)
            {
                RadGrid EmpPosGrid = ddlEmpPosition.Items[0].FindControl("rGrdEmpPos4DDL") as RadGrid;
                if (EmpPosGrid != null)
                {
                    //EmpPosGrid.Rebind();

                    ddlEmpPosition.Items[0].Value = id;
                    ddlEmpPosition.Items[0].Text = code;
                    ddlEmpPosition.Text = code;

                    foreach (GridItem item in EmpPosGrid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["posidd"].ToString()))
                            //if (item.GetDataKeyValue("posidd").ToString() == id)
                            {
                                item.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
    }

    private void bindCombos()
    {
        //if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        //{
        RadGrid grid;
        rCmbLevels.ClearSelection();

        Hashtable ht_transactionentryid = new Hashtable();
        ht_transactionentryid.Add("@AttEntTrxID", int.Parse(Session["_recidd"].ToString()));
        grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Get_Revise_Users_Of_ReimbursmentT2", ht_transactionentryid).Tables[0];
        grid.Rebind();
        //}
    }

    protected void ReBindAllGrids()
    {
        gvReimbursment.Rebind();
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }

    protected void rBtnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@ReimbursmentID", Session["_recidd"]);
            ht.Add("@ReimbursmentStatusID", Session["_RequestStatusID"]);
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            ht.Add("@TransRemarks", txtremarks.Text);
            ht.Add("@DBMessage", "");

            string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Approve_ReimbursmentT2", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
            //ReBindAllGrids();

            Hashtable ht_nextnumber = new Hashtable();
            ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
            ht_nextnumber.Add("@TRX_ID", null);
            //sp_User_Increment_Seq_Number
            Session["_ReimbCurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
            Session["_ReimbTab1Function"] = "New";
            gvReimbursment.Rebind();
            gvPendingAppRequests.Rebind();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            rBtnSave.Visible = true;
            rBtnSaveAndSubmit.Visible = true;
            TopPanel.Visible = true;
            ApprovalPanel.Visible = false;

            //ht = null;
            //ht = new Hashtable();
            //ht.Add("@LeaveTransactionID", Request.QueryString["RequestID"]);

            //DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht).Tables[0];

            //if ((null != dt) && dt.Rows.Count > 0)
            //{
            //    ht = null;
            //    ht = new Hashtable();
            //    ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
            //    ht.Add("@RedirectURL", Request.Url.AbsoluteUri);

            //    //clsCommon.SendMail(3, ht);
            //}


            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
                ShowClientMessage("Processed successfully.", MessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnReject_Click(object sender, EventArgs e)
    {
        try
        {
        Hashtable ht = new Hashtable();

        ht.Add("@ReimbursmentRequestID", Session["_recidd"]);
        ht.Add("@ReimbursmentStatusID", Session["_RequestStatusID"]);
        ht.Add("@ApproverUserID", Session["_UserID"].ToString());
        ht.Add("@transremarks", txtremarks.Text);
        ht.Add("@DBMessage", "");

        string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Reject_ReimbursmentT2_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
        //ReBindAllGrids();
        if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
        {
            ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
             ShowClientMessage("Processed successfully.", MessageType.Success);

             Hashtable ht_nextnumber = new Hashtable();
             ht_nextnumber.Add("@seqcod", "REIMBURSEMENTT2");
             ht_nextnumber.Add("@TRX_ID", null);
             //sp_User_Increment_Seq_Number
             Session["_ReimbCurrtrxNumber"] = clsDAL.ExecuteNonQuery("sp_User_Get_Next_Transaction_Number", ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;
             Session["_ReimbTab1Function"] = "New";
             gvReimbursment.Rebind();
             gvPendingAppRequests.Rebind();
             //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
             //ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
             rBtnSave.Visible = true;
             rBtnSaveAndSubmit.Visible = true;
             TopPanel.Visible = true;
             ApprovalPanel.Visible = false;
        }
        }
        catch (Exception ex)
        {
            ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnRevise_Click(object sender, EventArgs e)
    {
        //     //MultiView1.ActiveViewIndex = 1;
        //try
        //{
        //    RadGrid grid;
        //    grid = rCmbLevels.Items[0].FindControl("rGrdLevels4DDL") as RadGrid;

        //    if (grid.SelectedValue != null)
        //    {
        //        int transactionstatusid;
        //        transactionstatusid = Int32.Parse(grid.SelectedValue.ToString());
        //        Hashtable ht = new Hashtable();
        //        ht.Add("@TransactionEntryRequestID", Request.QueryString["RequestID"]);
        //        ht.Add("@TransactionEntryStatusID", Request.QueryString["RequestStatusID"]);
        //        ht.Add("@ApproverUserID", Session["_UserID"].ToString());
        //        ht.Add("@transRemarks", txtremarks.Text);
        //        ht.Add("@revisetostatusid", transactionstatusid);
        //        ht.Add("@DBMessage", "");
        //        string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Revise_Leave_Request", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
        //        if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
        //        {
        //            ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind('" + "Processed Successfully" + "');", true);
        //        }
        //    }
        //    else
        //        ShowClientMessage("User Required", MessageType.Error);
        //}
        //catch (Exception ex)
        //{
        //    ShowClientMessage(ex.Message, MessageType.Error);
        //}
    }

    // History grid data loading and binding
    protected void gvHistory_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (Session["_recidd"] != null)
        {
            htSearchParams = new Hashtable();
            htSearchParams.Add("@recordId", int.Parse(Session["_recidd"].ToString()));
            DataTable dt = clsDAL.GetDataSet_Payroll("[sp_User_Get_ReimbT2Trx_History]", htSearchParams).Tables[0];
            dt.TableName = "HistoryMaster";
            Session["Rows"] = dt.Rows.Count;
            gvHistory.DataSource = dt;
            gvHistory.DataMember = "HistoryMaster";
        }
    }

    // form controls settings for insert/udpate
    protected void gvHistory_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "HistoryMaster")
            {

            }
        }

        // get count literal and assign grid list count
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            Literal ltNotiCount = (Literal)commandItem.FindControl("ltNotiCount");
            if (ltNotiCount != null)
            {
                ltNotiCount.Text = Session["Rows"] != null ? Session["Rows"].ToString() : "0";
            }
        }
    }

    // form controls setting for insert/udpate
    // grid exporting functions
    protected void gvHistory_ItemCommand(object sender, GridCommandEventArgs e)
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

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditHistory").Visible = false;
            grid.MasterTableView.GetColumn("DeleteHistory").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
    }
    protected void gvReimbursment_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "ExpenseType":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@mrecidd", ID);

                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ExpenseDetail", ht).Tables[0];
                    dt.TableName = "ExpenseType";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "ExpenseType";
                    break;
                }
            case "Attachments":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@ID", ID);
                    ht.Add("@transactioname", "ReimbursementT2");
                    DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_attach_ByID", ht).Tables[0];
                    dt.TableName = "Attachments";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "Attachments";
                    break;
                }
        }
    }

    protected void rGrdExpenseType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {

        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        RadComboBox ddlexptype = grid.Parent.Parent as RadComboBox;

        GridEditFormItem editedItem = ddlexptype.NamingContainer as GridEditFormItem;
        htSearchParams["@ID"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["empidd"].ToString());
        
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseTypeAssignment_Records", htSearchParams).Tables[0];
    }

    protected void rGrdExpSubType4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        RadComboBox ddlExpSub = grid.Parent.Parent as RadComboBox;
        if (ddlExpSub != null)
        {
            GridEditFormItem editedItem = ddlExpSub.NamingContainer as GridEditFormItem;
            if (editedItem != null)
            {
                RadComboBox ddlExp = editedItem.FindControl("ddlExpenseType") as RadComboBox;
                if (ddlExp != null)
                {
                    if (!String.IsNullOrEmpty(ddlExp.Items[0].Value))
                    {
                        htSearchParams = new Hashtable();
                        //RadGrid grid = sender as RadGrid;
                        htSearchParams["@exptidd"] = Convert.ToInt32(ddlExp.Items[0].Value);
                        htSearchParams["@employeeIDD"] = Convert.ToInt32(editedItem.OwnerTableView.ParentItem.OwnerTableView.DataKeyValues[editedItem.OwnerTableView.ParentItem.ItemIndex]["empidd"].ToString());
                        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_EmpExpenseSubTypeAssignment_Records", htSearchParams).Tables[0];

                    }
                }
            }
        }
    }
    protected void ddlExpenseType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlExp = sender as RadComboBox;
        GridEditFormItem editedItem = ddlExp.NamingContainer as GridEditFormItem;
        if (editedItem != null)
        {
            RadComboBox ddlExpSub = editedItem.FindControl("ddlExpSubType") as RadComboBox;
            Label lblExpSubType = editedItem.FindControl("lblExpSubType") as Label;
            RequiredFieldValidator RFVExpSubType = editedItem.FindControl("RFVExpSubType") as RequiredFieldValidator;
            if (ddlExpSub != null)
            {
                RadGrid gvExpSub = ddlExpSub.Items[0].FindControl("rGrdExpSubType4DDL") as RadGrid;
                if (gvExpSub != null)
                {
                    gvExpSub.Rebind();
                    ddlExpSub.Items[0].Value = "";
                    ddlExpSub.Items[0].Text = "";
                    ddlExpSub.SelectedValue = "";

                    if (gvExpSub.Items.Count == 0)
                    {
                        lblExpSubType.Visible = false;
                        ddlExpSub.Visible = false;
                        RFVExpSubType.Enabled=false;

                        int id = Convert.ToInt32(ddlExp.Items[0].Value.ToString());

                        htSearchParams = new Hashtable();
                        htSearchParams["@exptidd"] = id;
                        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpTypeDetailById", htSearchParams).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            string measurmenttcod = row["measurmenttcod"].ToString();
                            if (!string.IsNullOrEmpty(measurmenttcod))
                            {
                                Label lblExpenseValue = editedItem.FindControl("lblExpenseValue") as Label;
                                Label lblRate = editedItem.FindControl("lblRate") as Label;
                                RadNumericTextBox txtRate = editedItem.FindControl("txtRate") as RadNumericTextBox;
                                Label lblSubTotal = editedItem.FindControl("lblSubTotal") as Label;
                                RadNumericTextBox txtSubTotal = editedItem.FindControl("txtSubTotal") as RadNumericTextBox;

                                if (measurmenttcod.ToLower() == "money")
                                {
                                    lblExpenseValue.Text = "Amount:";
                                    lblRate.Visible = false;
                                    txtRate.Visible = false;
                                    lblSubTotal.Visible = false;
                                    txtSubTotal.Visible = false;
                                    txtRate.Text = "";
                                    txtSubTotal.Text = "";
                                }
                                else
                                {
                                    lblExpenseValue.Text = row["unittype"].ToString();
                                    lblRate.Visible = true;
                                    txtRate.Visible = true;
                                    txtRate.Text = row["unitval"].ToString();
                                    lblSubTotal.Visible = true;
                                    txtSubTotal.Visible = true;
                                }
                            }

                        }
                    }
                    else 
                    {
                        lblExpSubType.Visible = true;
                        ddlExpSub.Visible = true;
                        RFVExpSubType.Enabled = true;
                    }
                }
            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "OnValueChanged", "OnValueChanged();", true);
    }

    protected void ddlExpSubType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlExpSub = sender as RadComboBox;
        GridEditFormItem editedItem = ddlExpSub.NamingContainer as GridEditFormItem;
        int id = Convert.ToInt32(ddlExpSub.Items[0].Value.ToString());

        htSearchParams = new Hashtable();
        htSearchParams["@expsubtidd"] = id;
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_User_Get_ExpSubTypeDetailById", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DataRow row = dt.Rows[0];
            string measurmenttcod = row["measurmenttcod"].ToString();
            if (!string.IsNullOrEmpty(measurmenttcod))
            {
                Label lblExpenseValue = editedItem.FindControl("lblExpenseValue") as Label;
                Label lblRate = editedItem.FindControl("lblRate") as Label;
                RadNumericTextBox txtRate = editedItem.FindControl("txtRate") as RadNumericTextBox;
                Label lblSubTotal = editedItem.FindControl("lblSubTotal") as Label;
                RadNumericTextBox txtSubTotal = editedItem.FindControl("txtSubTotal") as RadNumericTextBox;

                if (measurmenttcod.ToLower() == "money")
                {
                    lblExpenseValue.Text = "Amount:";
                    lblRate.Visible = false;
                    txtRate.Visible = false;
                    lblSubTotal.Visible = false;
                    txtSubTotal.Visible = false;
                    txtRate.Text = "";
                    txtSubTotal.Text = "";
                }
                else
                {
                    lblExpenseValue.Text = row["unittype"].ToString();
                    lblRate.Visible = true;
                    txtRate.Visible = true;
                    txtRate.Text = row["unitval"].ToString();
                    lblSubTotal.Visible = true;
                    txtSubTotal.Visible = true;
                }
            }

        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "OnValueChanged", "OnValueChanged();", true);
    }
    
    private string GetCalendarID(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);
        //rCmbCalander.ClearSelection();
        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();

        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarID;
        empcalendarID = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][0].ToString();
        return empcalendarID;
    }

    private string GetCalendarCode(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);

        //rCmbCalander.ClearSelection();

        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();

        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarCode;
        empcalendarCode = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][1].ToString();
        return empcalendarCode;
    }

    #endregion

    #region Tab2 - Saved Requests

    protected void gvSavedRequests_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
    }

    protected void gvSavedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);

        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Saved_ReimbursmentT2", ht).Tables[0];
        dt.TableName = "eb_prlreimbT2";
        gvSavedRequests.DataSource = dt;
        gvSavedRequests.DataMember = "eb_prlreimbT2";
        
    }

    protected void gvSavedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@TransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbT2Trx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_ReimbT2Trx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_ReimbT2Trx_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                    break;
                }
        }
    }

    protected void gvSavedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ViewEdit")
        {
            Session["_ReimbCurrtrxNumber"] = e.CommandArgument.ToString();
            Session["_ReimbTab1Function"] = "Edit";
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = true;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            
        } 
        
        if (e.CommandName == "View")
        {
            Session["_ReimbCurrtrxNumber"] = e.CommandArgument.ToString();
            Session["_ReimbTab1Function"] = "View";
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            
        }
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }

        if (e.CommandName == "Delete")
        {
            Hashtable ht_delete = new Hashtable();
            ht_delete.Add("@recidd", e.CommandArgument.ToString());
            clsDAL.ExecuteNonQuery("sp_User_Delete_ReimbursmentT2_trx", ht_delete);
            ShowClientMessage("Transaction No:" + e.CommandArgument.ToString() + "  is Deleted.", MessageType.Success);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }

        if (e.CommandName == "Submit")
        {
            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", formType);
            ht_message.Add("@SubmittedbyUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", 0);

            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

            if (wfid == 0)
            {
                ShowClientMessage("Transaction cannot be submitted due to missing workflow", MessageType.Error);
            }
            else if (wfid > 0)
            {
                Hashtable ht_submit = new Hashtable();
                ht_submit.Add("@ReimbursmentID", e.CommandArgument.ToString());
                ht_submit.Add("@FormTypeID",Request.QueryString["FormType"]);
                ht_submit.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                         


                clsDAL.ExecuteNonQuery("sp_User_Submit_ReimbursmentT2", ht_submit);
                gvSavedRequests.Rebind();
                gvSubmittedRequests.Rebind();

                int rebtrxId = Convert.ToInt32(e.CommandArgument.ToString());
                SendEmail(rebtrxId);

                //Hashtable ht_email = new Hashtable();
                //ht_email.Add("LeaveTransactionID", e.CommandArgument.ToString());

                //DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht_email).Tables[0];

                //if ((null != dt) && dt.Rows.Count > 0)
                //{
                //    string sBody = "";
                //    string htmlEmailFormat = Server.MapPath("~/EmailTemplates/NotifyApplicantApproverEmail.htm");

                //    //sBody = File.ReadAllText(htmlEmailFormat);
                //    //sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                //    //sBody = sBody.Replace("<%ID%>", Request.QueryString["LeaveTransactionID"]);
                //    ////sBody = sBody.Replace("<%FullName%>", txtFirstName.Text + txtMiddleName.Text + txtLastName.Text);
                //    ////sBody = sBody.Replace("<%Position%>", rCmbPosition.SelectedValue.ToString());
                //    ////sBody = sBody.Replace("<%Remarks%>", rTxtRemarks.Text);
                //    //sBody = sBody.Replace("<%RedirectURL%>", Request.Url.AbsoluteUri);
                //    //clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), ConfigurationManager.AppSettings["EMAIL_ACC"], "A request is pending for your approval.");
                //}

                ShowClientMessage("Transaction ID" + e.CommandArgument.ToString() + ": is submitted for approval.", MessageType.Success);
                //clearForm();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            }
        }
    }

    public void SendEmail(int trxId)
    {
        // get email info
        // load email keys columns in email info sp
        Hashtable ht_email = new Hashtable();
        ht_email.Add("@ReimbursmentID", trxId);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbursmentT2_Info_4_Email", ht_email).Tables[0];
        if (dt.Rows.Count > 0)
        {
            string sSubject = string.Empty;
            string sBody = String.Empty;

            // load email template , subject , body with templateid

            Hashtable ht_template = new Hashtable();
            ht_template.Add("@emailtypeId", 1);
            DataTable dtTemplate = clsDAL.GetDataSet("sp_payroll_Get_EmailTemplate", ht_template).Tables[0];
            if (dtTemplate.Rows.Count > 0)
            {
                sSubject = dtTemplate.Rows[0]["subject"].ToString();
                sBody = dtTemplate.Rows[0]["body"].ToString();
                if (!string.IsNullOrEmpty(sBody))
                {
                    sSubject = clsCommon.RefineMessage(sSubject, dt);
                    sBody = clsCommon.RefineMessage(sBody, dt);


                    //call email function SendMail(mailbody,emailto, emailfrom,mailsubject) 
                    clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), string.Empty, sSubject);
                }
            }
        }
    }

    protected void gvSavedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prllevtrx")
        {
            //ImageButton imgBtnEdit = (ImageButton)e.Item.FindControl("imgBtnEdit");
            //imgBtnEdit.Attributes["onclick"] = String.Format("return ShowTab('#tab1');");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //if (imgBtnView != null)
            //   imgBtnView.Attributes["onclick"] = String.Format("return ShowSavedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            //ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            //imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
        }
    }

    protected void gvSavedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prlreimbT2")
        {
            GridDataItem dataItem = e.Item as GridDataItem;

            ImageButton imgBtnDelete = dataItem.FindControl("imgBtnDelete") as ImageButton;
            Hashtable ht = new Hashtable();
            ht["@prmtrx"] = dataItem["column2"].Text;
            DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_RequestStatusIDs_Byprmtrx", ht).Tables[0];
            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                    if (row[0].ToString() == "10")
                    {
                        imgBtnDelete.Visible = false;
                        break;
                    }
            }

        }







        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");
            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];
            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;
            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;
            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;
            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;
            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;
            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;
            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }
            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
            //                cell.CssClass = "MyMexicoRowClass";
        }
    }

    #endregion

    #region Tab3 - Submitted Requests

    protected void gvSubmittedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("recidd").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@TransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbT2Trx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_ReimbT2Trx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_ReimbT2Trx_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);

                    break;
                }
        }
    }

    protected void gvSubmittedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            Session["_ReimbCurrtrxNumber"] = e.CommandArgument.ToString();
            Session["_ReimbTab1Function"] = "View";
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);

        }

        if (e.CommandName == "Recall")
        {
            Hashtable ht = new Hashtable();
            ht["@prmtrx"] = e.CommandArgument.ToString();
            clsDAL.ExecuteNonQuery_payroll("sp_User_Recall_ReimbT2_Transaction", ht);
            gvSubmittedRequests.Rebind();
            gvSavedRequests.Rebind();
        }

        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("ReimbursTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }

    }

    protected void gvSubmittedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {

    }

    protected void gvSubmittedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvSubmittedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID",  Request.QueryString["FormType"]);
       
       
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Submitted_ReimbursmentT2", ht).Tables[0];
        gvSubmittedRequests.DataSource = dt;
    }

    #endregion

    #region Tab4 - Pending Approval

    protected void gvPendingAppRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@TransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbT2Trx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_ReimbT2Trx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_ReimbT2Trx_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab4');", true);

                    break;
                }
        }
    }

    protected void gvPendingAppRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Approve")
        {
            string[] arg = new string[3];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[1]);
            int requestStatusid = Int32.Parse(arg[2]);
            Session["_recidd"] = id;
            Session["_ReimbCurrtrxNumber"] = arg[0].ToString();
            Session["_ReimbTab1Function"] = "Edit";
            Session["_RequestStatusID"] = requestStatusid;
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ApprovalPanel.Visible = true;
            bindCombos();
            gvHistory.Rebind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }
        if (e.CommandName == "View")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[1]);
            Session["_recidd"] = id;
            Session["_ReimbCurrtrxNumber"] = arg[0].ToString();
            Session["_ReimbTab1Function"] = "View";
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);

        } 
    }

    protected void gvPendingAppRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //ImageButton imgBtnApprove = (ImageButton)e.Item.FindControl("imgBtnApprove");
            //if (imgBtnApprove != null)
            //{
            //    imgBtnApprove.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
            //        e.Item.ItemIndex,
            //        e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
            //        Request.QueryString["FormType"]);
            //}

            //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            //if (imgBtnView != null)
            //    imgBtnView.Attributes["onclick"] = String.Format("return ShowPendingViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        }
    }

    protected void gvPendingAppRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@ApproverUserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbursmentT2_For_Approval", ht).Tables[0];
        gvPendingAppRequests.DataSource = dt;
    }

    protected void gvPendingAppRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }

    }

    #endregion

    #region Tab5 - Approval Requests

    protected void gvApprovedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@TransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_ReimbT2Trx_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_ReimbT2Trx_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_ReimbT2Trx_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab5');", true);

                    break;
                }
        }
    }

    protected void gvApprovedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["IdTemplate"] = arg[0];
            int id = Int32.Parse(arg[1]);
            Session["_recidd"] = id;
            Session["_ReimbCurrtrxNumber"] = arg[0].ToString();
            Session["_ReimbTab1Function"] = "View";
            gvReimbursment.Rebind();
            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;
            TopPanel.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);

    }
    }

    protected void gvApprovedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        //ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        //if (imgBtnView != null)
        //{
        //    imgBtnView.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
        //                       e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
        //                       e.Item.ItemIndex,
        //                       e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
        //                       Request.QueryString["FormType"]);
        //}
    }

    protected void gvApprovedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvApprovedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_Approved_ReimbursmentT2", ht).Tables[0];
        gvApprovedRequests.DataSource = dt;
    }

    #endregion

    

    protected void rGrdCountry4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        htSearchParams = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_getallcountries", htSearchParams).Tables[0];
    }
    protected void rGrdProvince4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid prvgrid = sender as RadGrid;
        RadComboBox ddlProvince = prvgrid.Parent.Parent as RadComboBox;
        if (ddlProvince != null)
        {
            RadComboBox ddlCountry = ddlProvince.Parent.FindControl("ddlCountry") as RadComboBox;
            if (ddlCountry != null)
            {
                if (!String.IsNullOrEmpty(ddlCountry.Items[0].Value))
                {
                    htSearchParams = new Hashtable();
                    htSearchParams["@ID"] = Convert.ToInt32(ddlCountry.Items[0].Value);
                    prvgrid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetCountryProvinces", htSearchParams).Tables[0];
                }
            }
        }
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlCountry = sender as RadComboBox;

        RadComboBox ddlProvince = (ddlCountry.Parent.FindControl("ddlProvince") as RadComboBox);
        if (ddlProvince != null)
        {
            ddlProvince.Items[0].Value = "";
            ddlProvince.Items[0].Text = "";
            ddlProvince.SelectedValue = "";
            RadGrid PrvGrid = ddlProvince.Items[0].FindControl("rGrdProvince4DDL") as RadGrid;
            if (PrvGrid != null)
            {
                PrvGrid.Rebind();

                string id = "True";
                foreach (GridItem item in PrvGrid.MasterTableView.Items)
                {
                    if (item is GridDataItem)
                    {
                        if (id.Equals(item.OwnerTableView.DataKeyValues[item.ItemIndex]["defval"].ToString()))
                        {
                            ddlProvince.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                            ddlProvince.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prvcod"].ToString();
                            ddlProvince.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                            break;
                        }
                        else if (item.ItemIndex == 0)
                        {
                            ddlProvince.Items[0].Value = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                            ddlProvince.Items[0].Text = item.OwnerTableView.DataKeyValues[item.ItemIndex]["prvcod"].ToString();
                            ddlProvince.SelectedValue = item.OwnerTableView.DataKeyValues[item.ItemIndex]["recidd"].ToString();
                        }
                    }
                }
            }
        }
    }






}

