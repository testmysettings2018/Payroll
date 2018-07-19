using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_PayrollSetup : System.Web.UI.Page
{
    public static Hashtable htSearchParams = null;
    
    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
            LoadPrintOptions();
        }
    }

    // print ddl data loading and binding
    public void LoadPrintOptions()
    {
        Hashtable ht_Reports = new Hashtable();
        ht_Reports.Add("@userid", Session["_UserID"].ToString());
        ht_Reports.Add("@formtypeid", 3093); // payroll setup form type = 3093
        DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];

        if (dt_Reports != null)
        {
            ddlPrintOptions.DataSource = dt_Reports;
            ddlPrintOptions.DataTextField = "reportname";
            ddlPrintOptions.DataValueField = "idd";
            ddlPrintOptions.DataBind();
            ddlPrintOptions.SelectedIndex = 0;
        }
    }
    
    // form data load function
    public void LoadData()
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Payroll", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            chkbxAutoAssignEmployeeId.Checked = Convert.ToBoolean(dt.Rows[0]["prlaut"].ToString());

            txtbxPayrollCuttoffDay.Text = dt.Rows[0]["prlcut"].ToString();
            txtOvertimeCuttoffDay.Text = dt.Rows[0]["prlovcd"].ToString();

            txtbxUptoAge.Text = dt.Rows[0]["prlupt"].ToString();
            txtbxChildAge.Text = dt.Rows[0]["prlchl"].ToString();
            txtbxInfantAge.Text = dt.Rows[0]["prlinf"].ToString();
            txtbxMaxChildren.Text = dt.Rows[0]["prlmxc"].ToString();

            chkbxAllowAdvanceLeave.Checked = Convert.ToBoolean(dt.Rows[0]["prlchlt"].ToString());

            string prlclt = dt.Rows[0]["prlclt"].ToString();
            string prlcltvalue = dt.Rows[0]["prlclttext"].ToString();

            if (ddlDefaultPayrollTypeon != null)
            {
                RadGrid grid = ddlDefaultPayrollTypeon.Items[0].FindControl("rGrdDefaultPayrollTypeon4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlclt) && !string.IsNullOrEmpty(prlcltvalue))
                {
                    ddlDefaultPayrollTypeon.Items[0].Value = prlclt;
                    ddlDefaultPayrollTypeon.Items[0].Text = prlcltvalue;
                    ddlDefaultPayrollTypeon.Text = prlcltvalue;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlclt.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlenc = dt.Rows[0]["prlenc"].ToString();
            string prlencvalue = dt.Rows[0]["prlenctext"].ToString();

            if (ddlLeaveEnchasment != null)
            {
                RadGrid grid = ddlLeaveEnchasment.Items[0].FindControl("rGrdLeaveEnchasment4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlenc) && !string.IsNullOrEmpty(prlcltvalue))
                {
                    ddlLeaveEnchasment.Items[0].Value = prlenc;
                    ddlLeaveEnchasment.Items[0].Text = prlencvalue;
                    ddlLeaveEnchasment.Text = prlencvalue;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlenc.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlsal = dt.Rows[0]["prlsal"].ToString();
            string prlsaltext = dt.Rows[0]["prlsaltext"].ToString();

            if (ddlEmployeeSalaryCalculation != null)
            {
                RadGrid grid = ddlEmployeeSalaryCalculation.Items[0].FindControl("rEmployeeSalaryCalculation4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlsal) && !string.IsNullOrEmpty(prlsaltext))
                {
                    ddlEmployeeSalaryCalculation.Items[0].Value = prlsal;
                    ddlEmployeeSalaryCalculation.Items[0].Text = prlsaltext;
                    ddlEmployeeSalaryCalculation.Text = prlsaltext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlsal.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlgri = dt.Rows[0]["prlgri"].ToString();
            string prlgrtext = dt.Rows[0]["prlgrtext"].ToString();

            if (ddlGraduity != null)
            {
                RadGrid grid = ddlGraduity.Items[0].FindControl("rGrdGraduity4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlgri) && !string.IsNullOrEmpty(prlgrtext))
                {
                    ddlGraduity.Items[0].Value = prlgri;
                    ddlGraduity.Items[0].Text = prlgrtext;
                    ddlGraduity.Text = prlgrtext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlgri.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlcli = dt.Rows[0]["prlcli"].ToString();
            string prlcltext = dt.Rows[0]["prlcltext"].ToString();

            if (ddldftCalender != null)
            {
                RadGrid grid = ddldftCalender.Items[0].FindControl("rGrddftCalender4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlcli) && !string.IsNullOrEmpty(prlgrtext))
                {
                    ddldftCalender.Items[0].Value = prlcli;
                    ddldftCalender.Items[0].Text = prlcltext;
                    ddldftCalender.Text = prlcltext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlcli.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prscti = dt.Rows[0]["prscti"].ToString();
            string prsctc = dt.Rows[0]["prsctcname"].ToString();

            if (ddlCountry != null)
            {
                RadGrid grid = ddlCountry.Items[0].FindControl("rGrdCountry4DDL") as RadGrid;
                grid.Rebind();
                if (!string.IsNullOrEmpty(prscti) && !string.IsNullOrEmpty(prsctc))
                {
                    ddlCountry.Items[0].Value = prscti;
                    ddlCountry.Items[0].Text = prsctc;
                    ddlCountry.Text = prsctc;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prscti.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlovi = dt.Rows[0]["prlovi"].ToString();
            string prlovname = dt.Rows[0]["prlovname"].ToString();

            if (ddldftOvertime != null)
            {
                RadGrid grid = ddldftOvertime.Items[0].FindControl("rGrddftOvertime4DDL") as RadGrid;
                grid.Rebind();
                if (!string.IsNullOrEmpty(prlovi) && !string.IsNullOrEmpty(prlovname))
                {
                    ddldftOvertime.Items[0].Value = prlovi;
                    ddldftOvertime.Items[0].Text = prlovname;
                    ddldftOvertime.Text = prlovname;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlovi.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlpci = dt.Rows[0]["prlpci"].ToString();
            string prlpcname = dt.Rows[0]["prlovname"].ToString();

            if (ddlOvertimePaycode != null)
            {
                RadGrid grid = ddlOvertimePaycode.Items[0].FindControl("rGrdOvertimePaycode4DDL") as RadGrid;
                grid.Rebind();
                if (!string.IsNullOrEmpty(prlpci) && !string.IsNullOrEmpty(prlpcname))
                {
                    ddlOvertimePaycode.Items[0].Value = prlpci;
                    ddlOvertimePaycode.Items[0].Text = prlpcname;
                    ddlOvertimePaycode.Text = prlpcname;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlpci.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlrds = dt.Rows[0]["prlrds"].ToString();
            string prlrdstext = dt.Rows[0]["prlrdstext"].ToString();

            if (dllDftRollDown != null)
            {
                RadGrid grid = dllDftRollDown.Items[0].FindControl("rGrdDftRollDown4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlrds) && !string.IsNullOrEmpty(prlrdstext))
                {
                    dllDftRollDown.Items[0].Value = prlrds;
                    dllDftRollDown.Items[0].Text = prlrdstext;
                    dllDftRollDown.Text = prlrdstext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlrds.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prlode = dt.Rows[0]["prlode"].ToString();
            string prlodetext = dt.Rows[0]["prlodetext"].ToString();

            if (ddlOvertimeDataEntry != null)
            {
                RadGrid grid = ddlOvertimeDataEntry.Items[0].FindControl("rOvertimeDataEntry4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prlode) && !string.IsNullOrEmpty(prlodetext))
                {
                    ddlOvertimeDataEntry.Items[0].Value = prlode;
                    ddlOvertimeDataEntry.Items[0].Text = prlodetext;
                    ddlOvertimeDataEntry.Text = prlodetext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prlode.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["ValueSetID"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }

            string prltbi = dt.Rows[0]["prltbi"].ToString();
            string prltbitext = dt.Rows[0]["prltbitext"].ToString();

            if (ddlTicketBnefit != null)
            {
                RadGrid grid = ddlTicketBnefit.Items[0].FindControl("rGrdTicketBnefit4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prltbi) && !string.IsNullOrEmpty(prltbitext))
                {
                    ddlTicketBnefit.Items[0].Value = prltbi;
                    ddlTicketBnefit.Items[0].Text = prltbitext;
                    ddlTicketBnefit.Text = prltbitext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prltbi.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }


            string prltbp = dt.Rows[0]["prltbp"].ToString();
            string prltbptext = dt.Rows[0]["prltbptext"].ToString();

            if (ddlTicketPaycode != null)
            {
                RadGrid grid = ddlTicketPaycode.Items[0].FindControl("rGrdTicketPaycode4DDL") as RadGrid;
                grid.Rebind();

                if (!string.IsNullOrEmpty(prltbp) && !string.IsNullOrEmpty(prltbptext))
                {
                    ddlTicketPaycode.Items[0].Value = prltbp;
                    ddlTicketPaycode.Items[0].Text = prltbptext;
                    ddlTicketPaycode.Text = prltbptext;

                    foreach (GridItem item in grid.MasterTableView.Items)
                    {
                        if (item is GridDataItem)
                        {
                            GridDataItem dataItem = (GridDataItem)item;
                            if (prltbp.Equals(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString()))
                            {
                                dataItem.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
    }

    // form update command
    protected void rbutUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            Hashtable newValues = new Hashtable();

            newValues["@prscti"] = ddlCountry.Items[0].Value.Trim();
            newValues["@prlclt"] = ddlDefaultPayrollTypeon.Items[0].Value.Trim();
            newValues["@prlenc"] = ddlLeaveEnchasment.Items[0].Value.Trim();
            newValues["@prlsal"] = ddlEmployeeSalaryCalculation.Items[0].Value.Trim();

            newValues["@prlgri"] = ddlGraduity.Items[0].Value.Trim();
            newValues["@prlovi"] = ddldftOvertime.Items[0].Value.Trim();
            newValues["@prlcli"] = ddldftCalender.Items[0].Value.Trim();
            newValues["@prlrds"] = dllDftRollDown.Items[0].Value.Trim();
            newValues["@prlaut"] = chkbxAutoAssignEmployeeId.Checked;

            newValues["@prlcut"] = txtbxPayrollCuttoffDay.Text;
            newValues["@prlovcd"] = txtOvertimeCuttoffDay.Text;
            newValues["@prlode"] = ddlOvertimeDataEntry.Items[0].Value.Trim();
            newValues["@prlpci"] = ddlOvertimePaycode.Items[0].Value.Trim();

            newValues["@prltbi"] = ddlTicketBnefit.Items[0].Value.Trim();
            newValues["@prltbp"] = ddlTicketPaycode.Items[0].Value.Trim();

            newValues["@prlupt"] = txtbxUptoAge.Text;
            newValues["@prlchl"] = txtbxChildAge.Text;
            newValues["@prlinf"] = txtbxInfantAge.Text;
            newValues["@prlmxc"] = txtbxMaxChildren.Text;

            newValues["@prlchlt"] = chkbxAllowAdvanceLeave.Checked;

            newValues["@DBMessage"] = "";

            string DBMessage = "";
            DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_PayrollRecord", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage(DBMessage,
                    MessageType.Error);
            }
            ShowClientMessage("Payroll record saved successfully.", MessageType.Success);
            LoadData();
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to save Payroll record. Reason: " + ex.Message, MessageType.Error);
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

    // gratuity ddl data loading and binding
    protected void rGrdGraduity4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Gratuity_Records", htSearchParams).Tables[0];
    }

    // default calender ddl data loading and binding
    protected void rGrddftCalender4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllCalenderRecords", htSearchParams).Tables[0];
    }

    // country ddl data loading and binding
    protected void rGrdCountry4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_getallcountries", htSearchParams).Tables[0];
    }

    // ticket paycode ddl data loading and binding
    protected void rGrdTicketPaycode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // overtime paycode ddl data loading and binding
    protected void rGrdOvertimePaycode4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_PayCode_Records", htSearchParams).Tables[0];
    }

    // ticket benefit ddl data loading and binding
    protected void rGrdTicketBnefit4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_BenefitCode_Records", htSearchParams).Tables[0];
    }

    // default overtime ddl data loading and binding
    protected void rGrddftOvertime4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllOvertimeRecords", htSearchParams).Tables[0];
    }

    // leave enchasement ddl data loading and binding
    protected void rGrdLeaveEnchasment4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.LeaveEncashment, -1, 1).Tables[0];
    }

    // default payroll type ddl data loading and binding
    protected void rGrdDefaultPayrollTypeon4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.DefaultPayrollType, -1, 1).Tables[0];
    }

    // overtime data entry ddl data loading and binding
    protected void rGrdOvertimeDataEntry4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.OvertimeDataEntry, -1, 1).Tables[0];
    }

    // overtime data entry ddl data loading and binding
    protected void rOvertimeDataEntry4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.OvertimeDataEntry, -1, 1).Tables[0];
    }

    // employee salary ddl data loading and binding
    protected void rEmployeeSalaryCalculation4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.EmployeeSalaryCalculation, -1, 1).Tables[0];
    }

    // roll down ddl data loading and binding
    protected void rGrdDftRollDown4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID_FromPayroll(Constraints.DropDownLists.DefaultRolldownSetting, -1, 1).Tables[0];
    }

    // print command
    protected void btnNationalityPrint_Click(object sender, EventArgs e)
    {

    }
}