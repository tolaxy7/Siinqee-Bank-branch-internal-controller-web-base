-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2026 at 12:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siinqee_bicrms`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_plan_targets`
--

CREATE TABLE `action_plan_targets` (
  `target_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `fiscal_year` varchar(20) NOT NULL,
  `risk_area` enum('CASH_MANAGEMENT','KYC_AML_CFT','LOANS_ADVANCES','TRANSACTION_PROCESSING','DIGITAL_BANKING_ATM','GL_CLEARING_RECONCILIATION','CUSTOMER_SERVICE_COMPLAINTS','OPERATIONAL_RISK_RCSA','COMPLIANCE_MONITORING','AUDIT_FOLLOW_UP') NOT NULL,
  `control_objective` text NOT NULL,
  `planned_activities` text NOT NULL,
  `policy_nbe_reference` varchar(150) NOT NULL,
  `inspection_frequency` varchar(40) NOT NULL,
  `target_kpi` varchar(100) NOT NULL,
  `required_evidence` varchar(100) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `action_plan_targets`
--

INSERT INTO `action_plan_targets` (`target_id`, `branch_id`, `fiscal_year`, `risk_area`, `control_objective`, `planned_activities`, `policy_nbe_reference`, `inspection_frequency`, `target_kpi`, `required_evidence`, `status`, `created_at`) VALUES
('apt-demo-0001-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', '2026/27', 'CASH_MANAGEMENT', 'Ensure physical cash agrees with ledger and approved limits.', 'Review vault and teller cash; perform surprise counts; investigate variances.', 'Bank Cash Management Policy; applicable NBE requirements', 'Daily / weekly surprise count', '100% scheduled counts completed', 'Signed cash count sheets', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0002-0000-0000-000000000002', '33333333-3333-3333-3333-333333333333', '2026/27', 'KYC_AML_CFT', 'Maintain complete and current customer due-diligence records.', 'Sample account files; check valid ID, TIN/trade licence where applicable, mandate and screening evidence.', 'Applicable NBE AML/CFT directives; Bank KYC Policy', 'Monthly sample', 'At least 95% of sampled files complete', 'KYC review checklist and exception register', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0003-0000-0000-000000000003', '33333333-3333-3333-3333-333333333333', '2026/27', 'LOANS_ADVANCES', 'Confirm loan files and approvals comply with delegated authority.', 'Review sampled loan files, approvals, collateral documentation and repayment monitoring.', 'Bank Credit Policy; applicable NBE directives', 'Monthly', '100% sampled files have required approvals', 'Loan file review checklist', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0004-0000-0000-000000000004', '33333333-3333-3333-3333-333333333333', '2026/27', 'TRANSACTION_PROCESSING', 'Ensure transactions are supported by valid vouchers and authorization.', 'Inspect debit/credit vouchers, signatures, approvals and batch reconciliation.', 'Bank Operations Procedures', 'Daily sample / monthly summary', 'No unresolved unauthorized transaction', 'Voucher audit register', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0005-0000-0000-000000000005', '33333333-3333-3333-3333-333333333333', '2026/27', 'DIGITAL_BANKING_ATM', 'Monitor digital banking and ATM controls and exceptions.', 'Review ATM balancing, access logs, downtime incidents and digital transaction exceptions.', 'Bank Digital Banking and ATM Procedures', 'Weekly', 'All exceptions logged and followed up', 'ATM balancing sheets and incident logs', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0006-0000-0000-000000000006', '33333333-3333-3333-3333-333333333333', '2026/27', 'GL_CLEARING_RECONCILIATION', 'Ensure GL and clearing accounts are reconciled promptly.', 'Review reconciliation evidence, aged outstanding items and follow-up actions.', 'Bank GL and Reconciliation Procedures', 'Daily / monthly', '100% reconciliations completed by deadline', 'Signed reconciliation reports', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0007-0000-0000-000000000007', '33333333-3333-3333-3333-333333333333', '2026/27', 'CUSTOMER_SERVICE_COMPLAINTS', 'Track complaints and ensure timely resolution.', 'Sample complaints, check register completeness, response times and closure evidence.', 'Bank Customer Complaint Handling Procedure', 'Monthly', 'All complaints tracked with owner and due date', 'Complaint register', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0008-0000-0000-000000000008', '33333333-3333-3333-3333-333333333333', '2026/27', 'OPERATIONAL_RISK_RCSA', 'Maintain current operational risk assessment and action tracking.', 'Review risk register, control self-assessments, KRIs and mitigation progress.', 'Bank Operational Risk Framework', 'Quarterly', 'Quarterly assessment submitted on time', 'RCSA and risk register', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0009-0000-0000-000000000009', '33333333-3333-3333-3333-333333333333', '2026/27', 'COMPLIANCE_MONITORING', 'Monitor compliance with internal policies and applicable requirements.', 'Perform compliance checks and track policy exceptions to closure.', 'Applicable NBE requirements; Bank Compliance Policy', 'Monthly', 'All high-risk exceptions escalated', 'Compliance monitoring report', 'ACTIVE', '2026-10-23 18:38:22'),
('apt-demo-0010-0000-0000-000000000010', '33333333-3333-3333-3333-333333333333', '2026/27', 'AUDIT_FOLLOW_UP', 'Ensure audit findings are assigned, corrected and verified.', 'Review open findings, deadlines, evidence and overdue corrective actions.', 'Bank Internal Audit and Finding Remediation Procedures', 'Monthly', 'No overdue high-risk finding without escalation', 'Finding follow-up register', 'ACTIVE', '2026-10-23 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `audit_findings`
--

CREATE TABLE `audit_findings` (
  `finding_id` varchar(36) NOT NULL,
  `finding_code` varchar(30) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `controller_id` varchar(36) NOT NULL,
  `risk_area` enum('CASH_MANAGEMENT','KYC_AML_CFT','LOANS_ADVANCES','TRANSACTION_PROCESSING','DIGITAL_BANKING_ATM','GL_CLEARING_RECONCILIATION','CUSTOMER_SERVICE_COMPLAINTS','OPERATIONAL_RISK_RCSA','COMPLIANCE_MONITORING','AUDIT_FOLLOW_UP') NOT NULL,
  `severity` enum('LOW','MEDIUM','HIGH','CRITICAL') NOT NULL,
  `finding_title` varchar(200) NOT NULL,
  `finding_description` text NOT NULL,
  `policy_nbe_reference` varchar(150) NOT NULL,
  `root_cause` text DEFAULT NULL,
  `risk_impact` text DEFAULT NULL,
  `recommendation` text NOT NULL,
  `target_rectification_date` date NOT NULL,
  `status` enum('OPEN','ASSIGNED','PENDING_VERIFICATION','RECTIFIED','OVERDUE','EXTENDED','ESCALATED_TO_DISTRICT','ESCALATED_TO_HEAD_OFFICE') NOT NULL DEFAULT 'OPEN',
  `audit_hash_sha256` varchar(64) DEFAULT NULL,
  `is_escalated_to_district` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_findings`
--

INSERT INTO `audit_findings` (`finding_id`, `finding_code`, `branch_id`, `controller_id`, `risk_area`, `severity`, `finding_title`, `finding_description`, `policy_nbe_reference`, `root_cause`, `risk_impact`, `recommendation`, `target_rectification_date`, `status`, `audit_hash_sha256`, `is_escalated_to_district`, `deleted_at`, `created_at`, `updated_at`) VALUES
('99999999-9999-9999-9999-999999999999', 'FIND-2026-DB-001', '33333333-3333-3333-3333-333333333333', 'cccc3333-3333-3333-3333-333333333333', 'KYC_AML_CFT', 'HIGH', 'Missing Renewed Trade License on Corporate Account', 'Audit sample of corporate account 10002938472 revealed the business trade license expired without a renewed copy on file.', 'NBE AML/CFT Directive SBB/76/2020 & Bank KYC Policy', 'Frontline staff omitted periodic KYC document review reminder.', 'Risk of regulatory penalties and non-compliance with NBE customer due diligence mandates.', 'Obtain renewed license immediately or apply debit freeze within 5 business days.', '2026-10-28', 'OPEN', 'd1770dd7682ac2dd9eb4773c995345002fbcf770f8fd48dfe04cce5687be11ca', 0, NULL, '2026-10-23 01:50:55', '2026-10-23 01:50:55'),
('e7469649-42af-4d20-a912-fa6b9461acd4', 'FIND-2026-DB-002', '33333333-3333-3333-3333-333333333333', 'cccc3333-3333-3333-3333-333333333333', 'TRANSACTION_PROCESSING', 'HIGH', 'cheuqe account withdraw by regural ticket voucher', 'dfd', 'NBE AML/CFT Directive SBB/76/2020', NULL, NULL, 'call customer to rectifies it', '2026-10-28', 'OPEN', '3d0483f97cd299b590fbe4e5d5d05a6342c04f67d5b264a4e45c0f8e5d588ac4', 0, NULL, '2026-10-23 16:30:28', '2026-10-23 16:30:28');

--
-- Triggers `audit_findings`
--
DELIMITER $$
CREATE TRIGGER `trg_audit_findings_sla_insert` BEFORE INSERT ON `audit_findings` FOR EACH ROW BEGIN
    IF NEW.target_rectification_date IS NULL OR NEW.target_rectification_date = '0000-00-00' THEN
        CASE NEW.severity
            WHEN 'CRITICAL' THEN
                SET NEW.target_rectification_date = DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY);
            WHEN 'HIGH' THEN
                SET NEW.target_rectification_date = DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);
            WHEN 'MEDIUM' THEN
                SET NEW.target_rectification_date = DATE_ADD(CURRENT_DATE(), INTERVAL 10 DAY);
            WHEN 'LOW' THEN
                SET NEW.target_rectification_date = DATE_ADD(CURRENT_DATE(), INTERVAL 15 DAY);
        END CASE;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `branch_id` varchar(36) NOT NULL,
  `district_id` varchar(36) NOT NULL,
  `branch_code` varchar(20) NOT NULL,
  `branch_name` varchar(120) NOT NULL,
  `branch_grade` enum('GRADE_1','GRADE_2','GRADE_3','GRADE_4','SPECIAL_BRANCH') NOT NULL DEFAULT 'GRADE_2',
  `banking_window` enum('CONVENTIONAL','INTEREST_FREE_BANKING_WADIAH','HYBRID_DUAL_WINDOW') NOT NULL DEFAULT 'HYBRID_DUAL_WINDOW',
  `cash_holding_limit` decimal(16,2) NOT NULL DEFAULT 5000000.00,
  `vault_limit` decimal(16,2) NOT NULL DEFAULT 20000000.00,
  `location_city` varchar(100) NOT NULL,
  `gps_latitude` decimal(9,6) DEFAULT NULL,
  `gps_longitude` decimal(9,6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`branch_id`, `district_id`, `branch_code`, `branch_name`, `branch_grade`, `banking_window`, `cash_holding_limit`, `vault_limit`, `location_city`, `gps_latitude`, `gps_longitude`, `is_active`, `deleted_at`, `created_at`, `updated_at`) VALUES
('33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'BR-DB01', 'Dalo Budena Branch', 'GRADE_1', 'HYBRID_DUAL_WINDOW', 8000000.00, 30000000.00, 'Addis Ababa', NULL, NULL, 1, NULL, '2026-10-23 01:50:55', '2026-10-23 01:50:55'),
('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'BR-AD01', 'Adama Main Branch', 'GRADE_1', 'HYBRID_DUAL_WINDOW', 10000000.00, 40000000.00, 'Adama', NULL, NULL, 1, NULL, '2026-10-23 01:50:55', '2026-10-23 01:50:55');

-- --------------------------------------------------------

--
-- Table structure for table `branch_rcsa_assessments`
--

CREATE TABLE `branch_rcsa_assessments` (
  `rcsa_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `manager_id` varchar(36) NOT NULL,
  `assessment_year` varchar(20) NOT NULL,
  `assessment_quarter` varchar(10) NOT NULL,
  `operational_risk_score` decimal(5,2) NOT NULL,
  `compliance_score` decimal(5,2) NOT NULL,
  `high_risk_areas_summary` text NOT NULL,
  `corrective_action_plan` text NOT NULL,
  `district_submission_status` varchar(30) NOT NULL DEFAULT 'SUBMITTED',
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch_rcsa_assessments`
--

INSERT INTO `branch_rcsa_assessments` (`rcsa_id`, `branch_id`, `manager_id`, `assessment_year`, `assessment_quarter`, `operational_risk_score`, `compliance_score`, `high_risk_areas_summary`, `corrective_action_plan`, `district_submission_status`, `submitted_at`) VALUES
('rcsa-demo-0001-0000-0000-00000000000', '33333333-3333-3333-3333-333333333333', 'bbbb2222-2222-2222-2222-222222222222', '2026/27', 'Q1', 35.00, 92.00, 'Demo assessment: monitor cash limits, KYC document expiry and voucher authorization.', 'Assign owners, set due dates, retain evidence and review progress at the monthly branch control meeting.', 'SUBMITTED', '2026-10-23 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `cash_counts`
--

CREATE TABLE `cash_counts` (
  `count_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `controller_id` varchar(36) NOT NULL,
  `count_type` enum('UNANNOUNCED_SURPRISE','SCHEDULED_WEEKLY','MONTH_END_CLOSE','CUSTODIAL_HANDOVER') NOT NULL,
  `count_datetime` datetime NOT NULL,
  `vault_ledger_balance` decimal(16,2) NOT NULL,
  `vault_physical_balance` decimal(16,2) NOT NULL,
  `teller_tills_physical_total` decimal(16,2) NOT NULL,
  `atm_cash_balance` decimal(16,2) NOT NULL DEFAULT 0.00,
  `total_variance` decimal(16,2) GENERATED ALWAYS AS (`vault_physical_balance` + `teller_tills_physical_total` + `atm_cash_balance` - `vault_ledger_balance`) STORED,
  `variance_reason` text DEFAULT NULL,
  `controller_notes` text DEFAULT NULL,
  `manager_witness_id` varchar(36) DEFAULT NULL,
  `manager_signed_at` datetime DEFAULT NULL,
  `audit_hash_sha256` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_counts`
--

INSERT INTO `cash_counts` (`count_id`, `branch_id`, `controller_id`, `count_type`, `count_datetime`, `vault_ledger_balance`, `vault_physical_balance`, `teller_tills_physical_total`, `atm_cash_balance`, `variance_reason`, `controller_notes`, `manager_witness_id`, `manager_signed_at`, `audit_hash_sha256`, `created_at`) VALUES
('cash-demo-0001-0000-0000-00000000000', '33333333-3333-3333-3333-333333333333', 'cccc3333-3333-3333-3333-333333333333', 'SCHEDULED_WEEKLY', '2026-10-23 18:38:22', 6000000.00, 5600000.00, 400000.00, 0.00, NULL, 'Fictional demo count: vault plus teller tills equals ledger balance; verify against actual records before operational use.', 'bbbb2222-2222-2222-2222-222222222222', '2026-10-23 18:38:22', NULL, '2026-10-23 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `cash_count_denominations`
--

CREATE TABLE `cash_count_denominations` (
  `denom_id` varchar(36) NOT NULL,
  `count_id` varchar(36) NOT NULL,
  `denomination_value` int(11) NOT NULL,
  `note_quantity` int(11) NOT NULL DEFAULT 0,
  `subtotal_amount` decimal(16,2) GENERATED ALWAYS AS (`denomination_value` * `note_quantity`) STORED
) ;

--
-- Dumping data for table `cash_count_denominations`
--

INSERT INTO `cash_count_denominations` (`denom_id`, `count_id`, `denomination_value`, `note_quantity`) VALUES
('den-demo-0001-0000-0000-000000000001', 'cash-demo-0001-0000-0000-00000000000', 100, 10000),
('den-demo-0002-0000-0000-000000000002', 'cash-demo-0001-0000-0000-00000000000', 50, 10000),
('den-demo-0003-0000-0000-000000000003', 'cash-demo-0001-0000-0000-00000000000', 10, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `core_banking_sync_logs`
--

CREATE TABLE `core_banking_sync_logs` (
  `sync_id` varchar(36) NOT NULL,
  `sync_source` varchar(60) NOT NULL DEFAULT 'ORACLE_FLEXCUBE',
  `sync_type` varchar(50) NOT NULL,
  `records_processed` int(11) NOT NULL DEFAULT 0,
  `records_errored` int(11) NOT NULL DEFAULT 0,
  `sync_status` varchar(30) NOT NULL,
  `error_details` text DEFAULT NULL,
  `started_at` datetime NOT NULL,
  `completed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `core_banking_sync_logs`
--

INSERT INTO `core_banking_sync_logs` (`sync_id`, `sync_source`, `sync_type`, `records_processed`, `records_errored`, `sync_status`, `error_details`, `started_at`, `completed_at`) VALUES
('sync-demo-0001-0000-0000-00000000000', 'DEMO_SOURCE', 'BRANCH_DAILY_SUMMARY', 25, 0, 'SUCCESS', NULL, '2026-10-23 18:38:22', '2026-10-23 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `daily_operational_checklists`
--

CREATE TABLE `daily_operational_checklists` (
  `checklist_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `maker_id` varchar(36) NOT NULL,
  `checklist_date` date NOT NULL,
  `vault_opening_witnessed` tinyint(1) NOT NULL DEFAULT 0,
  `teller_till_limit_acknowledged` tinyint(1) NOT NULL DEFAULT 0,
  `counterfeit_detector_tested` tinyint(1) NOT NULL DEFAULT 0,
  `clean_desk_clean_screen_verified` tinyint(1) NOT NULL DEFAULT 0,
  `cctv_status_checked` tinyint(1) NOT NULL DEFAULT 0,
  `checklist_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`checklist_payload`)),
  `maker_comments` text DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_operational_checklists`
--

INSERT INTO `daily_operational_checklists` (`checklist_id`, `branch_id`, `maker_id`, `checklist_date`, `vault_opening_witnessed`, `teller_till_limit_acknowledged`, `counterfeit_detector_tested`, `clean_desk_clean_screen_verified`, `cctv_status_checked`, `checklist_payload`, `maker_comments`, `submitted_at`) VALUES
('chk-demo-0001-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'aaaa1111-1111-1111-1111-111111111111', '2026-10-23', 0, 0, 0, 0, 0, '{\"vault_opening_witnessed\":false,\"teller_till_limit_acknowledged\":false,\"counterfeit_detector_tested\":false,\"clean_desk_clean_screen_verified\":false,\"cctv_status_checked\":false}', 'DEMO ONLY: pending checks; verify each control before marking complete.', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `daily_voucher_batches`
--

CREATE TABLE `daily_voucher_batches` (
  `batch_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `maker_id` varchar(36) NOT NULL,
  `transaction_date` date NOT NULL,
  `batch_reference` varchar(50) NOT NULL,
  `flexcube_batch_id` varchar(50) NOT NULL,
  `physical_debit_vouchers_count` int(11) NOT NULL DEFAULT 0,
  `physical_credit_vouchers_count` int(11) NOT NULL DEFAULT 0,
  `total_debit_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `total_credit_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `batch_metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`batch_metadata`)),
  `handoff_status` varchar(30) NOT NULL DEFAULT 'SUBMITTED',
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_voucher_batches`
--

INSERT INTO `daily_voucher_batches` (`batch_id`, `branch_id`, `maker_id`, `transaction_date`, `batch_reference`, `flexcube_batch_id`, `physical_debit_vouchers_count`, `physical_credit_vouchers_count`, `total_debit_amount`, `total_credit_amount`, `batch_metadata`, `handoff_status`, `submitted_at`) VALUES
('batch-demo-0001-0000-0000-0000000000', '33333333-3333-3333-3333-333333333333', 'aaaa1111-1111-1111-1111-111111111111', '2026-10-23', 'DEMO-BATCH-20261023', 'DEMO-FC-20261023', 10, 12, 125000.00, 125000.00, '{\"demo\":true,\"note\":\"Fictional batch for development testing\"}', 'SUBMITTED', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `district_id` varchar(36) NOT NULL,
  `district_code` varchar(20) NOT NULL,
  `district_name` varchar(100) NOT NULL,
  `region` varchar(100) NOT NULL,
  `office_address` varchar(255) DEFAULT NULL,
  `director_user_id` varchar(36) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `districts`
--

INSERT INTO `districts` (`district_id`, `district_code`, `district_name`, `region`, `office_address`, `director_user_id`, `is_active`, `created_at`, `updated_at`) VALUES
('11111111-1111-1111-1111-111111111111', 'DST-FIN', 'Finfinne Central District', 'Addis Ababa', 'Kazanchis, Joseph Tito St., Addis Ababa', NULL, 1, '2026-10-23 01:50:55', '2026-10-23 01:50:55'),
('22222222-2222-2222-2222-222222222222', 'DST-ADA', 'Adama District', 'Oromia', 'Posta Bet Road, Adama', NULL, 1, '2026-10-23 01:50:55', '2026-10-23 01:50:55');

-- --------------------------------------------------------

--
-- Table structure for table `district_finding_escalations`
--

CREATE TABLE `district_finding_escalations` (
  `escalation_id` varchar(36) NOT NULL,
  `finding_id` varchar(36) NOT NULL,
  `district_officer_id` varchar(36) NOT NULL,
  `escalation_reason` text NOT NULL,
  `required_remedy` text NOT NULL,
  `escalation_status` varchar(40) NOT NULL DEFAULT 'UNDER_DISTRICT_REVIEW',
  `escalated_to_head_office` tinyint(1) NOT NULL DEFAULT 0,
  `escalated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `district_finding_escalations`
--

INSERT INTO `district_finding_escalations` (`escalation_id`, `finding_id`, `district_officer_id`, `escalation_reason`, `required_remedy`, `escalation_status`, `escalated_to_head_office`, `escalated_at`) VALUES
('esc-demo-0001-0000-0000-000000000001', '99999999-9999-9999-9999-999999999999', 'dddd4444-4444-4444-4444-444444444444', 'DEMO ONLY: sample high-risk finding selected to test escalation workflow.', 'Confirm required KYC documents are obtained and evidence is reviewed.', 'UNDER_DISTRICT_REVIEW', 0, '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `district_monthly_reports`
--

CREATE TABLE `district_monthly_reports` (
  `report_id` varchar(36) NOT NULL,
  `district_id` varchar(36) NOT NULL,
  `officer_id` varchar(36) NOT NULL,
  `reporting_month` int(11) NOT NULL,
  `reporting_year` int(11) NOT NULL,
  `total_branches_count` int(11) NOT NULL,
  `audited_branches_count` int(11) NOT NULL,
  `open_findings_count` int(11) NOT NULL,
  `critical_findings_count` int(11) NOT NULL,
  `average_district_kri_score` decimal(5,2) NOT NULL,
  `executive_summary` text NOT NULL,
  `report_data_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`report_data_payload`)),
  `generated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `district_monthly_reports`
--

INSERT INTO `district_monthly_reports` (`report_id`, `district_id`, `officer_id`, `reporting_month`, `reporting_year`, `total_branches_count`, `audited_branches_count`, `open_findings_count`, `critical_findings_count`, `average_district_kri_score`, `executive_summary`, `report_data_payload`, `generated_at`) VALUES
('dmr-demo-0001-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'dddd4444-4444-4444-4444-444444444444', 10, 2026, 1, 1, 2, 0, 35.00, 'DEMO ONLY: sample district report for dashboard testing; confirm all counts before operational reporting.', '{\"demo\":true,\"branches\":[\"Dalo Budena Branch\"],\"note\":\"Fictional summary payload\"}', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `finding_rectifications`
--

CREATE TABLE `finding_rectifications` (
  `rectification_id` varchar(36) NOT NULL,
  `finding_id` varchar(36) NOT NULL,
  `assigned_staff_id` varchar(36) NOT NULL,
  `manager_id` varchar(36) NOT NULL,
  `action_taken_description` text NOT NULL,
  `rectification_date` datetime NOT NULL DEFAULT current_timestamp(),
  `evidence_file_path` varchar(255) DEFAULT NULL,
  `evidence_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`evidence_payload`)),
  `controller_verification_status` enum('PENDING','ACCEPTED_CLOSED','REJECTED_REWORK_REQUIRED','REQUEST_ADDITIONAL_EVIDENCE') NOT NULL DEFAULT 'PENDING',
  `controller_verified_by` varchar(36) DEFAULT NULL,
  `controller_verified_at` datetime DEFAULT NULL,
  `controller_rejection_reason` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finding_rectifications`
--

INSERT INTO `finding_rectifications` (`rectification_id`, `finding_id`, `assigned_staff_id`, `manager_id`, `action_taken_description`, `rectification_date`, `evidence_file_path`, `evidence_payload`, `controller_verification_status`, `controller_verified_by`, `controller_verified_at`, `controller_rejection_reason`, `created_at`) VALUES
('rect-demo-0001-0000-0000-00000000000', '99999999-9999-9999-9999-999999999999', 'aaaa1111-1111-1111-1111-111111111111', 'bbbb2222-2222-2222-2222-222222222222', 'DEMO ONLY: staff follow-up action placeholder. Do not treat as evidence of actual rectification.', '2026-10-23 18:38:23', NULL, '{\"demo\":true,\"evidence\":\"No actual evidence attached\"}', 'PENDING', NULL, NULL, NULL, '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `inspection_templates`
--

CREATE TABLE `inspection_templates` (
  `template_id` varchar(36) NOT NULL,
  `template_code` varchar(50) NOT NULL,
  `template_title` varchar(150) NOT NULL,
  `risk_area` enum('CASH_MANAGEMENT','KYC_AML_CFT','LOANS_ADVANCES','TRANSACTION_PROCESSING','DIGITAL_BANKING_ATM','GL_CLEARING_RECONCILIATION','CUSTOMER_SERVICE_COMPLAINTS','OPERATIONAL_RISK_RCSA','COMPLIANCE_MONITORING','AUDIT_FOLLOW_UP') NOT NULL,
  `nbe_directive_reference` varchar(150) DEFAULT NULL,
  `template_version` varchar(20) NOT NULL DEFAULT '1.0',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by_user_id` varchar(36) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inspection_templates`
--

INSERT INTO `inspection_templates` (`template_id`, `template_code`, `template_title`, `risk_area`, `nbe_directive_reference`, `template_version`, `is_active`, `created_by_user_id`, `created_at`) VALUES
('tpl-demo-0001-0000-0000-000000000001', 'DEMO-CASH-001', 'Cash Management Control Inspection', 'CASH_MANAGEMENT', 'Bank Cash Management Policy; applicable NBE requirements', '1.0', 1, 'cccc3333-3333-3333-3333-333333333333', '2026-10-23 18:38:23'),
('tpl-demo-0002-0000-0000-000000000002', 'DEMO-KYC-001', 'KYC File Review Inspection', 'KYC_AML_CFT', 'Applicable NBE AML/CFT directives; Bank KYC Policy', '1.0', 1, 'cccc3333-3333-3333-3333-333333333333', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `kri_threshold_configs`
--

CREATE TABLE `kri_threshold_configs` (
  `config_id` varchar(36) NOT NULL,
  `metric_code` varchar(50) NOT NULL,
  `metric_name` varchar(120) NOT NULL,
  `risk_area` enum('CASH_MANAGEMENT','KYC_AML_CFT','LOANS_ADVANCES','TRANSACTION_PROCESSING','DIGITAL_BANKING_ATM','GL_CLEARING_RECONCILIATION','CUSTOMER_SERVICE_COMPLAINTS','OPERATIONAL_RISK_RCSA','COMPLIANCE_MONITORING','AUDIT_FOLLOW_UP') NOT NULL,
  `unit_of_measure` varchar(30) NOT NULL,
  `green_safe_threshold` decimal(16,2) NOT NULL,
  `amber_warning_threshold` decimal(16,2) NOT NULL,
  `red_critical_threshold` decimal(16,2) NOT NULL,
  `configured_by_user_id` varchar(36) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kri_threshold_configs`
--

INSERT INTO `kri_threshold_configs` (`config_id`, `metric_code`, `metric_name`, `risk_area`, `unit_of_measure`, `green_safe_threshold`, `amber_warning_threshold`, `red_critical_threshold`, `configured_by_user_id`, `updated_at`) VALUES
('kri-demo-0001-0000-0000-000000000001', 'CASH_VARIANCE_ETB', 'Cash variance', 'CASH_MANAGEMENT', 'ETB', 0.00, 100.00, 1000.00, 'cccc3333-3333-3333-3333-333333333333', '2026-10-23 18:38:23'),
('kri-demo-0002-0000-0000-000000000002', 'KYC_MISSING_DOC_PCT', 'Sampled KYC files with missing documents', 'KYC_AML_CFT', 'PERCENT', 2.00, 5.00, 10.00, 'cccc3333-3333-3333-3333-333333333333', '2026-10-23 18:38:23'),
('kri-demo-0003-0000-0000-000000000003', 'OVERDUE_FINDINGS', 'Overdue open findings', 'AUDIT_FOLLOW_UP', 'COUNT', 0.00, 2.00, 5.00, 'cccc3333-3333-3333-3333-333333333333', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `kyc_aml_reviews`
--

CREATE TABLE `kyc_aml_reviews` (
  `review_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `controller_id` varchar(36) NOT NULL,
  `account_number` varchar(40) NOT NULL,
  `customer_name` varchar(150) NOT NULL,
  `banking_window` enum('CONVENTIONAL','INTEREST_FREE_BANKING_WADIAH','HYBRID_DUAL_WINDOW') NOT NULL DEFAULT 'CONVENTIONAL',
  `account_opening_date` date NOT NULL,
  `review_date` date NOT NULL,
  `has_valid_id` tinyint(1) NOT NULL DEFAULT 1,
  `has_tin_certificate` tinyint(1) NOT NULL DEFAULT 1,
  `has_trade_license` tinyint(1) NOT NULL DEFAULT 1,
  `has_mandate_signature` tinyint(1) NOT NULL DEFAULT 1,
  `is_politically_exposed_person` tinyint(1) NOT NULL DEFAULT 0,
  `sanctions_screening_passed` tinyint(1) NOT NULL DEFAULT 1,
  `is_suspicious_transaction_flagged` tinyint(1) NOT NULL DEFAULT 0,
  `str_details` text DEFAULT NULL,
  `review_outcome` varchar(30) NOT NULL DEFAULT 'COMPLIANT',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kyc_aml_reviews`
--

INSERT INTO `kyc_aml_reviews` (`review_id`, `branch_id`, `controller_id`, `account_number`, `customer_name`, `banking_window`, `account_opening_date`, `review_date`, `has_valid_id`, `has_tin_certificate`, `has_trade_license`, `has_mandate_signature`, `is_politically_exposed_person`, `sanctions_screening_passed`, `is_suspicious_transaction_flagged`, `str_details`, `review_outcome`, `created_at`) VALUES
('kyc-demo-0001-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'cccc3333-3333-3333-3333-333333333333', 'DEMO-ACCT-001', 'Demo Customer - Fictional', 'CONVENTIONAL', '2026-10-23', '2026-10-23', 1, 1, 1, 1, 0, 1, 0, NULL, 'COMPLIANT', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `manager_daily_signoffs`
--

CREATE TABLE `manager_daily_signoffs` (
  `signoff_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `manager_id` varchar(36) NOT NULL,
  `signoff_date` date NOT NULL,
  `eod_cash_ledger_balance` decimal(16,2) NOT NULL,
  `vault_physical_count_verified` tinyint(1) NOT NULL DEFAULT 1,
  `all_batches_reconciled` tinyint(1) NOT NULL DEFAULT 1,
  `unauthorized_overrides_reviewed` tinyint(1) NOT NULL DEFAULT 1,
  `manager_comments` text DEFAULT NULL,
  `digital_signature_token` varchar(255) DEFAULT NULL,
  `signed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manager_daily_signoffs`
--

INSERT INTO `manager_daily_signoffs` (`signoff_id`, `branch_id`, `manager_id`, `signoff_date`, `eod_cash_ledger_balance`, `vault_physical_count_verified`, `all_batches_reconciled`, `unauthorized_overrides_reviewed`, `manager_comments`, `digital_signature_token`, `signed_at`) VALUES
('57a9cc11-9179-41ea-9d7b-2ded18080779', '33333333-3333-3333-3333-333333333333', 'bbbb2222-2222-2222-2222-222222222222', '2026-10-23', 14250000.00, 1, 1, 1, 'End-of-day balances and teller tills verified.', '4753191b410f8e8b5bc5d71b29a3f3ee7196a48362d371daff3e015d6fbaf140', '2026-10-23 16:54:25');

-- --------------------------------------------------------

--
-- Table structure for table `operational_incidents`
--

CREATE TABLE `operational_incidents` (
  `incident_id` varchar(36) NOT NULL,
  `branch_id` varchar(36) NOT NULL,
  `reported_by_user_id` varchar(36) NOT NULL,
  `incident_type` enum('COUNTERFEIT_CURRENCY','CASH_SHORTAGE_OVERAGE','SYSTEM_DOWNTIME_CORE','HARDWARE_NETWORK_FAILURE','PHYSICAL_SECURITY_BREACH','SUSPECTED_FRAUD_INTERNAL','UNAUTHORIZED_PROCEDURAL_OVERRIDE') NOT NULL,
  `incident_date` datetime NOT NULL,
  `incident_title` varchar(150) NOT NULL,
  `incident_description` text NOT NULL,
  `financial_impact_amount` decimal(16,2) NOT NULL DEFAULT 0.00,
  `immediate_action_taken` text DEFAULT NULL,
  `evidence_attachment_url` varchar(255) DEFAULT NULL,
  `escalation_required` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(30) NOT NULL DEFAULT 'REPORTED',
  `reported_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `operational_incidents`
--

INSERT INTO `operational_incidents` (`incident_id`, `branch_id`, `reported_by_user_id`, `incident_type`, `incident_date`, `incident_title`, `incident_description`, `financial_impact_amount`, `immediate_action_taken`, `evidence_attachment_url`, `escalation_required`, `status`, `reported_at`, `updated_at`) VALUES
('inc-demo-0001-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'aaaa1111-1111-1111-1111-111111111111', 'HARDWARE_NETWORK_FAILURE', '2026-10-23 18:38:23', 'DEMO network interruption', 'Fictional incident to test incident tracking; not a real outage.', 0.00, 'Demo record only; no operational action recorded.', NULL, 0, 'REPORTED', '2026-10-23 18:38:23', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `outbox_events`
--

CREATE TABLE `outbox_events` (
  `event_id` varchar(36) NOT NULL,
  `aggregate_type` varchar(60) NOT NULL,
  `aggregate_id` varchar(60) NOT NULL,
  `event_type` varchar(80) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`payload`)),
  `is_processed` tinyint(1) NOT NULL DEFAULT 0,
  `retry_count` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `processed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `outbox_events`
--

INSERT INTO `outbox_events` (`event_id`, `aggregate_type`, `aggregate_id`, `event_type`, `payload`, `is_processed`, `retry_count`, `created_at`, `processed_at`) VALUES
('outbox-demo-0001-0000-0000-000000000', 'audit_finding', '99999999-9999-9999-9999-999999999999', 'DEMO_FINDING_CREATED', '{\"demo\":true,\"finding_code\":\"FIND-2026-DB-001\",\"note\":\"Development test event\"}', 0, 0, '2026-10-23 18:38:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `regulatory_filings`
--

CREATE TABLE `regulatory_filings` (
  `filing_id` varchar(36) NOT NULL,
  `filing_reference` varchar(60) NOT NULL,
  `regulatory_body` varchar(100) NOT NULL DEFAULT 'NATIONAL_BANK_OF_ETHIOPIA',
  `reporting_period` varchar(50) NOT NULL,
  `filing_type` varchar(80) NOT NULL,
  `summary_payload_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`summary_payload_json`)),
  `filed_by_user_id` varchar(36) NOT NULL,
  `acknowledgement_number` varchar(100) DEFAULT NULL,
  `filed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `regulatory_filings`
--

INSERT INTO `regulatory_filings` (`filing_id`, `filing_reference`, `regulatory_body`, `reporting_period`, `filing_type`, `summary_payload_json`, `filed_by_user_id`, `acknowledgement_number`, `filed_at`) VALUES
('rf-demo-0001-0000-0000-000000000001', 'DEMO-REG-2026-10-001', 'NATIONAL_BANK_OF_ETHIOPIA', '2026-10', 'DEMO_OPERATIONAL_RISK_SUMMARY', '{\"demo\":true,\"status\":\"TEST_ONLY\",\"note\":\"Not an actual regulatory submission\"}', 'eeee5555-5555-5555-5555-555555555555', NULL, '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `remediation_extension_requests`
--

CREATE TABLE `remediation_extension_requests` (
  `request_id` varchar(36) NOT NULL,
  `finding_id` varchar(36) NOT NULL,
  `requested_by_manager_id` varchar(36) NOT NULL,
  `current_deadline` date NOT NULL,
  `proposed_new_deadline` date NOT NULL,
  `extension_justification` text NOT NULL,
  `district_officer_id` varchar(36) DEFAULT NULL,
  `review_status` enum('PENDING','ACCEPTED_CLOSED','REJECTED_REWORK_REQUIRED','REQUEST_ADDITIONAL_EVIDENCE') NOT NULL DEFAULT 'PENDING',
  `officer_remarks` text DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `remediation_extension_requests`
--

INSERT INTO `remediation_extension_requests` (`request_id`, `finding_id`, `requested_by_manager_id`, `current_deadline`, `proposed_new_deadline`, `extension_justification`, `district_officer_id`, `review_status`, `officer_remarks`, `reviewed_at`, `created_at`) VALUES
('ext-demo-0001-0000-0000-000000000001', '99999999-9999-9999-9999-999999999999', 'bbbb2222-2222-2222-2222-222222222222', '2026-10-28', '2026-11-04', 'DEMO ONLY: sample extension request to test approval workflow; not a real request.', 'dddd4444-4444-4444-4444-444444444444', 'PENDING', NULL, NULL, '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Table structure for table `system_audit_logs`
--

CREATE TABLE `system_audit_logs` (
  `log_id` bigint(20) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `action_type` varchar(50) NOT NULL,
  `entity_name` varchar(60) NOT NULL,
  `entity_id` varchar(60) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `old_values_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values_json`)),
  `new_values_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values_json`)),
  `occurred_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_audit_logs`
--

INSERT INTO `system_audit_logs` (`log_id`, `user_id`, `action_type`, `entity_name`, `entity_id`, `ip_address`, `user_agent`, `old_values_json`, `new_values_json`, `occurred_at`) VALUES
(1, 'ffff6666-6666-6666-6666-666666666666', 'LOGIN', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:15:52'),
(2, 'ffff6666-6666-6666-6666-666666666666', 'LOGOUT', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:45:46'),
(3, 'ffff6666-6666-6666-6666-666666666666', 'LOGIN', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:45:53'),
(4, 'ffff6666-6666-6666-6666-666666666666', 'LOGOUT', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:00'),
(5, 'cccc3333-3333-3333-3333-333333333333', 'LOGIN', 'users', 'cccc3333-3333-3333-3333-333333333333', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:03'),
(6, 'cccc3333-3333-3333-3333-333333333333', 'LOGOUT', 'users', 'cccc3333-3333-3333-3333-333333333333', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:25'),
(7, 'aaaa1111-1111-1111-1111-111111111111', 'LOGIN', 'users', 'aaaa1111-1111-1111-1111-111111111111', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:29'),
(8, 'aaaa1111-1111-1111-1111-111111111111', 'LOGOUT', 'users', 'aaaa1111-1111-1111-1111-111111111111', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:45'),
(9, 'eeee5555-5555-5555-5555-555555555555', 'LOGIN', 'users', 'eeee5555-5555-5555-5555-555555555555', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 17:46:50'),
(10, 'aaaa1111-1111-1111-1111-111111111111', 'LOGOUT', 'users', 'aaaa1111-1111-1111-1111-111111111111', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 18:42:46'),
(11, 'ffff6666-6666-6666-6666-666666666666', 'LOGIN', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 18:42:49'),
(12, 'ffff6666-6666-6666-6666-666666666666', 'LOGOUT', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 18:52:24'),
(13, 'dddd4444-4444-4444-4444-444444444444', 'LOGIN', 'users', 'dddd4444-4444-4444-4444-444444444444', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 18:52:27'),
(14, 'dddd4444-4444-4444-4444-444444444444', 'LOGOUT', 'users', 'dddd4444-4444-4444-4444-444444444444', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:06:33'),
(15, 'cccc3333-3333-3333-3333-333333333333', 'LOGIN', 'users', 'cccc3333-3333-3333-3333-333333333333', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:06:36'),
(16, 'cccc3333-3333-3333-3333-333333333333', 'LOGOUT', 'users', 'cccc3333-3333-3333-3333-333333333333', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:07:23'),
(17, 'bbbb2222-2222-2222-2222-222222222222', 'LOGIN', 'users', 'bbbb2222-2222-2222-2222-222222222222', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:07:27'),
(18, 'bbbb2222-2222-2222-2222-222222222222', 'LOGOUT', 'users', 'bbbb2222-2222-2222-2222-222222222222', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:15:07'),
(19, 'eeee5555-5555-5555-5555-555555555555', 'LOGIN', 'users', 'eeee5555-5555-5555-5555-555555555555', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:15:13'),
(20, 'eeee5555-5555-5555-5555-555555555555', 'LOGOUT', 'users', 'eeee5555-5555-5555-5555-555555555555', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:24:17'),
(21, 'ffff6666-6666-6666-6666-666666666666', 'LOGIN', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:24:25'),
(22, 'ffff6666-6666-6666-6666-666666666666', 'LOGOUT', 'users', 'ffff6666-6666-6666-6666-666666666666', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:24:28'),
(23, 'cccc3333-3333-3333-3333-333333333333', 'LOGIN', 'users', 'cccc3333-3333-3333-3333-333333333333', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', NULL, NULL, '2026-10-23 19:24:31');

-- --------------------------------------------------------

--
-- Table structure for table `template_checklist_items`
--

CREATE TABLE `template_checklist_items` (
  `item_id` varchar(36) NOT NULL,
  `template_id` varchar(36) NOT NULL,
  `item_number` int(11) NOT NULL,
  `check_criteria` text NOT NULL,
  `control_objective` text NOT NULL,
  `weight_score` decimal(5,2) NOT NULL DEFAULT 1.00,
  `mandatory_document_required` varchar(100) DEFAULT NULL,
  `is_critical` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `template_checklist_items`
--

INSERT INTO `template_checklist_items` (`item_id`, `template_id`, `item_number`, `check_criteria`, `control_objective`, `weight_score`, `mandatory_document_required`, `is_critical`) VALUES
('tci-demo-0001-0000-0000-000000000001', 'tpl-demo-0001-0000-0000-000000000001', 1, 'Was the vault opening witnessed and recorded?', 'Ensure dual control over vault access.', 2.00, 'Vault opening register', 1),
('tci-demo-0002-0000-0000-000000000002', 'tpl-demo-0001-0000-0000-000000000001', 2, 'Were teller till limits acknowledged?', 'Ensure teller cash is within approved limits.', 1.00, 'Teller limit acknowledgement', 1),
('tci-demo-0003-0000-0000-000000000003', 'tpl-demo-0002-0000-0000-000000000002', 1, 'Is valid customer identification on file?', 'Confirm customer identity documentation is present.', 2.00, 'Valid identification copy', 1),
('tci-demo-0004-0000-0000-000000000004', 'tpl-demo-0002-0000-0000-000000000002', 2, 'Are required customer documents current?', 'Confirm periodic KYC review is completed.', 1.00, 'Current KYC documents', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(36) NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `username` varchar(60) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `role` enum('BRANCH_MAKER','BRANCH_MANAGER','BRANCH_INTERNAL_CONTROLLER','DISTRICT_RISK_OFFICER','HEAD_OFFICE_ADMIN','SYSTEM_ADMIN') NOT NULL,
  `branch_id` varchar(36) DEFAULT NULL,
  `district_id` varchar(36) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `failed_login_attempts` int(11) NOT NULL DEFAULT 0,
  `account_locked_until` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(45) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `employee_id`, `username`, `full_name`, `email`, `phone_number`, `role`, `branch_id`, `district_id`, `password_hash`, `mfa_enabled`, `failed_login_attempts`, `account_locked_until`, `is_active`, `last_login_at`, `last_login_ip`, `deleted_at`, `created_at`, `updated_at`) VALUES
('aaaa1111-1111-1111-1111-111111111111', 'SQ-04921', 'anwar.jambo', 'Anwar Jambo', 'anwar.jambo@siinqeebank.et', NULL, 'BRANCH_MAKER', '33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForMaker', 1, 0, NULL, 1, '2026-10-23 17:46:29', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 17:46:29'),
('bbbb2222-2222-2222-2222-222222222222', 'SQ-01822', 'gelisa.dugasa', 'Gelisa Dugasa', 'gelisa.dugasa@siinqeebank.et', NULL, 'BRANCH_MANAGER', '33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForManager', 1, 0, NULL, 1, '2026-10-23 19:07:27', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 19:07:27'),
('cccc3333-3333-3333-3333-333333333333', 'SQ-02390', 'tolawaaq.lammeessaa', 'Tolawaaq Lammeessaa', 'tolawaaq.l@siinqeebank.et', NULL, 'BRANCH_INTERNAL_CONTROLLER', '33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForController', 1, 0, NULL, 1, '2026-10-23 19:24:31', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 19:24:31'),
('dddd4444-4444-4444-4444-444444444444', 'SQ-00812', 'chala.abdisa', 'Chala Abdisa', 'chala.abdisa@siinqeebank.et', NULL, 'DISTRICT_RISK_OFFICER', NULL, '11111111-1111-1111-1111-111111111111', '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForDistrictOfficer', 1, 0, NULL, 1, '2026-10-23 18:52:27', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 18:52:27'),
('eeee5555-5555-5555-5555-555555555555', 'SQ-00210', 'kumsa.gemechu', 'Kumsa Gemechu', 'kumsa.gemechu@siinqeebank.et', NULL, 'HEAD_OFFICE_ADMIN', NULL, NULL, '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForHOAdmin', 1, 0, NULL, 1, '2026-10-23 19:15:13', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 19:15:13'),
('ffff6666-6666-6666-6666-666666666666', 'SQ-00045', 'admin.it', 'IT System Administrator', 'sysadmin@siinqeebank.et', NULL, 'SYSTEM_ADMIN', NULL, NULL, '$2b$12$eD8eX1Q3Y4F8a7c6b5d4e.hashPlaceholderForSysAdmin', 1, 0, NULL, 1, '2026-10-23 19:24:25', NULL, NULL, '2026-10-23 01:50:55', '2026-10-23 19:24:25');

-- --------------------------------------------------------

--
-- Table structure for table `voucher_audits`
--

CREATE TABLE `voucher_audits` (
  `audit_id` varchar(36) NOT NULL,
  `batch_id` varchar(36) NOT NULL,
  `controller_id` varchar(36) NOT NULL,
  `audit_date` date NOT NULL,
  `audited_vouchers_count` int(11) NOT NULL,
  `missing_vouchers_count` int(11) NOT NULL DEFAULT 0,
  `unauthorized_overrides_count` int(11) NOT NULL DEFAULT 0,
  `signature_stamp_defects_count` int(11) NOT NULL DEFAULT 0,
  `exceptions_detected` tinyint(1) NOT NULL DEFAULT 0,
  `audit_status` varchar(30) NOT NULL DEFAULT 'COMPLETED',
  `controller_remarks` text DEFAULT NULL,
  `completed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `voucher_audits`
--

INSERT INTO `voucher_audits` (`audit_id`, `batch_id`, `controller_id`, `audit_date`, `audited_vouchers_count`, `missing_vouchers_count`, `unauthorized_overrides_count`, `signature_stamp_defects_count`, `exceptions_detected`, `audit_status`, `controller_remarks`, `completed_at`) VALUES
('va-demo-0001-0000-0000-000000000001', 'batch-demo-0001-0000-0000-0000000000', 'cccc3333-3333-3333-3333-333333333333', '2026-10-23', 5, 0, 0, 0, 0, 'COMPLETED', 'DEMO ONLY: sample audit record; replace with actual audit results.', '2026-10-23 18:38:23');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_active_findings_sla`
-- (See below for the actual view)
--
CREATE TABLE `v_active_findings_sla` (
`finding_id` varchar(36)
,`finding_code` varchar(30)
,`branch_code` varchar(20)
,`branch_name` varchar(120)
,`district_name` varchar(100)
,`controller_name` varchar(120)
,`risk_area` enum('CASH_MANAGEMENT','KYC_AML_CFT','LOANS_ADVANCES','TRANSACTION_PROCESSING','DIGITAL_BANKING_ATM','GL_CLEARING_RECONCILIATION','CUSTOMER_SERVICE_COMPLAINTS','OPERATIONAL_RISK_RCSA','COMPLIANCE_MONITORING','AUDIT_FOLLOW_UP')
,`severity` enum('LOW','MEDIUM','HIGH','CRITICAL')
,`finding_title` varchar(200)
,`status` enum('OPEN','ASSIGNED','PENDING_VERIFICATION','RECTIFIED','OVERDUE','EXTENDED','ESCALATED_TO_DISTRICT','ESCALATED_TO_HEAD_OFFICE')
,`target_rectification_date` date
,`evaluation_date` date
,`days_remaining` int(7)
,`is_overdue` int(1)
,`created_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_branch_kri_dashboard`
-- (See below for the actual view)
--
CREATE TABLE `v_branch_kri_dashboard` (
`branch_id` varchar(36)
,`branch_code` varchar(20)
,`branch_name` varchar(120)
,`branch_grade` enum('GRADE_1','GRADE_2','GRADE_3','GRADE_4','SPECIAL_BRANCH')
,`cash_holding_limit` decimal(16,2)
,`latest_total_cash` decimal(17,2)
,`is_cash_holding_limit_breached` int(1)
,`open_findings_count` bigint(21)
,`critical_findings_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `v_active_findings_sla`
--
DROP TABLE IF EXISTS `v_active_findings_sla`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_active_findings_sla`  AS SELECT `f`.`finding_id` AS `finding_id`, `f`.`finding_code` AS `finding_code`, `b`.`branch_code` AS `branch_code`, `b`.`branch_name` AS `branch_name`, `d`.`district_name` AS `district_name`, `u`.`full_name` AS `controller_name`, `f`.`risk_area` AS `risk_area`, `f`.`severity` AS `severity`, `f`.`finding_title` AS `finding_title`, `f`.`status` AS `status`, `f`.`target_rectification_date` AS `target_rectification_date`, curdate() AS `evaluation_date`, to_days(`f`.`target_rectification_date`) - to_days(curdate()) AS `days_remaining`, CASE WHEN curdate() > `f`.`target_rectification_date` AND `f`.`status` <> 'RECTIFIED' THEN 1 ELSE 0 END AS `is_overdue`, `f`.`created_at` AS `created_at` FROM (((`audit_findings` `f` join `branches` `b` on(`f`.`branch_id` = `b`.`branch_id`)) join `districts` `d` on(`b`.`district_id` = `d`.`district_id`)) join `users` `u` on(`f`.`controller_id` = `u`.`user_id`)) WHERE `f`.`deleted_at` is null ;

-- --------------------------------------------------------

--
-- Structure for view `v_branch_kri_dashboard`
--
DROP TABLE IF EXISTS `v_branch_kri_dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_branch_kri_dashboard`  AS SELECT `b`.`branch_id` AS `branch_id`, `b`.`branch_code` AS `branch_code`, `b`.`branch_name` AS `branch_name`, `b`.`branch_grade` AS `branch_grade`, `b`.`cash_holding_limit` AS `cash_holding_limit`, coalesce((select `cc`.`vault_physical_balance` + `cc`.`teller_tills_physical_total` from `cash_counts` `cc` where `cc`.`branch_id` = `b`.`branch_id` order by `cc`.`count_datetime` desc limit 1),0) AS `latest_total_cash`, CASE WHEN coalesce((select `cc`.`vault_physical_balance` + `cc`.`teller_tills_physical_total` from `cash_counts` `cc` where `cc`.`branch_id` = `b`.`branch_id` order by `cc`.`count_datetime` desc limit 1),0) > `b`.`cash_holding_limit` THEN 1 ELSE 0 END AS `is_cash_holding_limit_breached`, coalesce((select count(0) from `audit_findings` `af` where `af`.`branch_id` = `b`.`branch_id` and `af`.`status` <> 'RECTIFIED' and `af`.`deleted_at` is null),0) AS `open_findings_count`, coalesce((select count(0) from `audit_findings` `af` where `af`.`branch_id` = `b`.`branch_id` and `af`.`severity` = 'CRITICAL' and `af`.`status` <> 'RECTIFIED' and `af`.`deleted_at` is null),0) AS `critical_findings_count` FROM `branches` AS `b` WHERE `b`.`is_active` = 1 AND `b`.`deleted_at` is null ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `action_plan_targets`
--
ALTER TABLE `action_plan_targets`
  ADD PRIMARY KEY (`target_id`),
  ADD KEY `fk_apt_branch` (`branch_id`);

--
-- Indexes for table `audit_findings`
--
ALTER TABLE `audit_findings`
  ADD PRIMARY KEY (`finding_id`),
  ADD UNIQUE KEY `finding_code` (`finding_code`),
  ADD KEY `fk_af_controller` (`controller_id`),
  ADD KEY `idx_audit_findings_sla` (`status`,`target_rectification_date`),
  ADD KEY `idx_audit_findings_branch` (`branch_id`,`status`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`branch_id`),
  ADD UNIQUE KEY `branch_code` (`branch_code`),
  ADD KEY `fk_branch_district` (`district_id`);

--
-- Indexes for table `branch_rcsa_assessments`
--
ALTER TABLE `branch_rcsa_assessments`
  ADD PRIMARY KEY (`rcsa_id`),
  ADD UNIQUE KEY `uq_branch_quarterly_rcsa` (`branch_id`,`assessment_year`,`assessment_quarter`),
  ADD KEY `fk_rcsa_manager` (`manager_id`);

--
-- Indexes for table `cash_counts`
--
ALTER TABLE `cash_counts`
  ADD PRIMARY KEY (`count_id`),
  ADD KEY `fk_cc_controller` (`controller_id`),
  ADD KEY `fk_cc_witness` (`manager_witness_id`),
  ADD KEY `idx_cash_counts_branch` (`branch_id`,`count_datetime`);

--
-- Indexes for table `cash_count_denominations`
--
ALTER TABLE `cash_count_denominations`
  ADD PRIMARY KEY (`denom_id`),
  ADD KEY `fk_ccd_count` (`count_id`);

--
-- Indexes for table `core_banking_sync_logs`
--
ALTER TABLE `core_banking_sync_logs`
  ADD PRIMARY KEY (`sync_id`),
  ADD KEY `idx_sync_time` (`started_at`,`sync_status`);

--
-- Indexes for table `daily_operational_checklists`
--
ALTER TABLE `daily_operational_checklists`
  ADD PRIMARY KEY (`checklist_id`),
  ADD UNIQUE KEY `uq_branch_maker_daily` (`branch_id`,`maker_id`,`checklist_date`),
  ADD KEY `fk_chk_maker` (`maker_id`),
  ADD KEY `idx_checklists_date` (`branch_id`,`checklist_date`);

--
-- Indexes for table `daily_voucher_batches`
--
ALTER TABLE `daily_voucher_batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD UNIQUE KEY `uq_batch_ref_date` (`branch_id`,`batch_reference`,`transaction_date`),
  ADD KEY `fk_batch_maker` (`maker_id`),
  ADD KEY `idx_voucher_batches_date` (`branch_id`,`transaction_date`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`district_id`),
  ADD UNIQUE KEY `district_code` (`district_code`);

--
-- Indexes for table `district_finding_escalations`
--
ALTER TABLE `district_finding_escalations`
  ADD PRIMARY KEY (`escalation_id`),
  ADD KEY `fk_esc_finding` (`finding_id`),
  ADD KEY `fk_esc_officer` (`district_officer_id`);

--
-- Indexes for table `district_monthly_reports`
--
ALTER TABLE `district_monthly_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD UNIQUE KEY `uq_district_monthly_report` (`district_id`,`reporting_month`,`reporting_year`),
  ADD KEY `fk_dmr_officer` (`officer_id`);

--
-- Indexes for table `finding_rectifications`
--
ALTER TABLE `finding_rectifications`
  ADD PRIMARY KEY (`rectification_id`),
  ADD KEY `fk_fr_finding` (`finding_id`),
  ADD KEY `fk_fr_staff` (`assigned_staff_id`),
  ADD KEY `fk_fr_manager` (`manager_id`),
  ADD KEY `fk_fr_controller` (`controller_verified_by`);

--
-- Indexes for table `inspection_templates`
--
ALTER TABLE `inspection_templates`
  ADD PRIMARY KEY (`template_id`),
  ADD UNIQUE KEY `template_code` (`template_code`),
  ADD KEY `fk_it_user` (`created_by_user_id`);

--
-- Indexes for table `kri_threshold_configs`
--
ALTER TABLE `kri_threshold_configs`
  ADD PRIMARY KEY (`config_id`),
  ADD UNIQUE KEY `metric_code` (`metric_code`),
  ADD KEY `fk_kri_user` (`configured_by_user_id`);

--
-- Indexes for table `kyc_aml_reviews`
--
ALTER TABLE `kyc_aml_reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_kyc_branch` (`branch_id`),
  ADD KEY `fk_kyc_controller` (`controller_id`);

--
-- Indexes for table `manager_daily_signoffs`
--
ALTER TABLE `manager_daily_signoffs`
  ADD PRIMARY KEY (`signoff_id`),
  ADD UNIQUE KEY `uq_manager_daily_signoff` (`branch_id`,`signoff_date`),
  ADD KEY `fk_mds_manager` (`manager_id`);

--
-- Indexes for table `operational_incidents`
--
ALTER TABLE `operational_incidents`
  ADD PRIMARY KEY (`incident_id`),
  ADD KEY `fk_inc_branch` (`branch_id`),
  ADD KEY `fk_inc_user` (`reported_by_user_id`);

--
-- Indexes for table `outbox_events`
--
ALTER TABLE `outbox_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `idx_outbox_unprocessed` (`is_processed`,`created_at`);

--
-- Indexes for table `regulatory_filings`
--
ALTER TABLE `regulatory_filings`
  ADD PRIMARY KEY (`filing_id`),
  ADD UNIQUE KEY `filing_reference` (`filing_reference`),
  ADD KEY `fk_rf_user` (`filed_by_user_id`);

--
-- Indexes for table `remediation_extension_requests`
--
ALTER TABLE `remediation_extension_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `fk_ext_finding` (`finding_id`),
  ADD KEY `fk_ext_manager` (`requested_by_manager_id`),
  ADD KEY `fk_ext_officer` (`district_officer_id`);

--
-- Indexes for table `system_audit_logs`
--
ALTER TABLE `system_audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_audit_user_action` (`user_id`,`action_type`,`occurred_at`),
  ADD KEY `idx_audit_occurred` (`occurred_at`);

--
-- Indexes for table `template_checklist_items`
--
ALTER TABLE `template_checklist_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `fk_tci_template` (`template_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_user_branch` (`branch_id`),
  ADD KEY `fk_user_district` (`district_id`),
  ADD KEY `idx_users_role_branch` (`role`,`branch_id`,`is_active`);

--
-- Indexes for table `voucher_audits`
--
ALTER TABLE `voucher_audits`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `fk_va_batch` (`batch_id`),
  ADD KEY `fk_va_controller` (`controller_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `system_audit_logs`
--
ALTER TABLE `system_audit_logs`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action_plan_targets`
--
ALTER TABLE `action_plan_targets`
  ADD CONSTRAINT `fk_apt_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`);

--
-- Constraints for table `audit_findings`
--
ALTER TABLE `audit_findings`
  ADD CONSTRAINT `fk_af_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_af_controller` FOREIGN KEY (`controller_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `fk_branch_district` FOREIGN KEY (`district_id`) REFERENCES `districts` (`district_id`);

--
-- Constraints for table `branch_rcsa_assessments`
--
ALTER TABLE `branch_rcsa_assessments`
  ADD CONSTRAINT `fk_rcsa_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_rcsa_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cash_counts`
--
ALTER TABLE `cash_counts`
  ADD CONSTRAINT `fk_cc_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_cc_controller` FOREIGN KEY (`controller_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_cc_witness` FOREIGN KEY (`manager_witness_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `cash_count_denominations`
--
ALTER TABLE `cash_count_denominations`
  ADD CONSTRAINT `fk_ccd_count` FOREIGN KEY (`count_id`) REFERENCES `cash_counts` (`count_id`) ON DELETE CASCADE;

--
-- Constraints for table `daily_operational_checklists`
--
ALTER TABLE `daily_operational_checklists`
  ADD CONSTRAINT `fk_chk_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_chk_maker` FOREIGN KEY (`maker_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `daily_voucher_batches`
--
ALTER TABLE `daily_voucher_batches`
  ADD CONSTRAINT `fk_batch_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_batch_maker` FOREIGN KEY (`maker_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `district_finding_escalations`
--
ALTER TABLE `district_finding_escalations`
  ADD CONSTRAINT `fk_esc_finding` FOREIGN KEY (`finding_id`) REFERENCES `audit_findings` (`finding_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_esc_officer` FOREIGN KEY (`district_officer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `district_monthly_reports`
--
ALTER TABLE `district_monthly_reports`
  ADD CONSTRAINT `fk_dmr_district` FOREIGN KEY (`district_id`) REFERENCES `districts` (`district_id`),
  ADD CONSTRAINT `fk_dmr_officer` FOREIGN KEY (`officer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `finding_rectifications`
--
ALTER TABLE `finding_rectifications`
  ADD CONSTRAINT `fk_fr_controller` FOREIGN KEY (`controller_verified_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_fr_finding` FOREIGN KEY (`finding_id`) REFERENCES `audit_findings` (`finding_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_fr_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_fr_staff` FOREIGN KEY (`assigned_staff_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `inspection_templates`
--
ALTER TABLE `inspection_templates`
  ADD CONSTRAINT `fk_it_user` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `kri_threshold_configs`
--
ALTER TABLE `kri_threshold_configs`
  ADD CONSTRAINT `fk_kri_user` FOREIGN KEY (`configured_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `kyc_aml_reviews`
--
ALTER TABLE `kyc_aml_reviews`
  ADD CONSTRAINT `fk_kyc_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_kyc_controller` FOREIGN KEY (`controller_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `manager_daily_signoffs`
--
ALTER TABLE `manager_daily_signoffs`
  ADD CONSTRAINT `fk_mds_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_mds_manager` FOREIGN KEY (`manager_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `operational_incidents`
--
ALTER TABLE `operational_incidents`
  ADD CONSTRAINT `fk_inc_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_inc_user` FOREIGN KEY (`reported_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `regulatory_filings`
--
ALTER TABLE `regulatory_filings`
  ADD CONSTRAINT `fk_rf_user` FOREIGN KEY (`filed_by_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `remediation_extension_requests`
--
ALTER TABLE `remediation_extension_requests`
  ADD CONSTRAINT `fk_ext_finding` FOREIGN KEY (`finding_id`) REFERENCES `audit_findings` (`finding_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ext_manager` FOREIGN KEY (`requested_by_manager_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_ext_officer` FOREIGN KEY (`district_officer_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `template_checklist_items`
--
ALTER TABLE `template_checklist_items`
  ADD CONSTRAINT `fk_tci_template` FOREIGN KEY (`template_id`) REFERENCES `inspection_templates` (`template_id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  ADD CONSTRAINT `fk_user_district` FOREIGN KEY (`district_id`) REFERENCES `districts` (`district_id`);

--
-- Constraints for table `voucher_audits`
--
ALTER TABLE `voucher_audits`
  ADD CONSTRAINT `fk_va_batch` FOREIGN KEY (`batch_id`) REFERENCES `daily_voucher_batches` (`batch_id`),
  ADD CONSTRAINT `fk_va_controller` FOREIGN KEY (`controller_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
