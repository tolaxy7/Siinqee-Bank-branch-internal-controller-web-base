<?php

/* Siinqee Bank BICRMS: PHP + MySQL application. Configure credentials before use. */

session_start();



const DB_DSN  = 'mysql:host=localhost;port=3306;dbname=siinqee_bicrms;charset=utf8mb4';

const DB_USER = 'root';

const DB_PASS = '';



// true: the test-role buttons and the demo password work. Set to false once real passwords are in place.

const DEMO_MODE = true;

const DEMO_PASSWORD = 'Siinqee@2026';



$pdo = null;

try {

    $pdo = new PDO(DB_DSN, DB_USER, DB_PASS, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES => false]);

} catch (PDOException $ex) { $dbError = $ex->getMessage(); error_log('BICRMS connection failed: ' . $dbError); }

$dbError = $dbError ?? '';



// Test accounts (used only when DEMO_MODE is true): user_id, employee_id, username, email, name, role

$PERSONAS = [

 ['cccc3333-3333-3333-3333-333333333333', 'SQ-02390', 'tolawaaq.lammeessaa', 'tolawaaq.l@siinqeebank.et', 'Tolawaaq Lammeessaa', 'BRANCH_INTERNAL_CONTROLLER'],

 ['aaaa1111-1111-1111-1111-111111111111', 'SQ-04921', 'anwar.jambo', 'anwar.jambo@siinqeebank.et', 'Anwar Jambo', 'BRANCH_MAKER'],

 ['bbbb2222-2222-2222-2222-222222222222', 'SQ-01822', 'gelisa.dugasa', 'gelisa.dugasa@siinqeebank.et', 'Gelisa Dugasa', 'BRANCH_MANAGER'],

 ['dddd4444-4444-4444-4444-444444444444', 'SQ-00812', 'chala.abdisa', 'chala.abdisa@siinqeebank.et', 'Chala Abdisa', 'DISTRICT_RISK_OFFICER'],

 ['eeee5555-5555-5555-5555-555555555555', 'SQ-00210', 'kumsa.gemechu', 'kumsa.gemechu@siinqeebank.et', 'Kumsa Gemechu', 'HEAD_OFFICE_ADMIN'],

 ['ffff6666-6666-6666-6666-666666666666', 'SQ-00045', 'admin.it', 'sysadmin@siinqeebank.et', 'IT System Administrator', 'SYSTEM_ADMIN'],

];

function find_persona(array $list, string $id): ?array {

    foreach ($list as $p) foreach ([0, 1, 2, 3] as $i) if ($id !== '' && strcasecmp($p[$i], $id) === 0) return $p;

    return null;

}

function persona_user(array $p): array {

    $br = in_array($p[5], ['BRANCH_MAKER', 'BRANCH_MANAGER', 'BRANCH_INTERNAL_CONTROLLER'], true);

    $di = $br || $p[5] === 'DISTRICT_RISK_OFFICER';

    return ['user_id' => $p[0], 'employee_id' => $p[1], 'username' => $p[2], 'email' => $p[3], 'full_name' => $p[4], 'role' => $p[5], 'phone_number' => null,

        'branch_id' => $br ? '33333333-3333-3333-3333-333333333333' : null, 'district_id' => $di ? '11111111-1111-1111-1111-111111111111' : null,

        'branch_name' => $br ? 'Dalo Budena Branch' : null, 'branch_code' => $br ? 'BR-DB01' : null, 'district_name' => $di ? 'Finfinne Central District' : null,

        'last_login_at' => null, 'password_hash' => '', '_demo' => true];

}

function uuid(): string {

    $d = random_bytes(16);

    $d[6] = chr(ord($d[6]) & 0x0f | 0x40);

    $d[8] = chr(ord($d[8]) & 0x3f | 0x80);

    return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($d), 4));

}



// ---------- Access matrix (role order matters) ----------

$ROLES = ['BRANCH_MAKER' => 'Branch Maker', 'BRANCH_MANAGER' => 'Branch Manager', 'BRANCH_INTERNAL_CONTROLLER' => 'Internal Controller', 'DISTRICT_RISK_OFFICER' => 'District Risk Officer', 'HEAD_OFFICE_ADMIN' => 'Head Office Admin', 'SYSTEM_ADMIN' => 'System Admin'];

$LETTER = ['C' => 'Create', 'R' => 'Read', 'U' => 'Update', 'V' => 'Verify', 'A' => 'Approve', 'E' => 'Escalate'];

// key => [label, group, table, columns, order by, scope, permissions for Maker|Manager|Controller|District|HO|SysAdmin]

$M = [

 'checklists' => ['Daily checklists', 'Operations', 'daily_operational_checklists', ['Date' => 'checklist_date', 'Vault opening' => 'vault_opening_witnessed', 'Till limit' => 'teller_till_limit_acknowledged', 'Counterfeit detector' => 'counterfeit_detector_tested', 'Clean desk/screen' => 'clean_desk_clean_screen_verified', 'CCTV' => 'cctv_status_checked', 'Comments' => 'maker_comments'], 'checklist_date', 'branch', 'C,R,U|R,A|R,V|R|R|R'],

 'vouchers' => ['Voucher batches', 'Operations', 'daily_voucher_batches', ['Reference' => 'batch_reference', 'Date' => 'transaction_date', 'Debit' => 'total_debit_amount', 'Credit' => 'total_credit_amount', 'Status' => 'handoff_status'], 'transaction_date', 'branch', 'C,R,U|R,A|R,V|R|R|R'],

 'incidents' => ['Incidents', 'Operations', 'operational_incidents', ['Date' => 'incident_date', 'Type' => 'incident_type', 'Title' => 'incident_title', 'Status' => 'status'], 'incident_date', 'branch', 'C,R|R,U,E|R,V|R,E|R|R'],

 'voucher_audits' => ['Voucher audits', 'Assurance', 'voucher_audits', ['Date' => 'audit_date', 'Audited' => 'audited_vouchers_count', 'Missing' => 'missing_vouchers_count', 'Exceptions' => 'exceptions_detected', 'Status' => 'audit_status'], 'completed_at', 'batch', '-|R|C,R,U,V|R|R|R'],

 'cash_counts' => ['Cash counts', 'Assurance', 'cash_counts', ['When' => 'count_datetime', 'Type' => 'count_type', 'Ledger' => 'vault_ledger_balance', 'Variance' => 'total_variance', 'Witnessed' => 'manager_signed_at'], 'count_datetime', 'branch', '-|R,A (Witness)|C,R,V|R|R|R'],

 'kyc' => ['KYC & AML reviews', 'Assurance', 'kyc_aml_reviews', ['Account' => 'account_number', 'Customer' => 'customer_name', 'Reviewed' => 'review_date', 'Outcome' => 'review_outcome'], 'review_date', 'branch', '-|R|C,R,U,V|R|R|R'],

 'findings' => ['Audit findings', 'Assurance', 'audit_findings', ['Code' => 'finding_code', 'Title' => 'finding_title', 'Severity' => 'severity', 'Due' => 'target_rectification_date', 'Status' => 'status'], 'created_at', 'finding', 'R (Assigned)|R,U (Delegate)|C,R,U,V|R,E|R|R'],

 'rectifications' => ['Rectifications', 'Assurance', 'finding_rectifications', ['Date' => 'rectification_date', 'Action taken' => 'action_taken_description', 'Verification' => 'controller_verification_status'], 'rectification_date', 'rect', 'C,R,U (Upload)|R,A (Endorse)|R,V,A (Close)|R|R|R'],

 'signoffs' => ['Day-end sign-offs', 'Governance', 'manager_daily_signoffs', ['Date' => 'signoff_date', 'EOD ledger' => 'eod_cash_ledger_balance', 'Signed' => 'signed_at'], 'signoff_date', 'branch', '-|C,R,A|R,V|R|R|R'],

 'rcsa' => ['Quarterly RCSA', 'Governance', 'branch_rcsa_assessments', ['Year' => 'assessment_year', 'Quarter' => 'assessment_quarter', 'Risk score' => 'operational_risk_score', 'Compliance' => 'compliance_score', 'Status' => 'district_submission_status'], 'submitted_at', 'branch', '-|C,R,U,E|R,V|R,A|R|R'],

 'extensions' => ['Deadline extensions', 'Governance', 'remediation_extension_requests', ['Current' => 'current_deadline', 'Proposed' => 'proposed_new_deadline', 'Status' => 'review_status'], 'created_at', 'ext', '-|C,R,E|R|R,A (Decide)|R|R'],

 'district_reports' => ['District reports', 'Governance', 'district_monthly_reports', ['Year' => 'reporting_year', 'Month' => 'reporting_month', 'Open' => 'open_findings_count', 'Critical' => 'critical_findings_count', 'KRI score' => 'average_district_kri_score'], 'generated_at', 'district', '-|-|-|C,R,U,E|R,A|R'],

 'templates' => ['Templates & KRIs', 'Policy', 'inspection_templates', ['Code' => 'template_code', 'Title' => 'template_title', 'Area' => 'risk_area', 'Version' => 'template_version', 'Active' => 'is_active'], 'created_at', 'none', '-|R|R (Action Plan)|R|C,R,U,A|R'],

 'filings' => ['NBE & FIS filings', 'Policy', 'regulatory_filings', ['Reference' => 'filing_reference', 'Body' => 'regulatory_body', 'Period' => 'reporting_period', 'Type' => 'filing_type', 'Filed' => 'filed_at'], 'filed_at', 'none', '-|-|-|R|C,R,U,A|R'],

 'audit_trail' => ['Security audit trail', 'Administration', 'system_audit_logs', ['When' => 'occurred_at', 'Action' => 'action_type', 'Entity' => 'entity_name', 'Entity ID' => 'entity_id', 'IP' => 'ip_address'], 'occurred_at', 'none', '-|-|-|-|R|R (Immutable)'],

];

$USERS_PERMS = '-|R (Branch)|R (Branch)|R (District)|R|C,R,U';

$GROUPS = ['Operations', 'Assurance', 'Governance', 'Policy', 'Administration'];



function e($v): string { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }

function perm_of(string $perms, string $role): string {

    global $ROLES;

    return trim(explode('|', $perms)[array_search($role, array_keys($ROLES), true)] ?? '-');

}

function chips(string $p): string {

    global $LETTER;

    if ($p === '-' || $p === '') return '<span class="badge">No access</span>';

    $out = '';

    foreach (explode(',', $p) as $t) {

        if (preg_match('/^\s*([A-Z])\s*(?:\((.+)\))?/', trim($t), $m) && isset($LETTER[$m[1]])) {

            $out .= '<span class="badge ' . ($m[1] === 'R' ? '' : 'on') . '">' . $LETTER[$m[1]] . (!empty($m[2]) ? ' (' . e($m[2]) . ')' : '') . '</span> ';

        }

    }

    return $out;

}

function branch_clause(array $u, string $col = 'branch_id'): array {

    if (in_array($u['role'], ['BRANCH_MAKER', 'BRANCH_MANAGER', 'BRANCH_INTERNAL_CONTROLLER'], true)) return ["$col = ?", [$u['branch_id']]];

    if ($u['role'] === 'DISTRICT_RISK_OFFICER') return ["$col IN (SELECT branch_id FROM branches WHERE district_id = ?)", [$u['district_id']]];

    return ['TRUE', []];

}

function scope(array $u, string $kind): array {

    [$s, $p] = branch_clause($u);

    switch ($kind) {

        case 'branch':   return [$s, $p];

        case 'finding':  return $u['role'] === 'BRANCH_MAKER'

                            ? ['deleted_at IS NULL AND finding_id IN (SELECT finding_id FROM finding_rectifications WHERE assigned_staff_id = ?)', [$u['user_id']]]

                            : ["$s AND deleted_at IS NULL", $p];

        case 'rect':     return $u['role'] === 'BRANCH_MAKER' ? ['assigned_staff_id = ?', [$u['user_id']]]

                            : ["finding_id IN (SELECT finding_id FROM audit_findings WHERE $s)", $p];

        case 'ext':      return ["finding_id IN (SELECT finding_id FROM audit_findings WHERE $s)", $p];

        case 'batch':    return ["batch_id IN (SELECT batch_id FROM daily_voucher_batches WHERE $s)", $p];

        case 'district': return $u['role'] === 'DISTRICT_RISK_OFFICER' ? ['district_id = ?', [$u['district_id']]] : ['TRUE', []];

    }

    return ['TRUE', []];

}

function cell($v, string $col = ''): string {

    if ($v === null || $v === '') return '<span class="dim">—</span>';

    if (is_bool($v) || (preg_match('/^is_|_detected$/', $col) && in_array($v, [0, 1, '0', '1'], true))) return $v ? 'Yes' : 'No';

    $s = (string)$v;

    if (preg_match('/^(\d{4}-\d{2}-\d{2} \d{2}:\d{2})/', $s, $m)) return e($m[1]);

    return e(mb_strlen($s) > 90 ? mb_substr($s, 0, 90) . '…' : $s);

}

function audit(?PDO $pdo, ?string $uid, string $type, string $entity, ?string $eid = null): void {

    if (!$pdo) return;

    try {

        $pdo->prepare("INSERT INTO system_audit_logs (user_id, action_type, entity_name, entity_id, ip_address, user_agent) VALUES (?, ?, ?, ?, ?, ?)")

            ->execute([$uid, $type, $entity, $eid, $_SERVER['REMOTE_ADDR'] ?? null, substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 255)]);

    } catch (Exception $ex) { error_log('BICRMS audit failed: ' . $ex->getMessage()); }

}

function count_rows(?PDO $pdo, string $table, string $where, array $p) {

    if (!$pdo) return null;

    try { $st = $pdo->prepare("SELECT COUNT(*) FROM $table WHERE $where"); $st->execute($p); return (int)$st->fetchColumn(); }

    catch (Exception $ex) { error_log('BICRMS count failed: ' . $ex->getMessage()); return null; }

}

function temp_password(): string { return bin2hex(random_bytes(5)) . '-Aa1'; }

function go(string $to = ''): void { header('Location: ' . basename(__FILE__) . $to); exit; }



$csrf = $_SESSION['csrf'] = $_SESSION['csrf'] ?? bin2hex(random_bytes(16));

[$flash, $ftype] = $_SESSION['flash'] ?? [null, 'ok'];

unset($_SESSION['flash']);

$db = $pdo !== null;



// ---------- Signed-in user ----------

$u = null;

if (!empty($_SESSION['uid'])) {

    if (!empty($_SESSION['demo_user'])) {

        foreach ($PERSONAS as $p) if ($p[0] === $_SESSION['uid']) $u = persona_user($p);

    } elseif ($db) {

        try {

            $st = $pdo->prepare("SELECT u.*, b.branch_name, b.branch_code, d.district_name FROM users u LEFT JOIN branches b ON b.branch_id = u.branch_id LEFT JOIN districts d ON d.district_id = COALESCE(u.district_id, b.district_id) WHERE u.user_id = ? AND u.is_active = 1 AND u.deleted_at IS NULL");

            $st->execute([$_SESSION['uid']]);

            $u = $st->fetch() ?: null;

        } catch (Exception $ex) {

            error_log('BICRMS user load failed: ' . $ex->getMessage());

            try {

                $st = $pdo->prepare("SELECT * FROM users WHERE user_id = ? AND is_active = 1");

                $st->execute([$_SESSION['uid']]);

                $u = $st->fetch() ?: null;

                if ($u) $u += ['branch_name' => null, 'branch_code' => null, 'district_name' => null, 'phone_number' => null, 'last_login_at' => null];

            } catch (Exception $e2) { error_log('BICRMS user fallback failed: ' . $e2->getMessage()); }

        }

    }

    if (!$u) unset($_SESSION['uid'], $_SESSION['demo_user']);

}

$role = $u['role'] ?? '';

$isAdmin = $role === 'SYSTEM_ADMIN';



// ---------- Actions ----------

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $a = $_POST['action'] ?? '';

    $uuid = '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i';



    if (!hash_equals($csrf, (string)($_POST['csrf'] ?? ''))) {

        $flash = 'Your session expired. Please try again.'; $ftype = 'err';



    } elseif ($a === 'login' || ($a === 'quick_login' && DEMO_MODE)) {

        $id = trim($_POST['username_or_email'] ?? ''); $pw = (string)($_POST['password'] ?? ''); $row = null;

        if ($a === 'quick_login') { $id = (string)($_POST['persona'] ?? ''); $pw = DEMO_PASSWORD; }

        if ($db && $id !== '') {

            try {

                $st = $pdo->prepare("SELECT * FROM users WHERE (username = ? OR email = ? OR employee_id = ? OR user_id = ?) AND is_active = 1 AND deleted_at IS NULL LIMIT 1");

                $st->execute([$id, $id, $id, $id]);

                $row = $st->fetch() ?: null;

            } catch (Exception $ex) { error_log('BICRMS login lookup failed: ' . $ex->getMessage()); }

        }

        $demoOk = DEMO_MODE && hash_equals(DEMO_PASSWORD, $pw);

        if ($row && !empty($row['account_locked_until']) && strtotime($row['account_locked_until']) > time()) {

            $flash = 'Too many attempts. Try again in a few minutes.'; $ftype = 'err';

        } else {

            $uid = null; $isDemo = false;

            if ($row && (password_verify($pw, (string)($row['password_hash'] ?? '')) || $demoOk)) $uid = $row['user_id'];

            elseif (!$row && $demoOk && ($pp = find_persona($PERSONAS, $id))) { $uid = $pp[0]; $isDemo = true; }

            if ($uid) {

                if (!$isDemo) {

                    try { $pdo->prepare("UPDATE users SET failed_login_attempts = 0, account_locked_until = NULL, last_login_at = NOW() WHERE user_id = ?")->execute([$uid]); }

                    catch (Exception $ex) { error_log('BICRMS login update failed: ' . $ex->getMessage()); }

                    audit($pdo, $uid, 'LOGIN', 'users', $uid);

                }

                session_regenerate_id(true);

                $_SESSION['uid'] = $uid;

                if ($isDemo) $_SESSION['demo_user'] = 1; else unset($_SESSION['demo_user']);

                $_SESSION['flash'] = ['Welcome back.', 'ok'];

                go();

            }

            if ($row) {

                try {

                    $n = (int)($row['failed_login_attempts'] ?? 0) + 1;

                    if ($n >= 5) $pdo->prepare("UPDATE users SET failed_login_attempts = 0, account_locked_until = NOW() + INTERVAL 15 MINUTE WHERE user_id = ?")->execute([$row['user_id']]);

                    else $pdo->prepare("UPDATE users SET failed_login_attempts = ? WHERE user_id = ?")->execute([$n, $row['user_id']]);

                } catch (Exception $ex) { error_log('BICRMS failed-login update failed: ' . $ex->getMessage()); }

            }

            audit($pdo, $row['user_id'] ?? null, 'LOGIN_FAILED', 'users', $row['user_id'] ?? null);

            $flash = ($db || $demoOk) ? 'Invalid username or password.' : 'The database is not reachable right now.'; $ftype = 'err';

        }



    } elseif (!$u) {

        $flash = 'Please sign in first.'; $ftype = 'err';



    } elseif (!$db && $a !== 'logout') {

        $flash = 'The database is not connected, so this cannot be saved.'; $ftype = 'err';



    } elseif ($a === 'logout') {

        audit($pdo, $u['user_id'], 'LOGOUT', 'users', $u['user_id']);

        unset($_SESSION['uid'], $_SESSION['demo_user']); session_regenerate_id(true);

        $_SESSION['flash'] = ['You have been signed out.', 'ok'];

        go();



    } elseif (in_array($a, ['checklist_create', 'checklist_update'], true)) {
        // Checklist fields match the actual daily_operational_checklists schema.
        if ($role !== 'BRANCH_MAKER' || empty($u['branch_id'])) {
            $flash = 'You do not have permission to manage daily checklists.'; $ftype = 'err';
            $_GET['page'] = 'checklists';
        } else {
            $_GET['page'] = 'checklists';
            $date = trim((string)($_POST['checklist_date'] ?? ''));
            $comments = trim((string)($_POST['maker_comments'] ?? ''));
            $flagNames = [
                'vault_opening_witnessed',
                'teller_till_limit_acknowledged',
                'counterfeit_detector_tested',
                'clean_desk_clean_screen_verified',
                'cctv_status_checked'
            ];
            $flags = [];
            foreach ($flagNames as $field) $flags[$field] = isset($_POST[$field]) ? 1 : 0;
            $validDate = DateTime::createFromFormat('!Y-m-d', $date);

            if (!$validDate || $validDate->format('Y-m-d') !== $date || mb_strlen($comments) > 10000) {
                $flash = 'Check the checklist date and comments length.'; $ftype = 'err';
            } else {
                try {
                    if ($a === 'checklist_create') {
                        $id = uuid();
                        $st = $pdo->prepare(
                            "INSERT INTO daily_operational_checklists
                             (checklist_id, branch_id, maker_id, checklist_date,
                              vault_opening_witnessed, teller_till_limit_acknowledged,
                              counterfeit_detector_tested, clean_desk_clean_screen_verified,
                              cctv_status_checked, maker_comments)
                             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                        );
                        $st->execute([
                            $id, $u['branch_id'], $u['user_id'], $date,
                            $flags['vault_opening_witnessed'],
                            $flags['teller_till_limit_acknowledged'],
                            $flags['counterfeit_detector_tested'],
                            $flags['clean_desk_clean_screen_verified'],
                            $flags['cctv_status_checked'], $comments ?: null
                        ]);
                        audit($pdo, $u['user_id'], 'CHECKLIST_CREATED', 'daily_operational_checklists', $id);
                        $flash = 'Daily operational checklist saved successfully.';
                    } else {
                        $id = (string)($_POST['checklist_id'] ?? '');
                        $st = $pdo->prepare(
                            "UPDATE daily_operational_checklists
                             SET checklist_date = ?, vault_opening_witnessed = ?,
                                 teller_till_limit_acknowledged = ?, counterfeit_detector_tested = ?,
                                 clean_desk_clean_screen_verified = ?, cctv_status_checked = ?,
                                 maker_comments = ?
                             WHERE checklist_id = ? AND branch_id = ? AND maker_id = ?"
                        );
                        $st->execute([
                            $date, $flags['vault_opening_witnessed'],
                            $flags['teller_till_limit_acknowledged'],
                            $flags['counterfeit_detector_tested'],
                            $flags['clean_desk_clean_screen_verified'],
                            $flags['cctv_status_checked'], $comments ?: null,
                            $id, $u['branch_id'], $u['user_id']
                        ]);
                        if ($st->rowCount() > 0) {
                            audit($pdo, $u['user_id'], 'CHECKLIST_UPDATED', 'daily_operational_checklists', $id);
                            $flash = 'Daily operational checklist updated successfully.';
                        } else {
                            $flash = 'No changes saved, or the checklist is not assigned to your account and branch.';
                            $ftype = 'err';
                        }
                    }
                } catch (Throwable $ex) {
                    error_log('BICRMS daily checklist save failed: ' . $ex->getMessage());
                    $flash = 'Could not save the checklist. Confirm that the daily checklist table matches the database schema.';
                    $ftype = 'err';
                }
            }
        }
    } elseif ($a === 'change_password') {

        $cur = (string)($_POST['current_password'] ?? ''); $new = (string)($_POST['new_password'] ?? '');

        if (!empty($u['_demo'])) { $flash = 'Test accounts cannot change a password here.'; $ftype = 'err'; }

        elseif (!password_verify($cur, (string)($u['password_hash'] ?? ''))) { $flash = 'Your current password is not correct.'; $ftype = 'err'; }

        elseif ($new !== (string)($_POST['confirm_password'] ?? '')) { $flash = 'The two new passwords do not match.'; $ftype = 'err'; }

        elseif (strlen($new) < 8 || !preg_match('/[A-Za-z]/', $new) || !preg_match('/\d/', $new)) { $flash = 'Use at least 8 characters, with a letter and a number.'; $ftype = 'err'; }

        else {

            $pdo->prepare("UPDATE users SET password_hash = ? WHERE user_id = ?")->execute([password_hash($new, PASSWORD_BCRYPT), $u['user_id']]);

            audit($pdo, $u['user_id'], 'PASSWORD_CHANGED', 'users', $u['user_id']);

            $_SESSION['flash'] = ['Your password was changed.', 'ok']; go('?page=profile');

        }

        $_GET['page'] = 'profile';



    } elseif ($a === 'create_user' && $isAdmin) {

        $_GET['page'] = 'accounts';

        $f = []; foreach (['employee_id', 'username', 'full_name', 'email', 'phone_number', 'role', 'branch_id', 'district_id'] as $k) $f[$k] = trim($_POST[$k] ?? '');

        $branchRoles = ['BRANCH_MAKER', 'BRANCH_MANAGER', 'BRANCH_INTERNAL_CONTROLLER'];

        if ($f['employee_id'] === '' || strlen($f['employee_id']) > 50 || !preg_match('/^[A-Za-z0-9._-]{3,60}$/', $f['username']) || $f['full_name'] === '' || !filter_var($f['email'], FILTER_VALIDATE_EMAIL) || !isset($ROLES[$f['role']])) {

            $flash = 'Check the employee ID, username (3 to 60 letters, numbers, . _ -), name, email and role.'; $ftype = 'err';

        } elseif (in_array($f['role'], $branchRoles, true) && !preg_match($uuid, $f['branch_id'])) {

            $flash = 'Choose a branch for this role.'; $ftype = 'err';

        } elseif ($f['role'] === 'DISTRICT_RISK_OFFICER' && !preg_match($uuid, $f['district_id'])) {

            $flash = 'Choose a district for this role.'; $ftype = 'err';

        } else {

            $branch = in_array($f['role'], $branchRoles, true) ? $f['branch_id'] : null;

            $district = $f['role'] === 'DISTRICT_RISK_OFFICER' ? $f['district_id'] : null;

            try {

                if ($branch) { $st = $pdo->prepare("SELECT district_id FROM branches WHERE branch_id = ?"); $st->execute([$branch]); $district = $st->fetchColumn() ?: null; }

                $tmp = temp_password(); $newId = uuid();

                $st = $pdo->prepare("INSERT INTO users (user_id, employee_id, username, full_name, email, phone_number, role, branch_id, district_id, password_hash) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

                $st->execute([$newId, $f['employee_id'], $f['username'], $f['full_name'], $f['email'], $f['phone_number'] ?: null, $f['role'], $branch, $district, password_hash($tmp, PASSWORD_BCRYPT)]);

                audit($pdo, $u['user_id'], 'ACCOUNT_CREATED', 'users', $newId);

                $flash = "Account created for {$f['full_name']}. Temporary password (shown once): $tmp"; $f = [];

            } catch (PDOException $ex) {

                $flash = $ex->getCode() === '23000' ? 'That employee ID, username or email is already used.' : 'The account could not be created.'; $ftype = 'err';

                if ($ex->getCode() !== '23000') error_log('BICRMS create user failed: ' . $ex->getMessage());

            }

        }



    } elseif (($a === 'toggle_user' || $a === 'reset_user') && $isAdmin && preg_match($uuid, $_POST['user_id'] ?? '')) {

        $target = $_POST['user_id']; $_GET['page'] = 'accounts';

        if ($a === 'toggle_user' && $target === $u['user_id']) { $flash = 'You cannot deactivate your own account.'; $ftype = 'err'; }

        elseif ($a === 'toggle_user') {

            $pdo->prepare("UPDATE users SET is_active = NOT is_active WHERE user_id = ?")->execute([$target]);

            audit($pdo, $u['user_id'], 'ACCOUNT_TOGGLED', 'users', $target); $flash = 'Account status changed.';

        } else {

            $tmp = temp_password();

            $pdo->prepare("UPDATE users SET password_hash = ?, failed_login_attempts = 0, account_locked_until = NULL WHERE user_id = ?")->execute([password_hash($tmp, PASSWORD_BCRYPT), $target]);

            audit($pdo, $u['user_id'], 'PASSWORD_RESET', 'users', $target); $flash = "Password reset. Temporary password (shown once): $tmp";

        }

    } else { $flash = 'You do not have permission to do that.'; $ftype = 'err'; }

}



// ---------- Route ----------

$page = $_GET['page'] ?? 'home';

$allowedUsersRead = $u && perm_of($USERS_PERMS, $role) !== '-';

if ($u) {

    if ($page === 'accounts' && (!$allowedUsersRead || !$db)) $page = 'home';

    elseif (isset($M[$page]) && perm_of($M[$page][6], $role) === '-') $page = 'home';

    elseif (!isset($M[$page]) && !in_array($page, ['home', 'profile', 'accounts'], true)) $page = 'home';

}

$title = $page === 'home' ? 'Home' : ($page === 'profile' ? 'My profile' : ($page === 'accounts' ? ($isAdmin ? 'Create accounts' : 'Staff directory') : ($M[$page][0] ?? 'Home')));

$mark = '<svg viewBox="0 0 46 30" width="42" height="28" aria-hidden="true"><circle cx="14" cy="15" r="12" fill="#ffc53d"/><circle cx="23" cy="15" r="12" fill="#5eb0ff"/><circle cx="32" cy="15" r="12" fill="#ff7a9a"/></svg>';

function nav_link(string $key, string $label, string $page): string {

    return '<a href="?page=' . e($key) . '"' . ($key === $page ? ' aria-current="page"' : '') . '>' . e($label) . '</a>';

}

?>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title><?= $u ? e($title) . ' | ' : '' ?>Siinqee Bank BICRMS</title>

<link rel="preconnect" href="https\://fonts.googleapis.com">

<link rel="preconnect" href="https\://fonts.gstatic.com" crossorigin>

<link href="https\://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@700&family=Figtree:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>

:root{--ink:#14143a;--muted:#65648a;--line:#e4e2f0;--sun:#ffc53d;--sky:#5eb0ff;--rose:#ff7a9a;--bg:#f6f5fb}

*{box-sizing:border-box}

body{margin:0;background:var(--bg);color:var(--ink);font-family:'Figtree',system-ui,sans-serif;line-height:1.5}

h1,h2,h3,.big{font-family:'Bricolage Grotesque','Figtree',sans-serif;letter-spacing:-.02em;margin:0;line-height:1.15}

:focus-visible{outline:2px solid var(--sun);outline-offset:2px}

.brand{display:flex;align-items:center;gap:.7rem;font:700 1.2rem 'Bricolage Grotesque',sans-serif;letter-spacing:-.02em;color:#fff;text-decoration:none}

.brand svg{isolation:isolate}.brand circle{mix-blend-mode:screen;opacity:.92}.auth .brand{color:var(--ink)}.auth .brand circle{mix-blend-mode:multiply}

.brand small{font:700 .66rem 'Figtree',sans-serif;background:var(--sun);color:var(--ink);padding:.1rem .5rem;border-radius:99px}

.side{position:fixed;inset:0 auto 0 0;width:260px;background:var(--ink);color:#f6f5ff;padding:1.1rem .8rem;overflow-y:auto;z-index:40}

.side .brand{padding:.2rem .5rem 1rem}.side h3{margin:1.1rem .6rem .3rem;font:600 .68rem 'Figtree',sans-serif;letter-spacing:.08em;text-transform:uppercase;color:rgba(246,245,255,.5)}

.side nav a{display:block;position:relative;padding:.55rem .8rem;border-radius:10px;color:rgba(246,245,255,.78);text-decoration:none;font-size:.92rem;font-weight:500}

.side nav a:hover{background:rgba(255,255,255,.08);color:#fff}

.side nav a[aria-current]{background:rgba(255,197,61,.15);color:#fff;font-weight:600}.side nav a[aria-current]::after{content:'';position:absolute;right:.8rem;top:50%;width:6px;height:6px;margin-top:-3px;border-radius:50%;background:var(--sun)}

.main{margin-left:260px;min-height:100vh}

.bar{display:flex;align-items:center;justify-content:space-between;gap:1rem;padding:.8rem 1.75rem;background:#fff;border-bottom:1px solid var(--line);position:sticky;top:0;z-index:30}

.bar h1{font-size:1.35rem}.who{display:flex;align-items:center;gap:.7rem;font-size:.85rem}.who b{display:block}.who small{color:var(--muted)}

.av{width:36px;height:36px;border-radius:50%;background:var(--sun);display:grid;place-items:center;font-weight:700;font-size:.8rem}

.menu-btn{display:none}.content{padding:1.5rem 1.75rem 3rem;max-width:1200px}

.btn{display:inline-block;padding:.55rem 1.1rem;border:1px solid transparent;border-radius:99px;font:600 .88rem 'Figtree',sans-serif;cursor:pointer;text-decoration:none;background:var(--ink);color:#fff}

.btn:hover{background:#26267a}.btn.line{background:#fff;color:var(--ink);border-color:#cfcce3}.btn.sm{padding:.3rem .8rem;font-size:.78rem}.btn.wide{width:100%}

.flash{margin:0 0 1rem;padding:.8rem 1rem;border-radius:12px;font-weight:600;font-size:.92rem;background:#e6f4ea;color:#1e6b3a;overflow-wrap:anywhere}.flash.err{background:#fdecef;color:#9b1c3b}

.hero{position:relative;overflow:hidden;isolation:isolate;background:var(--ink);color:#f6f5ff;border-radius:22px;padding:1.8rem 1.8rem;margin-bottom:1.25rem}

.hero h2{font-size:1.7rem}.hero p{margin:.4rem 0 0;color:rgba(246,245,255,.78)}.hero svg{position:absolute;right:-30px;top:50%;width:320px;max-width:45%;transform:translateY(-50%);z-index:-1}.hero circle{mix-blend-mode:screen;opacity:.9}

.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(190px,1fr));margin-bottom:1.25rem;background:#fff;border:1px solid var(--line);border-radius:18px}

.stat{padding:1rem 1.3rem;border-left:1px solid var(--line)}.stat:first-child{border:0}.stat b{display:block;font:700 1.7rem 'Bricolage Grotesque',sans-serif}.stat span{color:var(--muted);font-size:.85rem}

.panel{background:#fff;border:1px solid var(--line);border-radius:18px;padding:1.3rem;margin-bottom:1.25rem}.panel h2{font-size:1.1rem}.sub{margin:.2rem 0 1rem;color:var(--muted);font-size:.88rem}

.scroll{overflow-x:auto}table{width:100%;border-collapse:collapse;min-width:560px;font-size:.88rem}

th{text-align:left;padding:.6rem .7rem;font-size:.75rem;color:var(--muted);border-bottom:1px solid var(--line);white-space:nowrap}td{padding:.7rem;border-bottom:1px solid var(--line);vertical-align:top}tr:last-child td{border:0}

.dim{color:var(--muted)}.badge{display:inline-block;padding:.1rem .6rem;border-radius:99px;font-size:.72rem;font-weight:700;background:#eceaf6;color:var(--muted);margin:0 .15rem .15rem 0}.badge.on{background:#fff3cf;color:#7a5200}.badge.ok{background:#e6f4ea;color:#1e6b3a}.badge.off{background:#ffe5ec;color:#a3173f}

label{display:block;margin:.8rem 0 .3rem;font-size:.85rem;font-weight:600}

input,select{width:100%;padding:.65rem .8rem;font:inherit;color:var(--ink);background:#fff;border:1px solid #cfcce3;border-radius:12px}input:focus,select:focus{outline:2px solid var(--ink);outline-offset:1px}

.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:0 1rem}.facts{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1rem}.facts dt{font-size:.75rem;font-weight:600;color:var(--muted)}.facts dd{margin:.1rem 0 0;font-weight:600;overflow-wrap:anywhere}

.auth{min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:2rem 1rem}.auth .brand{margin-bottom:1.25rem;font-size:1.4rem}

.card{width:100%;max-width:430px;background:#fff;border:1px solid var(--line);border-radius:24px;padding:2rem;box-shadow:0 24px 60px -30px rgba(20,20,58,.35)}.card h1{font-size:1.6rem;margin-bottom:.3rem}

@media(max-width:900px){.side{transform:translateX(-100%);transition:transform .2s}.side.open{transform:none}.main{margin-left:0}.menu-btn{display:inline-block}.bar,.content{padding-left:1rem;padding-right:1rem}.who span.t{display:none}}

</style>

</head>

<body>

<?php if (!$u): ?>

<main class="auth">

  <a class="brand" href="<?= e(basename(__FILE__)) ?>"><?= $mark ?> Siinqee Bank <small>BICRMS</small></a>

  <section class="card">

    <?php if ($flash): ?><p class="flash <?= $ftype === 'err' ? 'err' : '' ?>" role="alert"><?= e($flash) ?></p><?php endif; ?>

    <?php if (!$db): ?><p class="flash err">The MySQL database is not reachable. Check that XAMPP MySQL is running and the database name, port, username, and password at the top of this file are correct.

      <?php if (in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'], true) && $dbError !== ''): ?><br><small>Reason (shown on this computer only): <?= e($dbError) ?></small><?php endif; ?></p><?php endif; ?>

    <h1>Staff sign in</h1>

    <p class="sub">Branch Internal Control &amp; Risk Management System</p>

    <form method="post">

      <input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="action" value="login">

      <label for="id">Username, email or employee ID</label>

      <input id="id" name="username_or_email" required autofocus autocomplete="username" maxlength="150">

      <label for="pw">Password</label>

      <input id="pw" type="password" name="password" required autocomplete="current-password">

      <button class="btn wide" style="margin-top:1.2rem">Sign in</button>

    </form>

    <p class="sub" style="margin:1rem 0 0;text-align:center">Forgot your password? Ask a System Admin to reset it.</p>

    <?php if (DEMO_MODE): ?>

    <form method="post" style="margin-top:1.1rem;padding:1rem;border-radius:14px;background:#fff8e1;font-size:.82rem">

      <input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="action" value="quick_login">

      <b style="display:block;margin-bottom:.5rem">Demo mode: sign in as a test role (password <?= e(DEMO_PASSWORD) ?>)</b>

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:.4rem"><?php foreach ($PERSONAS as $pp): ?><button class="btn line sm" name="persona" value="<?= e($pp[0]) ?>"><?= e($ROLES[$pp[5]]) ?></button><?php endforeach; ?></div>

    </form>

    <?php endif; ?>

  </section>

</main>



<?php else: ?>

<aside class="side" id="side">

  <a class="brand" href="?page=home"><?= $mark ?> Siinqee Bank <small>BICRMS</small></a>

  <nav>

    <h3>Workspace</h3>

    <?= nav_link('home', 'Home', $page) . nav_link('profile', 'My profile', $page) ?>

    <?php foreach ($GROUPS as $g):

        $links = '';

        if ($g === 'Administration' && $allowedUsersRead && $db) $links .= nav_link('accounts', $isAdmin ? 'Create accounts' : 'Staff directory', $page);

        foreach ($M as $k => $m) if ($m[1] === $g && perm_of($m[6], $role) !== '-') $links .= nav_link($k, $m[0], $page);

        if ($links !== ''): ?><h3><?= e($g) ?></h3><?= $links ?><?php endif;

    endforeach; ?>

  </nav>

</aside>



<div class="main">

  <div class="bar">

    <div style="display:flex;align-items:center;gap:.7rem"><button class="btn line sm menu-btn" id="menuBtn" type="button" aria-controls="side">Menu</button><h1><?= e($title) ?></h1></div>

    <div class="who">

      <span class="av"><?= e(mb_strtoupper(mb_substr($u['full_name'], 0, 1))) ?></span>

      <span class="t"><b><?= e($u['full_name']) ?></b><small><?= e($ROLES[$role]) ?></small></span>

      <form method="post" style="margin:0"><input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="action" value="logout"><button class="btn line sm">Log out</button></form>

    </div>

  </div>



  <main class="content">

  <?php if ($flash): ?><p class="flash <?= $ftype === 'err' ? 'err' : '' ?>" role="status"><?= e($flash) ?></p><?php endif; ?>



  <?php if ($page === 'home'):

    [$fs, $fp] = scope($u, 'finding'); [$rs, $rp] = scope($u, 'rect');

    $canF = perm_of($M['findings'][6], $role) !== '-'; $canR = perm_of($M['rectifications'][6], $role) !== '-';

    $stat = [];

    if ($canF) {

        $stat[] = [count_rows($pdo, 'audit_findings', "$fs AND status <> 'RECTIFIED'", $fp), 'Open findings'];

        $stat[] = [count_rows($pdo, 'audit_findings', "$fs AND status <> 'RECTIFIED' AND target_rectification_date < CURRENT_DATE", $fp), 'Overdue findings'];

    }

    if ($canR) $stat[] = [count_rows($pdo, 'finding_rectifications', "$rs AND controller_verification_status = 'PENDING'", $rp), 'Awaiting verification'];

    if ($allowedUsersRead && in_array($role, ['HEAD_OFFICE_ADMIN', 'SYSTEM_ADMIN'], true)) $stat[] = [count_rows($pdo, 'users', 'is_active = TRUE AND deleted_at IS NULL', []), 'Active staff accounts'];

  ?>

    <section class="hero">

      <svg viewBox="0 0 46 30" aria-hidden="true"><circle cx="14" cy="15" r="12" fill="#ffc53d"/><circle cx="23" cy="15" r="12" fill="#5eb0ff"/><circle cx="32" cy="15" r="12" fill="#ff7a9a"/></svg>

      <h2>Hello, <?= e(explode(' ', $u['full_name'])[0]) ?></h2>

      <p><?= e($ROLES[$role]) ?> &middot; <?= e($u['branch_name'] ? $u['branch_name'] . ' (' . $u['branch_code'] . ')' : ($u['district_name'] ?: 'Head Office')) ?></p>

    </section>

    <?php if ($stat): ?><section class="stats"><?php foreach ($stat as $s): ?><div class="stat"><b><?= $s[0] === null ? '—' : (int)$s[0] ?></b><span><?= e($s[1]) ?></span></div><?php endforeach; ?></section><?php endif; ?>

    <section class="panel">

      <h2>What you can do</h2><p class="sub">Your access, from the bank's access control matrix.</p>

      <div class="scroll"><table><thead><tr><th>Area</th><th>Your access</th></tr></thead><tbody>

        <?php foreach ($M as $k => $m): $p = perm_of($m[6], $role); ?>

          <tr><td><?= $p !== '-' ? nav_link($k, $m[0], '') : '<span class="dim">' . e($m[0]) . '</span>' ?></td><td><?= chips($p) ?></td></tr>

        <?php endforeach; $p = perm_of($USERS_PERMS, $role); ?>

          <tr><td><?= $p !== '-' ? nav_link('accounts', 'User accounts', '') : '<span class="dim">User accounts</span>' ?></td><td><?= chips($p) ?></td></tr>

      </tbody></table></div>

    </section>



  <?php elseif ($page === 'profile'): ?>

    <section class="panel">

      <h2>My profile</h2><p class="sub">Your account details. Contact a System Admin to change them.</p>

      <dl class="facts">

        <div><dt>Full name</dt><dd><?= e($u['full_name']) ?></dd></div><div><dt>Employee ID</dt><dd><?= e($u['employee_id']) ?></dd></div>

        <div><dt>Username</dt><dd><?= e($u['username']) ?></dd></div><div><dt>Email</dt><dd><?= e($u['email']) ?></dd></div>

        <div><dt>Phone</dt><dd><?= cell($u['phone_number']) ?></dd></div><div><dt>Role</dt><dd><?= e($ROLES[$role]) ?></dd></div>

        <div><dt>Branch</dt><dd><?= cell($u['branch_name']) ?></dd></div><div><dt>District</dt><dd><?= cell($u['district_name']) ?></dd></div>

        <div><dt>Last sign-in</dt><dd><?= cell($u['last_login_at']) ?></dd></div>

      </dl>

    </section>

    <section class="panel">

      <h2>Change password</h2><p class="sub">At least 8 characters, with a letter and a number.</p>

      <form method="post" autocomplete="off" style="max-width:420px">

        <input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="action" value="change_password">

        <label for="c1">Current password</label><input id="c1" type="password" name="current_password" required autocomplete="current-password">

        <label for="c2">New password</label><input id="c2" type="password" name="new_password" required minlength="8" autocomplete="new-password">

        <label for="c3">Confirm new password</label><input id="c3" type="password" name="confirm_password" required minlength="8" autocomplete="new-password">

        <button class="btn" style="margin-top:1.1rem">Change password</button>

      </form>

    </section>



    <?php elseif ($page === 'checklists'):
        $canManageChecklist = $role === 'BRANCH_MAKER' && !empty($u['branch_id']);
        $flagNames = [
            'vault_opening_witnessed' => 'Vault opening witnessed',
            'teller_till_limit_acknowledged' => 'Teller till limits acknowledged',
            'counterfeit_detector_tested' => 'Counterfeit detector tested',
            'clean_desk_clean_screen_verified' => 'Clean desk / clean screen verified',
            'cctv_status_checked' => 'CCTV status checked'
        ];
        $editChecklist = null;
        if ($canManageChecklist && isset($_GET['edit']) && $db) {
            try {
                $st = $pdo->prepare(
                    "SELECT checklist_id, checklist_date, vault_opening_witnessed,
                            teller_till_limit_acknowledged, counterfeit_detector_tested,
                            clean_desk_clean_screen_verified, cctv_status_checked, maker_comments
                     FROM daily_operational_checklists
                     WHERE checklist_id = ? AND branch_id = ? AND maker_id = ?"
                );
                $st->execute([(string)$_GET['edit'], $u['branch_id'], $u['user_id']]);
                $editChecklist = $st->fetch() ?: null;
                if (!$editChecklist) { $flash = 'Checklist not found or it is not assigned to your account.'; $ftype = 'err'; }
            } catch (Throwable $ex) {
                error_log('BICRMS checklist edit load failed: ' . $ex->getMessage());
                $flash = 'Unable to load the checklist. Check the daily checklist table schema.'; $ftype = 'err';
            }
        }
        $checklistForm = $editChecklist ?: array_merge([
            'checklist_id' => '', 'checklist_date' => date('Y-m-d'), 'maker_comments' => ''
        ], array_fill_keys(array_keys($flagNames), 0));
        $checklistRows = [];
        $checklistLoadError = false;
        if ($db && !empty($u['branch_id'])) {
            try {
                $st = $pdo->prepare(
                    "SELECT checklist_id, maker_id, checklist_date, vault_opening_witnessed,
                            teller_till_limit_acknowledged, counterfeit_detector_tested,
                            clean_desk_clean_screen_verified, cctv_status_checked,
                            maker_comments, submitted_at
                     FROM daily_operational_checklists
                     WHERE branch_id = ?
                     ORDER BY checklist_date DESC LIMIT 200"
                );
                $st->execute([$u['branch_id']]);
                $checklistRows = $st->fetchAll();
            } catch (Throwable $ex) {
                error_log('BICRMS checklist list failed: ' . $ex->getMessage());
                $checklistLoadError = true;
                $flash = 'Unable to load daily checklists. Check the daily checklist table schema.'; $ftype = 'err';
            }
        }
    ?>
      <section class="panel">
        <h2><?= $editChecklist ? 'Update daily operational checklist' : 'Daily operational checklist' ?></h2>
        <p class="sub">Complete the five required operational checks for the branch. A Branch Maker can create and update only records they created for their own branch.</p>
        <?php if ($canManageChecklist && $db): ?>
        <form method="post">
          <input type="hidden" name="csrf" value="<?= e($csrf) ?>">
          <input type="hidden" name="action" value="<?= $editChecklist ? 'checklist_update' : 'checklist_create' ?>">
          <?php if ($editChecklist): ?>
            <input type="hidden" name="checklist_id" value="<?= e($checklistForm['checklist_id']) ?>">
          <?php endif; ?>
          <div class="grid">
            <div>
              <label for="cl_date">Checklist date</label>
              <input id="cl_date" type="date" name="checklist_date" required value="<?= e($checklistForm['checklist_date']) ?>">
            </div>
            <?php foreach ($flagNames as $field => $caption): ?>
              <div class="check-row">
                <label style="display:flex;align-items:center;gap:.55rem;font-weight:500">
                  <input type="checkbox" name="<?= e($field) ?>" value="1" <?= !empty($checklistForm[$field]) ? 'checked' : '' ?>>
                  <?= e($caption) ?>
                </label>
              </div>
            <?php endforeach; ?>
            <div class="full" style="grid-column:1/-1">
              <label for="cl_comments">Maker comments / exceptions</label>
              <textarea id="cl_comments" name="maker_comments" maxlength="10000" style="width:100%;min-height:90px;padding:.65rem .8rem;border:1px solid #cfcce3;border-radius:12px;font:inherit"><?= e($checklistForm['maker_comments']) ?></textarea>
            </div>
          </div>
          <button class="btn" style="margin-top:1rem"><?= $editChecklist ? 'Save changes' : 'Save checklist' ?></button>
          <?php if ($editChecklist): ?> <a class="btn line" href="?page=checklists">Cancel</a><?php endif; ?>
        </form>
        <?php else: ?>
          <p class="dim">You have read-only access to daily checklists.</p>
        <?php endif; ?>
      </section>

      <section class="panel">
        <h2>Daily checklists for your branch</h2>
        <?php if ($checklistLoadError): ?>
          <p class="flash err">The checklist table could not be read. Check the PHP error log and compare the table columns with the expected schema.</p>
        <?php elseif (!$checklistRows): ?>
          <p class="dim">No checklist records found for this branch yet.</p>
        <?php else: ?>
          <div class="scroll"><table>
            <thead><tr><th>Date</th><?php foreach ($flagNames as $caption): ?><th><?= e($caption) ?></th><?php endforeach; ?><th>Comments</th><th>Recorded</th><?php if ($canManageChecklist): ?><th>Action</th><?php endif; ?></tr></thead>
            <tbody>
            <?php foreach ($checklistRows as $cr): ?>
              <tr>
                <td><?= e($cr['checklist_date']) ?></td>
                <?php foreach (array_keys($flagNames) as $field): ?><td><?= !empty($cr[$field]) ? '<span class="badge on">Yes</span>' : '<span class="badge">No</span>' ?></td><?php endforeach; ?>
                <td><?= cell($cr['maker_comments']) ?></td>
                <td><?= cell($cr['submitted_at']) ?></td>
                <?php if ($canManageChecklist): ?>
                  <td><?php if ((string)$cr['maker_id'] === (string)$u['user_id']): ?>
                    <a class="btn line sm" href="?page=checklists&amp;edit=<?= rawurlencode($cr['checklist_id']) ?>">Edit</a>
                  <?php else: ?><span class="dim">View only</span><?php endif; ?></td>
                <?php endif; ?>
              </tr>
            <?php endforeach; ?>
            </tbody>
          </table></div>
        <?php endif; ?>
      </section>

  <?php elseif ($page === 'accounts'):

    $branches = $districts = [];

    if ($isAdmin) {

        $branches = $pdo->query("SELECT branch_id, branch_code, branch_name FROM branches WHERE deleted_at IS NULL ORDER BY branch_name")->fetchAll();

        $districts = $pdo->query("SELECT district_id, district_name FROM districts ORDER BY district_name")->fetchAll();

    }

    if ($role === 'HEAD_OFFICE_ADMIN' || $isAdmin) { $w = 'TRUE'; $wp = []; }

    elseif ($role === 'DISTRICT_RISK_OFFICER') { $w = '(u.district_id = ? OR u.branch_id IN (SELECT branch_id FROM branches WHERE district_id = ?))'; $wp = [$u['district_id'], $u['district_id']]; }

    else { $w = 'u.branch_id = ?'; $wp = [$u['branch_id']]; }

    $st = $pdo->prepare("SELECT u.user_id, u.employee_id, u.full_name, u.username, u.email, u.role, u.is_active, u.last_login_at, b.branch_name FROM users u LEFT JOIN branches b ON b.branch_id = u.branch_id WHERE u.deleted_at IS NULL AND $w ORDER BY u.full_name LIMIT 200");

    $st->execute($wp); $rows = $st->fetchAll();

    $v = $f ?? [];

  ?>

    <?php if ($isAdmin): ?>

    <section class="panel">

      <h2>Create an account</h2><p class="sub">A temporary password is generated and shown once. The person should change it after signing in.</p>

      <form method="post" autocomplete="off">

        <input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="action" value="create_user">

        <div class="grid">

          <div><label for="a1">Employee ID *</label><input id="a1" name="employee_id" required maxlength="50" value="<?= e($v['employee_id'] ?? '') ?>"></div>

          <div><label for="a2">Username *</label><input id="a2" name="username" required maxlength="60" value="<?= e($v['username'] ?? '') ?>"></div>

          <div><label for="a3">Full name *</label><input id="a3" name="full_name" required maxlength="120" value="<?= e($v['full_name'] ?? '') ?>"></div>

          <div><label for="a4">Email *</label><input id="a4" type="email" name="email" required maxlength="120" value="<?= e($v['email'] ?? '') ?>"></div>

          <div><label for="a5">Phone</label><input id="a5" name="phone_number" maxlength="30" value="<?= e($v['phone_number'] ?? '') ?>"></div>

          <div><label for="a6">Role *</label><select id="a6" name="role" required><?php foreach ($ROLES as $k => $l): ?><option value="<?= e($k) ?>"<?= ($v['role'] ?? '') === $k ? ' selected' : '' ?>><?= e($l) ?></option><?php endforeach; ?></select></div>

          <div><label for="a7">Branch (branch roles)</label><select id="a7" name="branch_id"><option value="">None</option><?php foreach ($branches as $b): ?><option value="<?= e($b['branch_id']) ?>"<?= ($v['branch_id'] ?? '') === $b['branch_id'] ? ' selected' : '' ?>><?= e($b['branch_name'] . ' (' . $b['branch_code'] . ')') ?></option><?php endforeach; ?></select></div>

          <div><label for="a8">District (District Risk Officer)</label><select id="a8" name="district_id"><option value="">None</option><?php foreach ($districts as $d): ?><option value="<?= e($d['district_id']) ?>"<?= ($v['district_id'] ?? '') === $d['district_id'] ? ' selected' : '' ?>><?= e($d['district_name']) ?></option><?php endforeach; ?></select></div>

        </div>

        <button class="btn" style="margin-top:1.1rem">Create account</button>

      </form>

    </section>

    <?php endif; ?>

    <section class="panel">

      <h2><?= $isAdmin ? 'All accounts' : 'Staff in your ' . ($role === 'DISTRICT_RISK_OFFICER' ? 'district' : ($role === 'HEAD_OFFICE_ADMIN' ? 'bank' : 'branch')) ?></h2>

      <p class="sub"><?= count($rows) ?> shown</p>

      <div class="scroll"><table><thead><tr><th>Name</th><th>Employee ID</th><th>Role</th><th>Branch</th><th>Status</th><th>Last sign-in</th><?= $isAdmin ? '<th>Actions</th>' : '' ?></tr></thead><tbody>

      <?php foreach ($rows as $r): ?>

        <tr><td><b><?= e($r['full_name']) ?></b><div class="dim"><?= e($r['email']) ?></div></td><td><?= e($r['employee_id']) ?></td><td><?= e($ROLES[$r['role']] ?? $r['role']) ?></td><td><?= cell($r['branch_name']) ?></td>

          <td><span class="badge <?= $r['is_active'] ? 'ok' : 'off' ?>"><?= $r['is_active'] ? 'Active' : 'Inactive' ?></span></td><td><?= cell($r['last_login_at']) ?></td>

          <?php if ($isAdmin): ?><td>

            <form method="post" style="display:inline"><input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="user_id" value="<?= e($r['user_id']) ?>"><input type="hidden" name="action" value="toggle_user"><button class="btn line sm"><?= $r['is_active'] ? 'Deactivate' : 'Activate' ?></button></form>

            <form method="post" style="display:inline"><input type="hidden" name="csrf" value="<?= e($csrf) ?>"><input type="hidden" name="user_id" value="<?= e($r['user_id']) ?>"><input type="hidden" name="action" value="reset_user"><button class="btn line sm" onclick="return confirm('Reset this password?')">Reset password</button></form>

          </td><?php endif; ?></tr>

      <?php endforeach; ?>

      </tbody></table></div>

    </section>



  <?php else:

    [$label, , $table, $cols, $order, $kind] = $M[$page]; [$sw, $sp] = scope($u, $kind);

    $rows = []; $err = false; $fetchError = '';

    try {

        $st = $pdo->prepare('SELECT ' . implode(', ', $cols) . " FROM $table WHERE $sw ORDER BY $order DESC LIMIT 50");

        $st->execute($sp); $rows = $st->fetchAll();

    } catch (Throwable $ex) {
        error_log("BICRMS $table list failed: " . $ex->getMessage());
        $err = true;
        if (in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'], true)) $fetchError = $ex->getMessage();
    }

  ?>

    <section class="panel">

      <h2><?= e($label) ?></h2>

      <p class="sub">Your access: <?= chips(perm_of($M[$page][6], $role)) ?></p>

      <?php if ($err): ?><p class="dim">This list could not be loaded right now.<?php if ($fetchError !== ''): ?><br><small>Local diagnostic: <?= e($fetchError) ?></small><?php endif; ?></p>

      <?php elseif (!$rows): ?><p class="dim">Nothing to show yet.</p>

      <?php else: ?>

        <div class="scroll"><table><thead><tr><?php foreach (array_keys($cols) as $h): ?><th><?= e($h) ?></th><?php endforeach; ?></tr></thead><tbody>

        <?php foreach ($rows as $r): ?><tr><?php foreach ($cols as $c): ?><td><?= cell($r[$c] ?? null, $c) ?></td><?php endforeach; ?></tr><?php endforeach; ?>

        </tbody></table></div>

        <p class="sub" style="margin:.8rem 0 0">Latest <?= count($rows) ?> records you are allowed to see.</p>

      <?php endif; ?>

    </section>

  <?php endif; ?>

  </main>

</div>

<script>

var s = document.getElementById('side'), b = document.getElementById('menuBtn');

if (b) b.addEventListener('click', function () { s.classList.toggle('open'); });

</script>

<?php endif; ?>

</body>

</html>
