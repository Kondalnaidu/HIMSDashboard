//
//  ConstantVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 19/07/23.
//

import Foundation
import Alamofire
let baseUrl = "https://wa.athentech.co.in/AppAuthV2/api/"
let newHeaderss: HTTPHeaders = [
    "Content-Type": "application/json",
    "Accept": "application/json"]
var finanialArr = ["Out Patient","In Patient","Pharmacy","Diagnostics","Total","Expenditure"]
var patientArr = ["New patient","Old Patient","Total Patient"]
var admissionArr = ["Discharge","Admission","Occupancy"]
var monthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var sideMenuArray = ["Doctor Wise Revenue", "Admission Count", "General Report", "Doctor Count Analysis", "GST Summary", "GST Monthly", "Log Out"]
var sideMenuImageArray = ["notification", "notification", "notification", "notification", "notification", "notification", "notification", "notification"]
var typeArray = ["ALL", "OP", "IP"]
var saleTypeArray = ["Sales","Purchase"]
var licenseKey = "9WYT84LG"

struct Apis {
    static let licenseApi = baseUrl+"AppAuthentication/KeyValidation?key="
    static let homeSummerApi = "api/AppHimsDashBoard/SummaryDetails?fromdate="
    static let patientCountApi = "api/AppHimsDashBoard/PatientCount?fromdate="
    static let admissionApi = "api/AppHimsDashBoard/AdmissionDischargeCount?fromdate="
    static let weeklySummerDetailApi = "api/AppHimsDashBoard/WeekwiseSummaryDetails?fromdate="
    static let loginApi = "api/AppHimsDashBoard/Login?"
    static let opDetails = "api/AppHimsDashBoard/OPDetails?fromdate="
    static let inDetails = "api/AppHimsDashBoard/IPDetails?fromdate="
    static let pharmacyDetail = "api/AppHimsDashBoard/PharmaDetails?fromdate="
    static let expDetailsApi = "api/AppHimsDashBoard/ExpDetails?fromdate="
    static let diagonsticDetail = "api/AppHimsDashBoard/DiagDetails?fromdate="
    static let totalSummeryDetails = "api/AppHimsDashBoard/TotalSummaryDtls?fromdate="
    static let dischargeCoutAPi = "api/AppHimsDashBoard/AdmissionDischargeCount?fromdate="
    static let opReportAPi = "api/AppHimsDashBoard/OPReports?fromdate="
    static let ipReportApi = "api/AppHimsDashBoard/IPReports?fromdate="
    static let diagoReports = "/api/AppHimsDashBoard/DiagReports?fromdate="
    static let pharmacyReport = "/api/AppHimsDashBoard/PharmacyReports?fromdate="
    static let dischargeReportApi = "/api/AppHimsDashBoard/DischargeReport?fromdate="
    static let admissionReportApi = "/api/AppHimsDashBoard/AdmissionReport?fromdate="
    static let occupancyReportApi = "/api/AppHimsDashBoard/BedOccupancyReport"
    static let getDoctors = "https://app.athentech.in/AppHDB/ParamithaKPT/getDoctors"
    static let doctorsRevenueApi = "/DoctorwiseRevenue?"
    static let AdmissionCount = "AdmissionCount?"
    static let PatientDtlsCash = "PatientDtlsCash?"
    static let DoctorwiseCount = "/DoctorwiseCount?"
    static let admissionDischargeWeekwise = "/api/AppHimsDashBoard/AdmissionDischargeWeekwise?fromdate="
    static let gstSummary = "api/AppHimsDashBoard/GSTSalesSummaryReport?"
    static let gstPurchase = "/api/AppHimsDashBoard/GSTPurchaseSummaryReport?"
    static let gstSaleMonthly = "/api/AppHimsDashBoard/GSTSalesMonthlyReport?"
    static let gstPurchaseMonthly = "/api/AppHimsDashBoard/GSTPurchaseMonthlyReport?"
}
struct StoryBoardIdentifiers {
    static let SideMenuVC = "SideMenuVC"
    static let LoginVC = "LoginVC"
    static let HomeVC = "HomeVC"
    static let DoctorHomeVc = "DoctorHomeVc"
    static let DashBoardVC = "DashBoardVC"
    static let LicenseVC = "LicenseVC"
    static let FullBarchatVC = "FullBarchatVC"
    static let FinanceGlanceDetailCell = "FinanceGlanceDetailCell"
    static let financeGlanceDetialHeaderCell = "financeGlanceDetialHeaderCell"
    static let DischargeDetailVC = "DischargeDetailVC"
    static let FinanceGlanceDetailVC = "FinanceGlanceDetailVC"
    static let TotalSummeryVC = "TotalSummeryVC"
    static let ExpendtureVC = "ExpendtureVC"
    static let GSTMonthlyCell = "GSTMonthlyCell"
    static let GSTMonthlyTitleCell = "GSTMonthlyTitleCell"
    static let GSTMonthlyDataCell = "GSTMonthlyDataCell"
    static let GSTMonthlyTotalCell = "GSTMonthlyTotalCell"
    static let DoctorWiseRevenueCell = "DoctorWiseRevenueCell"
    static let RevenueMothWiseCell = "RevenueMothWiseCell"
    static let RevenueDetailMothlyCell = "RevenueDetailMothlyCell"
    static let RevenueTotalCell = "RevenueTotalCell"
    static let SideMenuTableCell = "SideMenuTableCell"
    static let DoctorWiseRevenueVC = "DoctorWiseRevenueVC"
    static let AdmissionVC = "AdmissionVC"
    static let StoryBoardIdentifiers = "StoryBoardIdentifiers"
    static let GSTMonthlyVC = "GSTMonthlyVC"
    static let GSTSummaryVC = "GSTSummaryVC"
    static let PdfVC = "PdfVC"
    static let AdmissionWebVC = "AdmissionWebVC"
    static let AdmissionBottomCell = "AdmissionBottomCell"
    static let AdmissionHeaderCell = "AdmissionHeaderCell"
    static let AdmissionDataCell = "AdmissionDataCell"
    
}
enum MonthKeys {
    static let January = "January"
    static let February = "February"
    static let March = "March"
    static let April = "April"
    static let May = "May"
    static let June = "June"
    static let July = "July"
    static let August = "August"
    static let September = "September"
    static let October = "October"
    static let November = "November"
    static let December = "December"
    
}
enum UserDefaultsKeys {
    static let claint_Url = "claint_Url"
    static let licenceKey = "licenceKey"
    static let login_Flag = "login_Flag"
    static let userName = "userName"
    static let passWord = "passWord"
    static let location = "location"
}
//var sideMenuArray = ["Doctor Wise Revenue", "Admission Count", "General Report", "Doctor Count Analysis", "GST Summary", "GST Monthly", "Log Out"]
enum SideMenuValidationKeys {
    static let doctorWiseRevenue = "Doctor Wise Revenue"
    static let admissionCount = "Admission Count"
    static let generalReport = "General Report"
    static let doctorCountAnalysis = "Doctor Count Analysis"
    static let gSTSummary = "GST Summary"
    static let gSTMonthly = "GST Monthly"
    static let logOut = "Log Out"
}
enum FinancialValidkeys {
    static let inDetails = "inDetails"
    static let opDetails = "opDetails"
    static let pharmacyDetail = "pharmacyDetail"
    static let diagonsticDetail = "diagonsticDetail"
}
enum AdmissionDischargeValidationkeys {
    static let Discharge = "Discharge"
    static let Occupancy = "Occupancy"
    static let Admission = "Admission"
}
enum AdmissionTypeKeys {
    static let All = "All"
    static let Cash = "Cash"
    static let Organization = "Organization"
}
