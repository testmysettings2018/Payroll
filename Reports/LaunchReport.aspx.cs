using System;
using Telerik.Reporting;
using ebPayrollReports.Reports;

public partial class Reports_LaunchReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string Reportname = "ReimbursmentT2byID";
        //string RequestId = "1042";
        //callreport(RequestId, Reportname);

        if (!string.IsNullOrEmpty(Request.QueryString["Reportname"]) && !string.IsNullOrEmpty(Request.QueryString["RequestId"]))
        {
            string rptStr = Request.QueryString["Reportname"].ToString();
            string Reportname = clsEncryption.DecryptData(rptStr);

            string RequestId = clsEncryption.DecryptData(Request.QueryString["RequestId"].ToString());

            if (!string.IsNullOrEmpty(Reportname) && !string.IsNullOrEmpty(RequestId))
                callreport(RequestId, Reportname);
        }
        else if (!string.IsNullOrEmpty(Request.QueryString["Reportname"]))
        {
            string rptStr = Request.QueryString["Reportname"].ToString();
            string Reportname = clsEncryption.DecryptData(rptStr);

            if (!string.IsNullOrEmpty(Reportname))
                callreport(Reportname);
        }
    }

    // call report with reportname only
    void callreport(string Reportname)
    {
        Telerik.Reporting.TypeReportSource typeReportSource =
            new Telerik.Reporting.TypeReportSource();
        string reportname;
        reportname = Reportname;
        switch (reportname)
        {
            #region Master

            case "Action Maintenance":
                ActionIDMaintenance ActionMaintenance = new ActionIDMaintenance();
                typeReportSource.TypeName = typeof(ActionIDMaintenance).AssemblyQualifiedName;
                break;

            case "Batch Setup":
                BatchMaster BatchList = new BatchMaster();
                typeReportSource.TypeName = typeof(BatchMaster).AssemblyQualifiedName;
                break;

            case "Company Asset Setup":

                //CompanyAssetMaster companyAsset = new CompanyAssetMaster();
                //typeReportSource.TypeName = typeof(CompanyAssetMaster).AssemblyQualifiedName;
                break;

            case "Complain Code Setup":
                ComplainMaster complainCode = new ComplainMaster();
                typeReportSource.TypeName = typeof(ComplainMaster).AssemblyQualifiedName;
                break;

            case "Country Setup":
                CountrySetup countrySetup = new CountrySetup();
                typeReportSource.TypeName = typeof(CountrySetup).AssemblyQualifiedName;
                break;

            case "Daytype Setup":
                DayMaster dayTYpeSetup = new DayMaster();
                typeReportSource.TypeName = typeof(DayMaster).AssemblyQualifiedName;
                break;

            case "Division Setup":
                DivisionMaster divisionMaster = new DivisionMaster();
                typeReportSource.TypeName = typeof(DivisionMaster).AssemblyQualifiedName;
                break;

            case "Facility Setup":
                FacilitiesMaster facilitiesMaster = new FacilitiesMaster();
                typeReportSource.TypeName = typeof(FacilitiesMaster).AssemblyQualifiedName;
                break;

            case "Nationality Setup":
                NationalityMaster nationalityMaster = new NationalityMaster();
                typeReportSource.TypeName = typeof(NationalityMaster).AssemblyQualifiedName;
                break;

            case "Religion Setup":
                ReligionMaster religionMaster = new ReligionMaster();
                typeReportSource.TypeName = typeof(ReligionMaster).AssemblyQualifiedName;
                break;

            case "Room Setup":
                RoomMaster roomMaster = new RoomMaster();
                typeReportSource.TypeName = typeof(RoomMaster).AssemblyQualifiedName;
                break;

            case "Suggestion Master":
                SuggestionMaster suggestionMaster = new SuggestionMaster();
                typeReportSource.TypeName = typeof(SuggestionMaster).AssemblyQualifiedName;
                break;
                
            case "Employer Setup":
                EmployerMaster employerMaster = new EmployerMaster();
                typeReportSource.TypeName = typeof(EmployerMaster).AssemblyQualifiedName;
                break;

            case "Loan Type":
                SuggestionMaster suggestionMaster1 = new SuggestionMaster();
                typeReportSource.TypeName = typeof(SuggestionMaster).AssemblyQualifiedName;
                break;

            #endregion

            #region Setup

            case "Attendence Machine":
                AttendenceSetup AttendenceSetup = new AttendenceSetup();
                typeReportSource.TypeName = typeof(AttendenceSetup).AssemblyQualifiedName;
                break;
            
            case "Benefit Setup":
                BenefitMaster BenefitMaster = new BenefitMaster();
                typeReportSource.TypeName = typeof(BenefitMaster).AssemblyQualifiedName;
                break;

            case "Branch Setup":
                BranchMaster branchmaster = new BranchMaster();
                typeReportSource.TypeName = typeof(BranchMaster).AssemblyQualifiedName;
                break;

            case "Calender Setup":
                CalenderSetup CalenderList = new CalenderSetup();
                typeReportSource.TypeName = typeof(CalenderSetup).AssemblyQualifiedName;
                break;

            case "Deduction Setup":
                DeductionMaster DeductionList = new DeductionMaster();
                typeReportSource.TypeName = typeof(DeductionMaster).AssemblyQualifiedName;
                break;

            case "Employee Class Setup":
                ClassMaster classMaster = new ClassMaster();
                typeReportSource.TypeName = typeof(ClassMaster).AssemblyQualifiedName;
                break;

            case "End of Service Master":
                EOSMaster eOSList = new EOSMaster();
                typeReportSource.TypeName = typeof(EOSMaster).AssemblyQualifiedName;
                break;

            case "Grade Setup":
                EOSMaster eOSList1 = new EOSMaster();
                typeReportSource.TypeName = typeof(EOSMaster).AssemblyQualifiedName;
                break;

            case "Gratuity Setup":
                GratuitySetup GratuityList = new GratuitySetup();
                typeReportSource.TypeName = typeof(GratuitySetup).AssemblyQualifiedName;
                break;

            case "Leave Assignment":
                LeaveMasterMaster LeaveCodeList = new LeaveMasterMaster();
                typeReportSource.TypeName = typeof(LeaveMasterMaster).AssemblyQualifiedName;
                break;

            case "Leave Type":
                LeaveMasterMaster LeaveCodeList1 = new LeaveMasterMaster();
                typeReportSource.TypeName = typeof(LeaveMasterMaster).AssemblyQualifiedName;
                break;

            case "Overtime Setup":
                OvertimeSetup OvertimeList = new OvertimeSetup();
                typeReportSource.TypeName = typeof(OvertimeSetup).AssemblyQualifiedName;
                break;

            case "Pay Code Setup":
                PaycodeMaster PaycodeList = new PaycodeMaster();
                typeReportSource.TypeName = typeof(PaycodeMaster).AssemblyQualifiedName;
                break;

            case "Position Setup":
                PositionSetup PositionList = new PositionSetup();
                typeReportSource.TypeName = typeof(PositionSetup).AssemblyQualifiedName;
                break;

            case "Project Setup":
                ProjectMaster ProjectList = new ProjectMaster();
                typeReportSource.TypeName = typeof(ProjectMaster).AssemblyQualifiedName;
                break;

            case "Supervisor Setup":
                SuperviserSetup SuperviserList = new SuperviserSetup();
                typeReportSource.TypeName = typeof(SuperviserSetup).AssemblyQualifiedName;
                break;

            case "Transaction Sequence":
                TransactionSequence TransactionSequenceList = new TransactionSequence();
                typeReportSource.TypeName = typeof(TransactionSequence).AssemblyQualifiedName;
                break;

            #endregion

            #region Employee

            case "Employee Pay Code":
                EmployeeMonthlySalary employeeMonthlySalary = new EmployeeMonthlySalary();
                typeReportSource.TypeName = typeof(EmployeeMonthlySalary).AssemblyQualifiedName;
                break;

            case "Employee Address":
                EmployeeAddresslist employeeAddresslist = new EmployeeAddresslist();
                typeReportSource.TypeName = typeof(EmployeeAddresslist).AssemblyQualifiedName;
                break;

            case "Employee Card":
                EmployeeCard employeeCard = new EmployeeCard();
                typeReportSource.TypeName = typeof(EmployeeCard).AssemblyQualifiedName;
                break;

            case "Employee Contract":
                EmployeeContractlist employeeContractlist = new EmployeeContractlist();
                typeReportSource.TypeName = typeof(EmployeeContractlist).AssemblyQualifiedName;
                break;

            case "Employee IBAN":
                EmployeeIBANChecking employeeIBANChecking = new EmployeeIBANChecking();
                typeReportSource.TypeName = typeof(EmployeeIBANChecking).AssemblyQualifiedName;
                break;

            case "Employee Master":
                EmployeeMasterList employeeMasterList = new EmployeeMasterList();
                typeReportSource.TypeName = typeof(EmployeeMasterList).AssemblyQualifiedName;
                break;

            case "Employee Personal Info":
                EmployeePersonalinfo employeePersonalinfo = new EmployeePersonalinfo();
                typeReportSource.TypeName = typeof(EmployeePersonalinfo).AssemblyQualifiedName;
                break;

            //case "Employee Master":
            //    Employeemaster employeePersonalinfo = new EmployeePersonalinfo();
            //    typeReportSource.TypeName = typeof(EmployeePersonalinfo).AssemblyQualifiedName;
            //    break;
            
            #endregion

           
            case "BenefitDetailList":

                BenefitDetailDRL BenefitDetailList = new BenefitDetailDRL();
                typeReportSource.TypeName = typeof(BenefitDetailDRL).AssemblyQualifiedName;
                break;
            case "BranchList":

                BranchMaster BranchList = new BranchMaster();
                typeReportSource.TypeName = typeof(BranchMaster).AssemblyQualifiedName;
                break;
            case "ClassList":

                ClassMaster ClassList = new ClassMaster();
                typeReportSource.TypeName = typeof(ClassMaster).AssemblyQualifiedName;
                break;
            case "DeductionWithDetailList":

                DeductionDetailDRL DeductionWithDetailList = new DeductionDetailDRL();
                typeReportSource.TypeName = typeof(DeductionDetailDRL).AssemblyQualifiedName;
                break;
                /* case "DeductionDetailList":

                DeductionWithDetailList DeductionDetailList = new DeductionWithDetailList();
                typeReportSource.TypeName = typeof(DeductionWithDetailList).AssemblyQualifiedName;
                break;
                */
          
           
            case "GratuitywithDetailList":

                GratuitySetupDRL GratuitywithDetailList = new GratuitySetupDRL();
                typeReportSource.TypeName = typeof(GratuitySetupDRL).AssemblyQualifiedName;
                break;
            case "GratuityDTLList":

                GratuitySetupDTL GratuityDTLList = new GratuitySetupDTL();
                typeReportSource.TypeName = typeof(GratuitySetupDTL).AssemblyQualifiedName;
                break;
            case "GratuityPaycodeList":

                GratuityPaycode GratuityPaycodeList = new GratuityPaycode();
                typeReportSource.TypeName = typeof(GratuityPaycode).AssemblyQualifiedName;
                break;
           
            case "LeavePatternList":

                LeavePattern LeavePatternList = new LeavePattern();
                typeReportSource.TypeName = typeof(LeavePattern).AssemblyQualifiedName;
                break;
           
            case "OvertimeWithDetailList":

                OvertimeSetupDRL OvertimeWithDetailList = new OvertimeSetupDRL();
                typeReportSource.TypeName = typeof(OvertimeSetupDRL).AssemblyQualifiedName;
                break;
            case "OvertimeDTLList":

                OvertimeSetupDTL OvertimeDTLList = new OvertimeSetupDTL();
                typeReportSource.TypeName = typeof(OvertimeSetupDTL).AssemblyQualifiedName;
                break;
            case "OvertimePaycodeList":

                OvertimePaycode OvertimePaycodeList = new OvertimePaycode();
                typeReportSource.TypeName = typeof(OvertimePaycode).AssemblyQualifiedName;
                break;
          
              
            #region Leave Transaction Reports

            case "LeavetransactionbyID":

                LeaveTrxEntryByID LeaveTransaction = new LeaveTrxEntryByID();
                typeReportSource.TypeName = typeof(LeaveTrxEntryByID).AssemblyQualifiedName;
                break;

            #endregion

        }
       ReportViewer1.ReportSource = typeReportSource;
        ReportViewer1.RefreshReport();
    }

    // call report with reportname and id param
    void callreport(string RequestId,string Reportname)
    {

        Telerik.Reporting.InstanceReportSource typeInstanceSource = new Telerik.Reporting.InstanceReportSource();

        Telerik.Reporting.TypeReportSource typeReportSource =
            new Telerik.Reporting.TypeReportSource();
        string reportname;
        reportname = Reportname;

        switch (reportname)
        {
            #region Transaction

            case "LeaveTrxEntryByID":
                LeaveTrxEntryByID LeaveTransaction = new LeaveTrxEntryByID();
                typeReportSource.TypeName = typeof(LeaveTrxEntryByID).AssemblyQualifiedName;
                typeReportSource.Parameters.Add("ID", RequestId);
                break;

            case "ReimbursTrxEntryByID":
                ReimbursTrxEntryByID reimbursTrxEntryByID = new ReimbursTrxEntryByID();
                typeReportSource.TypeName = typeof(ReimbursTrxEntryByID).AssemblyQualifiedName;
                typeReportSource.Parameters.Add("RecordID", RequestId);
                break;

            case "ReimbursmentT2byID":


                ebPayrollReports.Transactions.ID.ReimbursmentT2byID ReimbursmentT2byID = new ebPayrollReports.Transactions.ID.ReimbursmentT2byID();
                typeReportSource.TypeName = typeof(ebPayrollReports.Transactions.ID.ReimbursmentT2byID).AssemblyQualifiedName;
                typeReportSource.Parameters.Add(new Telerik.Reporting.Parameter("RecordID", RequestId));
                break;

            case "TimeSheetbyProject2":

                //var report = new ebPayrollReports.Transactions.Form.TimeSheetbyProject();
                //typeInstanceSource.ReportDocument = report;
                //this.ReportViewer1.ReportSource = typeInstanceSource;
                //report.ReportParameters[0].Value = RequestId;

                ebPayrollReports.Transactions.Form.TimeSheetbyProject f  = new ebPayrollReports.Transactions.Form.TimeSheetbyProject();
                break;
              
            case "TimeSheetbyProject":
                
                var report = new ebPayrollReports.Transactions.Form.TimeSheetbyProject();
                typeInstanceSource.ReportDocument = report;
                this.ReportViewer1.ReportSource = typeInstanceSource;
                report.ReportParameters[0].Value = RequestId;
                break;

            case "TimeSheetbyProjectLogs":

               var report2 = new ebPayrollReports.Transactions.Form.TimeSheetProjectLogs();
                typeInstanceSource.ReportDocument = report2;
                this.ReportViewer1.ReportSource = typeInstanceSource;
                report2.ReportParameters[0].Value = RequestId;
                         
          


                break;

            #endregion

        }
        
       ReportViewer1.RefreshReport();
    }

}