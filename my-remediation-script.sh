###############################################################################

###############################################################################

###############################################################################
# BEGIN fix (1 / 126) for 'xccdf_org.ssgproject.content_rule_package_aide_installed'
###############################################################################
(>&2 echo "Remediating rule 1/126: 'xccdf_org.ssgproject.content_rule_package_aide_installed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "aide"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_aide_installed'

###############################################################################
# BEGIN fix (2 / 126) for 'xccdf_org.ssgproject.content_rule_aide_build_database'
###############################################################################
(>&2 echo "Remediating rule 2/126: 'xccdf_org.ssgproject.content_rule_aide_build_database'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "aide"

AIDE_CONFIG=/etc/aide/aide.conf
DEFAULT_DB_PATH=/var/lib/aide/aide.db

# Fix db path in the config file, if necessary
if ! grep -q '^database=file:' ${AIDE_CONFIG}; then
    # replace_or_append gets confused by 'database=file' as a key, so should not be used.
    #replace_or_append "${AIDE_CONFIG}" '^database=file' "${DEFAULT_DB_PATH}" '@CCENUM@' '%s:%s'
    echo "database=file:${DEFAULT_DB_PATH}" >> ${AIDE_CONFIG}
fi

# Fix db out path in the config file, if necessary
if ! grep -q '^database_out=file:' ${AIDE_CONFIG}; then
    echo "database_out=file:${DEFAULT_DB_PATH}.new" >> ${AIDE_CONFIG}
fi

/usr/sbin/aideinit -y -f

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_aide_build_database'

###############################################################################
# BEGIN fix (3 / 126) for 'xccdf_org.ssgproject.content_rule_aide_check_audit_tools'
###############################################################################
(>&2 echo "Remediating rule 3/126: 'xccdf_org.ssgproject.content_rule_aide_check_audit_tools'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "aide"








if grep -i '^.*/usr/sbin/auditctl.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/auditctl.*#/usr/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

if grep -i '^.*/usr/sbin/auditd.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/auditd.*#/usr/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

if grep -i '^.*/usr/sbin/ausearch.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/ausearch.*#/usr/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

if grep -i '^.*/usr/sbin/aureport.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/aureport.*#/usr/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

if grep -i '^.*/usr/sbin/autrace.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/autrace.*#/usr/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

if grep -i '^.*/usr/sbin/augenrules.*$' /etc/aide/aide.conf; then
sed -i "s#.*/usr/sbin/augenrules.*#/usr/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512#" /etc/aide/aide.conf
else
echo "/usr/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_aide_check_audit_tools'

###############################################################################
# BEGIN fix (4 / 126) for 'xccdf_org.ssgproject.content_rule_aide_periodic_cron_checking'
###############################################################################
(>&2 echo "Remediating rule 4/126: 'xccdf_org.ssgproject.content_rule_aide_periodic_cron_checking'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "aide"

# AiDE usually adds its own cron jobs to /etc/cron.daily. If script is there, this rule is
# compliant. Otherwise, we copy the script to the /etc/cron.weekly
if ! grep -Eq '^(\/usr\/bin\/)?aide(\.wrapper)?\s+' /etc/cron.*/*; then
    cp -f /usr/share/aide/config/cron.daily/aide /etc/cron.weekly/
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_aide_periodic_cron_checking'

###############################################################################
# BEGIN fix (5 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_home'
###############################################################################
(>&2 echo "Remediating rule 5/126: 'xccdf_org.ssgproject.content_rule_partition_for_home'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_home' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_home'

###############################################################################
# BEGIN fix (6 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_tmp'
###############################################################################
(>&2 echo "Remediating rule 6/126: 'xccdf_org.ssgproject.content_rule_partition_for_tmp'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_tmp' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_tmp'

###############################################################################
# BEGIN fix (7 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_var'
###############################################################################
(>&2 echo "Remediating rule 7/126: 'xccdf_org.ssgproject.content_rule_partition_for_var'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_var' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_var'

###############################################################################
# BEGIN fix (8 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_var_log'
###############################################################################
(>&2 echo "Remediating rule 8/126: 'xccdf_org.ssgproject.content_rule_partition_for_var_log'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_var_log' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_var_log'

###############################################################################
# BEGIN fix (9 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_var_log_audit'
###############################################################################
(>&2 echo "Remediating rule 9/126: 'xccdf_org.ssgproject.content_rule_partition_for_var_log_audit'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_var_log_audit' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_var_log_audit'

###############################################################################
# BEGIN fix (10 / 126) for 'xccdf_org.ssgproject.content_rule_partition_for_var_tmp'
###############################################################################
(>&2 echo "Remediating rule 10/126: 'xccdf_org.ssgproject.content_rule_partition_for_var_tmp'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_partition_for_var_tmp' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_partition_for_var_tmp'

###############################################################################
# BEGIN fix (11 / 126) for 'xccdf_org.ssgproject.content_rule_sudo_custom_logfile'
###############################################################################
(>&2 echo "Remediating rule 11/126: 'xccdf_org.ssgproject.content_rule_sudo_custom_logfile'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'sudo' 2>/dev/null | grep -q '^installed'; then

var_sudo_logfile='/var/log/sudo.log'


if /usr/sbin/visudo -qcf /etc/sudoers; then
    cp /etc/sudoers /etc/sudoers.bak
    if ! grep -P '^[\s]*Defaults[\s]*\blogfile\s*=\s*(?:"?([^",\s]+)"?)\b.*$' /etc/sudoers; then
        # sudoers file doesn't define Option logfile
        echo "Defaults logfile=${var_sudo_logfile}" >> /etc/sudoers
    else
        # sudoers file defines Option logfile, remediate if appropriate value is not set
        if ! grep -P "^[\s]*Defaults.*\blogfile=${var_sudo_logfile}\b.*$" /etc/sudoers; then
            
            escaped_variable=${var_sudo_logfile//$'/'/$'\/'}
            sed -Ei "s/(^[\s]*Defaults.*\blogfile=)[-]?.+(\b.*$)/\1$escaped_variable\2/" /etc/sudoers
        fi
    fi
    
    # Check validity of sudoers and cleanup bak
    if /usr/sbin/visudo -qcf /etc/sudoers; then
        rm -f /etc/sudoers.bak
    else
        echo "Fail to validate remediated /etc/sudoers, reverting to original file."
        mv /etc/sudoers.bak /etc/sudoers
        false
    fi
else
    echo "Skipping remediation, /etc/sudoers failed to validate"
    false
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sudo_custom_logfile'

###############################################################################
# BEGIN fix (12 / 126) for 'xccdf_org.ssgproject.content_rule_sudo_require_reauthentication'
###############################################################################
(>&2 echo "Remediating rule 12/126: 'xccdf_org.ssgproject.content_rule_sudo_require_reauthentication'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'sudo' 2>/dev/null | grep -q '^installed'; then

var_sudo_timestamp_timeout='15'


if grep -Px '^[\s]*Defaults.*timestamp_timeout[\s]*=.*' /etc/sudoers.d/*; then
    find /etc/sudoers.d/ -type f -exec sed -Ei "/^[[:blank:]]*Defaults.*timestamp_timeout[[:blank:]]*=.*/d" {} \;
fi

if /usr/sbin/visudo -qcf /etc/sudoers; then
    cp /etc/sudoers /etc/sudoers.bak
    if ! grep -P '^[\s]*Defaults.*timestamp_timeout[\s]*=[\s]*[-]?\w+.*$' /etc/sudoers; then
        # sudoers file doesn't define Option timestamp_timeout
        echo "Defaults timestamp_timeout=${var_sudo_timestamp_timeout}" >> /etc/sudoers
    else
        # sudoers file defines Option timestamp_timeout, remediate wrong values if present
        if grep -qP "^[\s]*Defaults\s.*\btimestamp_timeout[\s]*=[\s]*(?!${var_sudo_timestamp_timeout}\b)[-]?\w+\b.*$" /etc/sudoers; then
            sed -Ei "s/(^[[:blank:]]*Defaults.*timestamp_timeout[[:blank:]]*=)[[:blank:]]*[-]?\w+(.*$)/\1${var_sudo_timestamp_timeout}\2/" /etc/sudoers
        fi
    fi
    
    # Check validity of sudoers and cleanup bak
    if /usr/sbin/visudo -qcf /etc/sudoers; then
        rm -f /etc/sudoers.bak
    else
        echo "Fail to validate remediated /etc/sudoers, reverting to original file."
        mv /etc/sudoers.bak /etc/sudoers
        false
    fi
else
    echo "Skipping remediation, /etc/sudoers failed to validate"
    false
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sudo_require_reauthentication'

###############################################################################
# BEGIN fix (13 / 126) for 'xccdf_org.ssgproject.content_rule_banner_etc_issue'
###############################################################################
(>&2 echo "Remediating rule 13/126: 'xccdf_org.ssgproject.content_rule_banner_etc_issue'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

login_banner_text='^Authorized[\s\n]+users[\s\n]+only\.[\s\n]+All[\s\n]+activity[\s\n]+may[\s\n]+be[\s\n]+monitored[\s\n]+and[\s\n]+reported\.$'


# Multiple regexes transform the banner regex into a usable banner
# 0 - Remove anchors around the banner text
login_banner_text=$(echo "$login_banner_text" | sed 's/^\^\(.*\)\$$/\1/g')
# 1 - Keep only the first banners if there are multiple
#    (dod_banners contains the long and short banner)
login_banner_text=$(echo "$login_banner_text" | sed 's/^(\(.*\.\)|.*)$/\1/g')
# 2 - Add spaces ' '. (Transforms regex for "space or newline" into a " ")
login_banner_text=$(echo "$login_banner_text" | sed 's/\[\\s\\n\]+/ /g')
# 3 - Adds newlines. (Transforms "(?:\[\\n\]+|(?:\\n)+)" into "\n")
login_banner_text=$(echo "$login_banner_text" | sed 's/(?:\[\\n\]+|(?:\\\\n)+)/\n/g')
# 4 - Remove any leftover backslash. (From any parethesis in the banner, for example).
login_banner_text=$(echo "$login_banner_text" | sed 's/\\//g')
formatted=$(echo "$login_banner_text" | fold -sw 80)
cat <<EOF >/etc/issue
$formatted
EOF

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_banner_etc_issue'

###############################################################################
# BEGIN fix (14 / 126) for 'xccdf_org.ssgproject.content_rule_banner_etc_issue_net'
###############################################################################
(>&2 echo "Remediating rule 14/126: 'xccdf_org.ssgproject.content_rule_banner_etc_issue_net'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

remote_login_banner_text='^Authorized[\s\n]+uses[\s\n]+only\.[\s\n]+All[\s\n]+activity[\s\n]+may[\s\n]+be[\s\n]+monitored[\s\n]+and[\s\n]+reported\.$'


# Multiple regexes transform the banner regex into a usable banner
# 0 - Remove anchors around the banner text
remote_login_banner_text=$(echo "$remote_login_banner_text" | sed 's/^\^\(.*\)\$$/\1/g')
# 1 - Keep only the first banners if there are multiple
#    (dod_banners contains the long and short banner)
remote_login_banner_text=$(echo "$remote_login_banner_text" | sed 's/^(\(.*\.\)|.*)$/\1/g')
# 2 - Add spaces ' '. (Transforms regex for "space or newline" into a " ")
remote_login_banner_text=$(echo "$remote_login_banner_text" | sed 's/\[\\s\\n\]+/ /g')
# 3 - Adds newlines. (Transforms "(?:\[\\n\]+|(?:\\n)+)" into "\n")
remote_login_banner_text=$(echo "$remote_login_banner_text" | sed 's/(?:\[\\n\]+|(?:\\\\n)+)/\n/g')
# 4 - Remove any leftover backslash. (From any parethesis in the banner, for example).
remote_login_banner_text=$(echo "$remote_login_banner_text" | sed 's/\\//g')
formatted=$(echo "$remote_login_banner_text" | fold -sw 80)

cat <<EOF >/etc/issue.net
$formatted
EOF

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_banner_etc_issue_net'

###############################################################################
# BEGIN fix (15 / 126) for 'xccdf_org.ssgproject.content_rule_package_pam_pwquality_installed'
###############################################################################
(>&2 echo "Remediating rule 15/126: 'xccdf_org.ssgproject.content_rule_package_pam_pwquality_installed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "libpam-pwquality"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_pam_pwquality_installed'

###############################################################################
# BEGIN fix (16 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_unix_remember'
###############################################################################
(>&2 echo "Remediating rule 16/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_unix_remember'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_unix_remember='5'



config_file="/usr/share/pam-configs/cac_unix"



conf_name=cac_unix
conf_path="/usr/share/pam-configs"

if [ ! -f "$conf_path"/"$conf_name" ]; then
    if [ -f "$conf_path"/unix ]; then
        if grep -q "$(md5sum "$conf_path"/unix | cut -d ' ' -f 1)" /var/lib/dpkg/info/libpam-runtime.md5sums;then
            cp "$conf_path"/unix "$conf_path"/"$conf_name"
            sed -i 's/Priority: [0-9]\+/Priority: 257\
Conflicts: unix/' "$conf_path"/"$conf_name"
            DEBIAN_FRONTEND=noninteractive pam-auth-update
        else
            echo "Not applicable - checksum of $conf_path/unix does not match the original." >&2
        fi
    else
        echo "Not applicable - $conf_path/unix does not exist" >&2
    fi
fi
sed -i -E '/^Password:/,/^[^[:space:]]/ {
    /pam_unix\.so/ {
        s/\s*remember=[^[:space:]]*//g
        s/$/ remember='"$var_password_pam_unix_remember"'/g
    }
}' "$config_file"

sed -i -E '/^Password-Initial:/,/^[^[:space:]]/ {
    /pam_unix\.so/ {
        s/\s*remember=[^[:space:]]*//g
        s/$/ remember='"$var_password_pam_unix_remember"'/g
    }
}' "$config_file"

DEBIAN_FRONTEND=noninteractive pam-auth-update

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_unix_remember'

###############################################################################
# BEGIN fix (17 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny'
###############################################################################
(>&2 echo "Remediating rule 17/126: 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_accounts_passwords_pam_faillock_deny='4'


if [ -f /usr/bin/authselect ]; then
    if ! authselect check; then
echo "
authselect integrity check failed. Remediation aborted!
This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
It is not recommended to manually edit the PAM files when authselect tool is available.
In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
exit 1
fi
authselect enable-feature with-faillock

authselect apply-changes -b
else
    
conf_name=cac_faillock

if [ ! -f /usr/share/pam-configs/"$conf_name" ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"
Name: Enable pam_faillock to deny access
Default: yes
Conflicts: faillock
Priority: 0
Auth-Type: Primary
Auth:
    [default=die]                   pam_faillock.so authfail
EOF
fi

if [ ! -f /usr/share/pam-configs/"$conf_name"_notify ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"_notify
Name: Notify of failed login attempts and reset count upon success
Default: yes
Conflicts: faillock_notify
Priority: 1025
Auth-Type: Primary
Auth:
    requisite                       pam_faillock.so preauth
Account-Type: Primary
Account:
    required                        pam_faillock.so
EOF
fi

DEBIAN_FRONTEND=noninteractive pam-auth-update


fi

AUTH_FILES=("/etc/pam.d/common-auth")
SKIP_FAILLOCK_CHECK=true

FAILLOCK_CONF="/etc/security/faillock.conf"
if [ -f $FAILLOCK_CONF ] || [ "$SKIP_FAILLOCK_CHECK" = "true" ]; then
    regex="^\s*deny\s*="
    line="deny = $var_accounts_passwords_pam_faillock_deny"
    if ! grep -q $regex $FAILLOCK_CONF; then
        echo $line >> $FAILLOCK_CONF
    else
        sed -i --follow-symlinks 's|^\s*\(deny\s*=\s*\)\(\S\+\)|\1'"$var_accounts_passwords_pam_faillock_deny"'|g' $FAILLOCK_CONF
    fi
    
else
    for pam_file in "${AUTH_FILES[@]}"
    do
        if ! grep -qE '^\s*auth.*pam_faillock\.so (preauth|authfail).*deny' "$pam_file"; then
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*preauth.*silent.*/ s/$/ deny='"$var_accounts_passwords_pam_faillock_deny"'/' "$pam_file"
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*authfail.*/ s/$/ deny='"$var_accounts_passwords_pam_faillock_deny"'/' "$pam_file"
        else
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*preauth.*silent.*\)\('"deny"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_deny"'\3/' "$pam_file"
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*authfail.*\)\('"deny"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_deny"'\3/' "$pam_file"
        fi
    done
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny'

###############################################################################
# BEGIN fix (18 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_interval'
###############################################################################
(>&2 echo "Remediating rule 18/126: 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_interval'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_accounts_passwords_pam_faillock_fail_interval='900'


if [ -f /usr/bin/authselect ]; then
    if ! authselect check; then
echo "
authselect integrity check failed. Remediation aborted!
This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
It is not recommended to manually edit the PAM files when authselect tool is available.
In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
exit 1
fi
authselect enable-feature with-faillock

authselect apply-changes -b
else
    
conf_name=cac_faillock

if [ ! -f /usr/share/pam-configs/"$conf_name" ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"
Name: Enable pam_faillock to deny access
Default: yes
Conflicts: faillock
Priority: 0
Auth-Type: Primary
Auth:
    [default=die]                   pam_faillock.so authfail
EOF
fi

if [ ! -f /usr/share/pam-configs/"$conf_name"_notify ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"_notify
Name: Notify of failed login attempts and reset count upon success
Default: yes
Conflicts: faillock_notify
Priority: 1025
Auth-Type: Primary
Auth:
    requisite                       pam_faillock.so preauth
Account-Type: Primary
Account:
    required                        pam_faillock.so
EOF
fi

DEBIAN_FRONTEND=noninteractive pam-auth-update


fi

AUTH_FILES=("/etc/pam.d/common-auth")
SKIP_FAILLOCK_CHECK=true

FAILLOCK_CONF="/etc/security/faillock.conf"
if [ -f $FAILLOCK_CONF ] || [ "$SKIP_FAILLOCK_CHECK" = "true" ]; then
    regex="^\s*fail_interval\s*="
    line="fail_interval = $var_accounts_passwords_pam_faillock_fail_interval"
    if ! grep -q $regex $FAILLOCK_CONF; then
        echo $line >> $FAILLOCK_CONF
    else
        sed -i --follow-symlinks 's|^\s*\(fail_interval\s*=\s*\)\(\S\+\)|\1'"$var_accounts_passwords_pam_faillock_fail_interval"'|g' $FAILLOCK_CONF
    fi
    
else
    for pam_file in "${AUTH_FILES[@]}"
    do
        if ! grep -qE '^\s*auth.*pam_faillock\.so (preauth|authfail).*fail_interval' "$pam_file"; then
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*preauth.*silent.*/ s/$/ fail_interval='"$var_accounts_passwords_pam_faillock_fail_interval"'/' "$pam_file"
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*authfail.*/ s/$/ fail_interval='"$var_accounts_passwords_pam_faillock_fail_interval"'/' "$pam_file"
        else
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*preauth.*silent.*\)\('"fail_interval"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_fail_interval"'\3/' "$pam_file"
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*authfail.*\)\('"fail_interval"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_fail_interval"'\3/' "$pam_file"
        fi
    done
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_interval'

###############################################################################
# BEGIN fix (19 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_unlock_time'
###############################################################################
(>&2 echo "Remediating rule 19/126: 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_unlock_time'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_accounts_passwords_pam_faillock_unlock_time='600'


if [ -f /usr/bin/authselect ]; then
    if ! authselect check; then
echo "
authselect integrity check failed. Remediation aborted!
This remediation could not be applied because an authselect profile was not selected or the selected profile is not intact.
It is not recommended to manually edit the PAM files when authselect tool is available.
In cases where the default authselect profile does not cover a specific demand, a custom authselect profile is recommended."
exit 1
fi
authselect enable-feature with-faillock

authselect apply-changes -b
else
    
conf_name=cac_faillock

if [ ! -f /usr/share/pam-configs/"$conf_name" ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"
Name: Enable pam_faillock to deny access
Default: yes
Conflicts: faillock
Priority: 0
Auth-Type: Primary
Auth:
    [default=die]                   pam_faillock.so authfail
EOF
fi

if [ ! -f /usr/share/pam-configs/"$conf_name"_notify ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"_notify
Name: Notify of failed login attempts and reset count upon success
Default: yes
Conflicts: faillock_notify
Priority: 1025
Auth-Type: Primary
Auth:
    requisite                       pam_faillock.so preauth
Account-Type: Primary
Account:
    required                        pam_faillock.so
EOF
fi

DEBIAN_FRONTEND=noninteractive pam-auth-update


fi

AUTH_FILES=("/etc/pam.d/common-auth")
SKIP_FAILLOCK_CHECK=true

FAILLOCK_CONF="/etc/security/faillock.conf"
if [ -f $FAILLOCK_CONF ] || [ "$SKIP_FAILLOCK_CHECK" = "true" ]; then
    regex="^\s*unlock_time\s*="
    line="unlock_time = $var_accounts_passwords_pam_faillock_unlock_time"
    if ! grep -q $regex $FAILLOCK_CONF; then
        echo $line >> $FAILLOCK_CONF
    else
        sed -i --follow-symlinks 's|^\s*\(unlock_time\s*=\s*\)\(\S\+\)|\1'"$var_accounts_passwords_pam_faillock_unlock_time"'|g' $FAILLOCK_CONF
    fi
    
else
    for pam_file in "${AUTH_FILES[@]}"
    do
        if ! grep -qE '^\s*auth.*pam_faillock\.so (preauth|authfail).*unlock_time' "$pam_file"; then
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*preauth.*silent.*/ s/$/ unlock_time='"$var_accounts_passwords_pam_faillock_unlock_time"'/' "$pam_file"
            sed -i --follow-symlinks '/^auth.*required.*pam_faillock\.so.*authfail.*/ s/$/ unlock_time='"$var_accounts_passwords_pam_faillock_unlock_time"'/' "$pam_file"
        else
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*preauth.*silent.*\)\('"unlock_time"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_unlock_time"'\3/' "$pam_file"
            sed -i --follow-symlinks 's/\(^auth.*required.*pam_faillock\.so.*authfail.*\)\('"unlock_time"'=\)[0-9]\+\(.*\)/\1\2'"$var_accounts_passwords_pam_faillock_unlock_time"'\3/' "$pam_file"
        fi
    done
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_unlock_time'

###############################################################################
# BEGIN fix (20 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit'
###############################################################################
(>&2 echo "Remediating rule 20/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_dcredit='-1'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^dcredit")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_dcredit"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^dcredit\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^dcredit\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit'

###############################################################################
# BEGIN fix (21 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_lcredit'
###############################################################################
(>&2 echo "Remediating rule 21/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_lcredit'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_lcredit='-1'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^lcredit")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_lcredit"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^lcredit\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^lcredit\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_lcredit'

###############################################################################
# BEGIN fix (22 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minclass'
###############################################################################
(>&2 echo "Remediating rule 22/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minclass'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_minclass='4'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^minclass")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_minclass"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^minclass\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^minclass\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minclass'

###############################################################################
# BEGIN fix (23 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minlen'
###############################################################################
(>&2 echo "Remediating rule 23/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minlen'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_minlen='14'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^minlen")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_minlen"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^minlen\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^minlen\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_minlen'

###############################################################################
# BEGIN fix (24 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ocredit'
###############################################################################
(>&2 echo "Remediating rule 24/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ocredit'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_ocredit='-1'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^ocredit")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_ocredit"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^ocredit\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^ocredit\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ocredit'

###############################################################################
# BEGIN fix (25 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_retry'
###############################################################################
(>&2 echo "Remediating rule 25/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_retry'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_retry='3'


conf_name=cac_pwquality
if [ ! -f /usr/share/pam-configs/"$conf_name" ]; then
    cat << EOF > /usr/share/pam-configs/"$conf_name"
Name: Pwquality password strength checking
Default: yes
Priority: 1025
Conflicts: cracklib, pwquality
Password-Type: Primary
Password:
    requisite                   pam_pwquality.so
EOF
fi

DEBIAN_FRONTEND=noninteractive pam-auth-update
PWQUALITY_CONF="/etc/security/pwquality.conf"
    regex="^\s*retry\s*="
    line="retry = $var_password_pam_retry"
    if ! grep -q $regex $PWQUALITY_CONF; then
        echo $line >> $PWQUALITY_CONF
    else
        sed -i --follow-symlinks 's|^\s*\(retry\s*=\s*\)\(\S\+\)|\1'"$var_password_pam_retry"'|g' $PWQUALITY_CONF
    fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_retry'

###############################################################################
# BEGIN fix (26 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ucredit'
###############################################################################
(>&2 echo "Remediating rule 26/126: 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ucredit'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_password_pam_ucredit='-1'








# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^ucredit")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$var_password_pam_ucredit"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^ucredit\\>" "/etc/security/pwquality.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^ucredit\\>.*/$escaped_formatted_output/gi" "/etc/security/pwquality.conf"
else
    if [[ -s "/etc/security/pwquality.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/security/pwquality.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/security/pwquality.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/security/pwquality.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_pam_ucredit'

###############################################################################
# BEGIN fix (27 / 126) for 'xccdf_org.ssgproject.content_rule_set_password_hashing_algorithm_logindefs'
###############################################################################
(>&2 echo "Remediating rule 27/126: 'xccdf_org.ssgproject.content_rule_set_password_hashing_algorithm_logindefs'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'login' 2>/dev/null | grep -q '^installed'; then

var_password_hashing_algorithm='YESCRYPT'


# Allow multiple algorithms, but choose the first one for remediation
#
var_password_hashing_algorithm="$(echo $var_password_hashing_algorithm | cut -d \| -f 1)"

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^ENCRYPT_METHOD")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "$var_password_hashing_algorithm"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^ENCRYPT_METHOD\\>" "/etc/login.defs"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^ENCRYPT_METHOD\\>.*/$escaped_formatted_output/gi" "/etc/login.defs"
else
    if [[ -s "/etc/login.defs" ]] && [[ -n "$(tail -c 1 -- "/etc/login.defs" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/login.defs"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/login.defs"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_set_password_hashing_algorithm_logindefs'

###############################################################################
# BEGIN fix (28 / 126) for 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'
###############################################################################
(>&2 echo "Remediating rule 28/126: 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'login' 2>/dev/null | grep -q '^installed'; then

var_account_disable_post_pw_expiration='30'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^INACTIVE")

# shellcheck disable=SC2059
printf -v formatted_output "%s=%s" "$stripped_key" "$var_account_disable_post_pw_expiration"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^INACTIVE\\>" "/etc/default/useradd"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^INACTIVE\\>.*/$escaped_formatted_output/gi" "/etc/default/useradd"
else
    if [[ -s "/etc/default/useradd" ]] && [[ -n "$(tail -c 1 -- "/etc/default/useradd" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/default/useradd"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/default/useradd"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration'

###############################################################################
# BEGIN fix (29 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_maximum_age_login_defs'
###############################################################################
(>&2 echo "Remediating rule 29/126: 'xccdf_org.ssgproject.content_rule_accounts_maximum_age_login_defs'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'login' 2>/dev/null | grep -q '^installed'; then

var_accounts_maximum_age_login_defs='365'

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^PASS_MAX_DAYS")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "$var_accounts_maximum_age_login_defs"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^PASS_MAX_DAYS\\>" "/etc/login.defs"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^PASS_MAX_DAYS\\>.*/$escaped_formatted_output/gi" "/etc/login.defs"
else
    if [[ -s "/etc/login.defs" ]] && [[ -n "$(tail -c 1 -- "/etc/login.defs" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/login.defs"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/login.defs"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_maximum_age_login_defs'

###############################################################################
# BEGIN fix (30 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_minimum_age_login_defs'
###############################################################################
(>&2 echo "Remediating rule 30/126: 'xccdf_org.ssgproject.content_rule_accounts_minimum_age_login_defs'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'login' 2>/dev/null | grep -q '^installed'; then

var_accounts_minimum_age_login_defs='1'

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^PASS_MIN_DAYS")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "$var_accounts_minimum_age_login_defs"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^PASS_MIN_DAYS\\>" "/etc/login.defs"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^PASS_MIN_DAYS\\>.*/$escaped_formatted_output/gi" "/etc/login.defs"
else
    if [[ -s "/etc/login.defs" ]] && [[ -n "$(tail -c 1 -- "/etc/login.defs" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/login.defs"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/login.defs"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_minimum_age_login_defs'

###############################################################################
# BEGIN fix (31 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_set_max_life_existing'
###############################################################################
(>&2 echo "Remediating rule 31/126: 'xccdf_org.ssgproject.content_rule_accounts_password_set_max_life_existing'")

var_accounts_maximum_age_login_defs='365'


while IFS= read -r i; do
    
    chage -M $var_accounts_maximum_age_login_defs $i

done <   <(awk -v var="$var_accounts_maximum_age_login_defs" -F: '(/^[^:]+:[^!*]/ && ($5 > var || $5 == "")) {print $1}' /etc/shadow)
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_set_max_life_existing'

###############################################################################
# BEGIN fix (32 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_password_set_min_life_existing'
###############################################################################
(>&2 echo "Remediating rule 32/126: 'xccdf_org.ssgproject.content_rule_accounts_password_set_min_life_existing'")

var_accounts_minimum_age_login_defs='1'


while IFS= read -r i; do
    
    chage -m $var_accounts_minimum_age_login_defs $i

done <   <(awk -v var="$var_accounts_minimum_age_login_defs" -F: '(/^[^:]+:[^!*]/ && ($4 < var || $4 == "")) {print $1}' /etc/shadow)
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_password_set_min_life_existing'

###############################################################################
# BEGIN fix (33 / 126) for 'xccdf_org.ssgproject.content_rule_ensure_pam_wheel_group_empty'
###############################################################################
(>&2 echo "Remediating rule 33/126: 'xccdf_org.ssgproject.content_rule_ensure_pam_wheel_group_empty'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_pam_wheel_group_for_su='sugroup'


if ! grep -q "^${var_pam_wheel_group_for_su}:[^:]*:[^:]*:[^:]*" /etc/group; then
    groupadd ${var_pam_wheel_group_for_su}
fi

# group must be empty
gpasswd -M '' ${var_pam_wheel_group_for_su}

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_ensure_pam_wheel_group_empty'

###############################################################################
# BEGIN fix (34 / 126) for 'xccdf_org.ssgproject.content_rule_no_shelllogin_for_systemaccounts'
###############################################################################
(>&2 echo "Remediating rule 34/126: 'xccdf_org.ssgproject.content_rule_no_shelllogin_for_systemaccounts'")

readarray -t systemaccounts < <(awk -F: '($3 < 1000 && $3 != root \
  && $7 != "\/sbin\/shutdown" && $7 != "\/sbin\/halt" && $7 != "\/bin\/sync") \
  { print $1 }' /etc/passwd)

for systemaccount in "${systemaccounts[@]}"; do
    usermod -s /sbin/nologin "$systemaccount"
done
# END fix for 'xccdf_org.ssgproject.content_rule_no_shelllogin_for_systemaccounts'

###############################################################################
# BEGIN fix (35 / 126) for 'xccdf_org.ssgproject.content_rule_use_pam_wheel_group_for_su'
###############################################################################
(>&2 echo "Remediating rule 35/126: 'xccdf_org.ssgproject.content_rule_use_pam_wheel_group_for_su'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

var_pam_wheel_group_for_su='sugroup'


PAM_CONF=/etc/pam.d/su

pamstr=$(grep -P '^auth\s+required\s+pam_wheel\.so\s+(?=[^#]*\buse_uid\b)(?=[^#]*\bgroup=)' ${PAM_CONF})
if [ -z "$pamstr" ]; then
    sed -Ei '/^auth\b.*\brequired\b.*\bpam_wheel\.so/d' ${PAM_CONF} # remove any remaining uncommented pam_wheel.so line
    sed -Ei "/^auth\s+sufficient\s+pam_rootok\.so.*$/a auth             required        pam_wheel.so use_uid group=${var_pam_wheel_group_for_su}" ${PAM_CONF}
else
    group_val=$(echo -n "$pamstr" | grep -Eo '\bgroup=[_a-z][-0-9_a-z]*' | cut -d '=' -f 2)
    if [ -z "${group_val}" ] || [ ${group_val} != ${var_pam_wheel_group_for_su} ]; then
        sed -Ei "s/(^auth\s+required\s+pam_wheel.so\s+[^#]*group=)[_a-z][-0-9_a-z]*/\1${var_pam_wheel_group_for_su}/" ${PAM_CONF}
    fi
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_use_pam_wheel_group_for_su'

###############################################################################
# BEGIN fix (36 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_tmout'
###############################################################################
(>&2 echo "Remediating rule 36/126: 'xccdf_org.ssgproject.content_rule_accounts_tmout'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

var_accounts_tmout='900'


# if 0, no occurence of tmout found, if 1, occurence found
tmout_found=0

for f in /etc/bash.bashrc /etc/profile /etc/profile.d/*.sh; do
    if grep --silent '^\s*TMOUT' $f; then
        sed -i -E "s/^(\s*)TMOUT\s*=\s*(\w|\$)*(.*)$/\1TMOUT=$var_accounts_tmout\3/g" $f
        tmout_found=1
        if ! grep --silent '^\s*readonly TMOUT' $f ; then
            echo "readonly TMOUT" >> $f
        fi
        if ! grep --silent '^\s*export TMOUT' $f ; then
            echo "export TMOUT" >> $f
        fi
    fi
done

if [ $tmout_found -eq 0 ]; then
        echo -e "\n# Set TMOUT to $var_accounts_tmout per security requirements" >> /etc/profile.d/tmout.sh
        echo "TMOUT=$var_accounts_tmout" >> /etc/profile.d/tmout.sh
        echo "readonly TMOUT" >> /etc/profile.d/tmout.sh
        echo "export TMOUT" >> /etc/profile.d/tmout.sh
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_tmout'

###############################################################################
# BEGIN fix (37 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_user_dot_group_ownership'
###############################################################################
(>&2 echo "Remediating rule 37/126: 'xccdf_org.ssgproject.content_rule_accounts_user_dot_group_ownership'")

awk -F':' '{ if ($3 >= 1000 && $3 != 65534) system("chgrp -f " $4" "$6"/.[^\.]?*") }' /etc/passwd
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_user_dot_group_ownership'

###############################################################################
# BEGIN fix (38 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_user_dot_user_ownership'
###############################################################################
(>&2 echo "Remediating rule 38/126: 'xccdf_org.ssgproject.content_rule_accounts_user_dot_user_ownership'")

awk -F':' '{ if ($3 >= 1000 && $3 != 65534) system("chown -f " $3" "$6"/.[^\.]?*") }' /etc/passwd
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_user_dot_user_ownership'

###############################################################################
# BEGIN fix (39 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_bashrc'
###############################################################################
(>&2 echo "Remediating rule 39/126: 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_bashrc'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'bash' 2>/dev/null | grep -q '^installed'; then

var_accounts_user_umask='027'






grep -q "^[^#]*\bumask" /etc/bash.bashrc && \
  sed -i -E -e "s/^([^#]*\bumask)[[:space:]]+[[:digit:]]+/\1 $var_accounts_user_umask/g" /etc/bash.bashrc
if ! [ $? -eq 0 ]; then
    echo "umask $var_accounts_user_umask" >> /etc/bash.bashrc
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_bashrc'

###############################################################################
# BEGIN fix (40 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_login_defs'
###############################################################################
(>&2 echo "Remediating rule 40/126: 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_login_defs'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'login' 2>/dev/null | grep -q '^installed'; then

var_accounts_user_umask='027'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^UMASK")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "$var_accounts_user_umask"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^UMASK\\>" "/etc/login.defs"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^UMASK\\>.*/$escaped_formatted_output/gi" "/etc/login.defs"
else
    if [[ -s "/etc/login.defs" ]] && [[ -n "$(tail -c 1 -- "/etc/login.defs" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/login.defs"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/login.defs"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_login_defs'

###############################################################################
# BEGIN fix (41 / 126) for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_profile'
###############################################################################
(>&2 echo "Remediating rule 41/126: 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_profile'")

var_accounts_user_umask='027'


readarray -t profile_files < <(find /etc/profile.d/ -type f -name '*.sh' -or -name 'sh.local')

for file in "${profile_files[@]}" /etc/profile; do
  grep -qE '^[^#]*umask' "$file" && sed -i -E "s/^(\s*umask\s*)[0-7]+/\1$var_accounts_user_umask/g" "$file"
done

if ! grep -qrE '^[^#]*umask' /etc/profile*; then
  echo "umask $var_accounts_user_umask" >> /etc/profile
fi
# END fix for 'xccdf_org.ssgproject.content_rule_accounts_umask_etc_profile'

###############################################################################
# BEGIN fix (42 / 126) for 'xccdf_org.ssgproject.content_rule_grub2_enable_apparmor'
###############################################################################
(>&2 echo "Remediating rule 42/126: 'xccdf_org.ssgproject.content_rule_grub2_enable_apparmor'")
# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

# Correct the form of default kernel command line in GRUB
if grep -q '^\s*GRUB_CMDLINE_LINUX=.*apparmor=.*"'  '/etc/default/grub' ; then
       # modify the GRUB command-line if an apparmor= arg already exists
       sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)apparmor=[^[:space:]]\+\(.*\"\)/\1apparmor=1\2/"  '/etc/default/grub'
# Add to already existing GRUB_CMDLINE_LINUX parameters
elif grep -q '^\s*GRUB_CMDLINE_LINUX='  '/etc/default/grub' ; then
       # no apparmor=arg is present, append it
       sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)\"/\1 apparmor=1\"/"  '/etc/default/grub'
# Add GRUB_CMDLINE_LINUX parameters line
else
       echo "GRUB_CMDLINE_LINUX=\"apparmor=1\"" >> '/etc/default/grub'
fi
# Correct the form of default kernel command line in GRUB
if grep -q '^\s*GRUB_CMDLINE_LINUX=.*security=.*"'  '/etc/default/grub' ; then
       # modify the GRUB command-line if an security= arg already exists
       sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)security=[^[:space:]]\+\(.*\"\)/\1security=apparmor\2/"  '/etc/default/grub'
# Add to already existing GRUB_CMDLINE_LINUX parameters
elif grep -q '^\s*GRUB_CMDLINE_LINUX='  '/etc/default/grub' ; then
       # no security=arg is present, append it
       sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)\"/\1 security=apparmor\"/"  '/etc/default/grub'
# Add GRUB_CMDLINE_LINUX parameters line
else
       echo "GRUB_CMDLINE_LINUX=\"security=apparmor\"" >> '/etc/default/grub'
fi


update-grub

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_grub2_enable_apparmor'

###############################################################################
# BEGIN fix (43 / 126) for 'xccdf_org.ssgproject.content_rule_grub2_uefi_password'
###############################################################################
(>&2 echo "Remediating rule 43/126: 'xccdf_org.ssgproject.content_rule_grub2_uefi_password'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_grub2_uefi_password' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_grub2_uefi_password'

###############################################################################
# BEGIN fix (44 / 126) for 'xccdf_org.ssgproject.content_rule_package_systemd-journal-remote_installed'
###############################################################################
(>&2 echo "Remediating rule 44/126: 'xccdf_org.ssgproject.content_rule_package_systemd-journal-remote_installed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "systemd-journal-remote"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_systemd-journal-remote_installed'

###############################################################################
# BEGIN fix (45 / 126) for 'xccdf_org.ssgproject.content_rule_journald_compress'
###############################################################################
(>&2 echo "Remediating rule 45/126: 'xccdf_org.ssgproject.content_rule_journald_compress'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if [ -e "/etc/systemd/journald.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*Compress\s*=\s*/d" "/etc/systemd/journald.conf"
else
    touch "/etc/systemd/journald.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/systemd/journald.conf"

cp "/etc/systemd/journald.conf" "/etc/systemd/journald.conf.bak"
# Insert before the line matching the regex '^#\s*Compress'.
line_number="$(LC_ALL=C grep -n "^#\s*Compress" "/etc/systemd/journald.conf.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^#\s*Compress', insert at
    # the end of the file.
    printf '%s\n' "Compress=yes" >> "/etc/systemd/journald.conf"
else
    head -n "$(( line_number - 1 ))" "/etc/systemd/journald.conf.bak" > "/etc/systemd/journald.conf"
    printf '%s\n' "Compress=yes" >> "/etc/systemd/journald.conf"
    tail -n "+$(( line_number ))" "/etc/systemd/journald.conf.bak" >> "/etc/systemd/journald.conf"
fi
# Clean up after ourselves.
rm "/etc/systemd/journald.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_journald_compress'

###############################################################################
# BEGIN fix (46 / 126) for 'xccdf_org.ssgproject.content_rule_journald_storage'
###############################################################################
(>&2 echo "Remediating rule 46/126: 'xccdf_org.ssgproject.content_rule_journald_storage'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if [ -e "/etc/systemd/journald.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*Storage\s*=\s*/d" "/etc/systemd/journald.conf"
else
    touch "/etc/systemd/journald.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/systemd/journald.conf"

cp "/etc/systemd/journald.conf" "/etc/systemd/journald.conf.bak"
# Insert before the line matching the regex '^#\s*Storage'.
line_number="$(LC_ALL=C grep -n "^#\s*Storage" "/etc/systemd/journald.conf.bak" | LC_ALL=C sed 's/:.*//g')"
if [ -z "$line_number" ]; then
    # There was no match of '^#\s*Storage', insert at
    # the end of the file.
    printf '%s\n' "Storage=persistent" >> "/etc/systemd/journald.conf"
else
    head -n "$(( line_number - 1 ))" "/etc/systemd/journald.conf.bak" > "/etc/systemd/journald.conf"
    printf '%s\n' "Storage=persistent" >> "/etc/systemd/journald.conf"
    tail -n "+$(( line_number ))" "/etc/systemd/journald.conf.bak" >> "/etc/systemd/journald.conf"
fi
# Clean up after ourselves.
rm "/etc/systemd/journald.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_journald_storage'

###############################################################################
# BEGIN fix (47 / 126) for 'xccdf_org.ssgproject.content_rule_rsyslog_remote_loghost'
###############################################################################
(>&2 echo "Remediating rule 47/126: 'xccdf_org.ssgproject.content_rule_rsyslog_remote_loghost'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

rsyslog_remote_loghost_address='logcollector'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^\*\.\*")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "@@$rsyslog_remote_loghost_address"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^\*\.\*\\>" "/etc/rsyslog.conf"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^\*\.\*\\>.*/$escaped_formatted_output/gi" "/etc/rsyslog.conf"
else
    if [[ -s "/etc/rsyslog.conf" ]] && [[ -n "$(tail -c 1 -- "/etc/rsyslog.conf" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/rsyslog.conf"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/rsyslog.conf"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_rsyslog_remote_loghost'

###############################################################################
# BEGIN fix (48 / 126) for 'xccdf_org.ssgproject.content_rule_package_iptables-persistent_removed'
###############################################################################
(>&2 echo "Remediating rule 48/126: 'xccdf_org.ssgproject.content_rule_package_iptables-persistent_removed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'ufw' 2>/dev/null | grep -q '^installed'; then

# CAUTION: This remediation script will remove iptables-persistent
#	   from the system, and may remove any packages
#	   that depend on iptables-persistent. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "iptables-persistent"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_iptables-persistent_removed'

###############################################################################
# BEGIN fix (49 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_ra'
###############################################################################
(>&2 echo "Remediating rule 49/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_ra'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.all.accept_ra from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.all.accept_ra.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.all.accept_ra" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_all_accept_ra_value='0'


#
# Set runtime for net.ipv6.conf.all.accept_ra
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.all.accept_ra="$sysctl_net_ipv6_conf_all_accept_ra_value"
fi

#
# If net.ipv6.conf.all.accept_ra present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.all.accept_ra = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.all.accept_ra")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_all_accept_ra_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.all.accept_ra\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.all.accept_ra\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_ra'

###############################################################################
# BEGIN fix (50 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_redirects'
###############################################################################
(>&2 echo "Remediating rule 50/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.all.accept_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.all.accept_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.all.accept_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_all_accept_redirects_value='0'


#
# Set runtime for net.ipv6.conf.all.accept_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.all.accept_redirects="$sysctl_net_ipv6_conf_all_accept_redirects_value"
fi

#
# If net.ipv6.conf.all.accept_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.all.accept_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.all.accept_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_all_accept_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.all.accept_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.all.accept_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_redirects'

###############################################################################
# BEGIN fix (51 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_source_route'
###############################################################################
(>&2 echo "Remediating rule 51/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_source_route'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.all.accept_source_route from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.all.accept_source_route.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.all.accept_source_route" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_all_accept_source_route_value='0'


#
# Set runtime for net.ipv6.conf.all.accept_source_route
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.all.accept_source_route="$sysctl_net_ipv6_conf_all_accept_source_route_value"
fi

#
# If net.ipv6.conf.all.accept_source_route present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.all.accept_source_route = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.all.accept_source_route")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_all_accept_source_route_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.all.accept_source_route\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.all.accept_source_route\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_accept_source_route'

###############################################################################
# BEGIN fix (52 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_forwarding'
###############################################################################
(>&2 echo "Remediating rule 52/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_forwarding'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.all.forwarding from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.all.forwarding.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.all.forwarding" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_all_forwarding_value='0'


#
# Set runtime for net.ipv6.conf.all.forwarding
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.all.forwarding="$sysctl_net_ipv6_conf_all_forwarding_value"
fi

#
# If net.ipv6.conf.all.forwarding present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.all.forwarding = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.all.forwarding")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_all_forwarding_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.all.forwarding\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.all.forwarding\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_all_forwarding'

###############################################################################
# BEGIN fix (53 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_ra'
###############################################################################
(>&2 echo "Remediating rule 53/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_ra'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.default.accept_ra from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.default.accept_ra.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.default.accept_ra" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_default_accept_ra_value='0'


#
# Set runtime for net.ipv6.conf.default.accept_ra
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.default.accept_ra="$sysctl_net_ipv6_conf_default_accept_ra_value"
fi

#
# If net.ipv6.conf.default.accept_ra present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.default.accept_ra = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.default.accept_ra")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_default_accept_ra_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.default.accept_ra\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.default.accept_ra\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_ra'

###############################################################################
# BEGIN fix (54 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_redirects'
###############################################################################
(>&2 echo "Remediating rule 54/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.default.accept_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.default.accept_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.default.accept_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_default_accept_redirects_value='0'


#
# Set runtime for net.ipv6.conf.default.accept_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.default.accept_redirects="$sysctl_net_ipv6_conf_default_accept_redirects_value"
fi

#
# If net.ipv6.conf.default.accept_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.default.accept_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.default.accept_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_default_accept_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.default.accept_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.default.accept_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_redirects'

###############################################################################
# BEGIN fix (55 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_source_route'
###############################################################################
(>&2 echo "Remediating rule 55/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_source_route'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv6.conf.default.accept_source_route from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv6.conf.default.accept_source_route.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv6.conf.default.accept_source_route" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv6_conf_default_accept_source_route_value='0'


#
# Set runtime for net.ipv6.conf.default.accept_source_route
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv6.conf.default.accept_source_route="$sysctl_net_ipv6_conf_default_accept_source_route_value"
fi

#
# If net.ipv6.conf.default.accept_source_route present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv6.conf.default.accept_source_route = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv6.conf.default.accept_source_route")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv6_conf_default_accept_source_route_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv6.conf.default.accept_source_route\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv6.conf.default.accept_source_route\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv6_conf_default_accept_source_route'

###############################################################################
# BEGIN fix (56 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_redirects'
###############################################################################
(>&2 echo "Remediating rule 56/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.accept_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.accept_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.accept_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_all_accept_redirects_value='0'


#
# Set runtime for net.ipv4.conf.all.accept_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.accept_redirects="$sysctl_net_ipv4_conf_all_accept_redirects_value"
fi

#
# If net.ipv4.conf.all.accept_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.all.accept_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.accept_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_all_accept_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.accept_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.accept_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_redirects'

###############################################################################
# BEGIN fix (57 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_source_route'
###############################################################################
(>&2 echo "Remediating rule 57/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_source_route'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.accept_source_route from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.accept_source_route.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.accept_source_route" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_all_accept_source_route_value='0'


#
# Set runtime for net.ipv4.conf.all.accept_source_route
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.accept_source_route="$sysctl_net_ipv4_conf_all_accept_source_route_value"
fi

#
# If net.ipv4.conf.all.accept_source_route present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.all.accept_source_route = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.accept_source_route")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_all_accept_source_route_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.accept_source_route\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.accept_source_route\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_accept_source_route'

###############################################################################
# BEGIN fix (58 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_log_martians'
###############################################################################
(>&2 echo "Remediating rule 58/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_log_martians'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.log_martians from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.log_martians.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.log_martians" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_all_log_martians_value='1'


#
# Set runtime for net.ipv4.conf.all.log_martians
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.log_martians="$sysctl_net_ipv4_conf_all_log_martians_value"
fi

#
# If net.ipv4.conf.all.log_martians present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.all.log_martians = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.log_martians")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_all_log_martians_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.log_martians\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.log_martians\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_log_martians'

###############################################################################
# BEGIN fix (59 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_rp_filter'
###############################################################################
(>&2 echo "Remediating rule 59/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_rp_filter'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.rp_filter from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.rp_filter.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.rp_filter" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_all_rp_filter_value='1'


#
# Set runtime for net.ipv4.conf.all.rp_filter
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.rp_filter="$sysctl_net_ipv4_conf_all_rp_filter_value"
fi

#
# If net.ipv4.conf.all.rp_filter present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.all.rp_filter = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.rp_filter")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_all_rp_filter_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.rp_filter\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.rp_filter\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_rp_filter'

###############################################################################
# BEGIN fix (60 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_secure_redirects'
###############################################################################
(>&2 echo "Remediating rule 60/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_secure_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.secure_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.secure_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.secure_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_all_secure_redirects_value='0'


#
# Set runtime for net.ipv4.conf.all.secure_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.secure_redirects="$sysctl_net_ipv4_conf_all_secure_redirects_value"
fi

#
# If net.ipv4.conf.all.secure_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.all.secure_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.secure_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_all_secure_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.secure_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.secure_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_secure_redirects'

###############################################################################
# BEGIN fix (61 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_accept_redirects'
###############################################################################
(>&2 echo "Remediating rule 61/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_accept_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.default.accept_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.default.accept_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.default.accept_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_default_accept_redirects_value='0'


#
# Set runtime for net.ipv4.conf.default.accept_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.default.accept_redirects="$sysctl_net_ipv4_conf_default_accept_redirects_value"
fi

#
# If net.ipv4.conf.default.accept_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.default.accept_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.default.accept_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_default_accept_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.default.accept_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.default.accept_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_accept_redirects'

###############################################################################
# BEGIN fix (62 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_log_martians'
###############################################################################
(>&2 echo "Remediating rule 62/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_log_martians'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.default.log_martians from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.default.log_martians.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.default.log_martians" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_default_log_martians_value='1'


#
# Set runtime for net.ipv4.conf.default.log_martians
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.default.log_martians="$sysctl_net_ipv4_conf_default_log_martians_value"
fi

#
# If net.ipv4.conf.default.log_martians present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.default.log_martians = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.default.log_martians")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_default_log_martians_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.default.log_martians\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.default.log_martians\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_log_martians'

###############################################################################
# BEGIN fix (63 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_rp_filter'
###############################################################################
(>&2 echo "Remediating rule 63/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_rp_filter'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.default.rp_filter from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.default.rp_filter.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.default.rp_filter" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_default_rp_filter_value='1'


#
# Set runtime for net.ipv4.conf.default.rp_filter
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.default.rp_filter="$sysctl_net_ipv4_conf_default_rp_filter_value"
fi

#
# If net.ipv4.conf.default.rp_filter present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.default.rp_filter = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.default.rp_filter")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_default_rp_filter_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.default.rp_filter\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.default.rp_filter\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_rp_filter'

###############################################################################
# BEGIN fix (64 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_secure_redirects'
###############################################################################
(>&2 echo "Remediating rule 64/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_secure_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.default.secure_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.default.secure_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.default.secure_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_conf_default_secure_redirects_value='0'


#
# Set runtime for net.ipv4.conf.default.secure_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.default.secure_redirects="$sysctl_net_ipv4_conf_default_secure_redirects_value"
fi

#
# If net.ipv4.conf.default.secure_redirects present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.conf.default.secure_redirects = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.default.secure_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_conf_default_secure_redirects_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.default.secure_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.default.secure_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_secure_redirects'

###############################################################################
# BEGIN fix (65 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_echo_ignore_broadcasts'
###############################################################################
(>&2 echo "Remediating rule 65/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_echo_ignore_broadcasts'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.icmp_echo_ignore_broadcasts from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.icmp_echo_ignore_broadcasts.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.icmp_echo_ignore_broadcasts" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_icmp_echo_ignore_broadcasts_value='1'


#
# Set runtime for net.ipv4.icmp_echo_ignore_broadcasts
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.icmp_echo_ignore_broadcasts="$sysctl_net_ipv4_icmp_echo_ignore_broadcasts_value"
fi

#
# If net.ipv4.icmp_echo_ignore_broadcasts present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.icmp_echo_ignore_broadcasts = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.icmp_echo_ignore_broadcasts")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_icmp_echo_ignore_broadcasts_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.icmp_echo_ignore_broadcasts\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.icmp_echo_ignore_broadcasts\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_echo_ignore_broadcasts'

###############################################################################
# BEGIN fix (66 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_ignore_bogus_error_responses'
###############################################################################
(>&2 echo "Remediating rule 66/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_ignore_bogus_error_responses'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.icmp_ignore_bogus_error_responses from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.icmp_ignore_bogus_error_responses.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.icmp_ignore_bogus_error_responses" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_icmp_ignore_bogus_error_responses_value='1'


#
# Set runtime for net.ipv4.icmp_ignore_bogus_error_responses
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.icmp_ignore_bogus_error_responses="$sysctl_net_ipv4_icmp_ignore_bogus_error_responses_value"
fi

#
# If net.ipv4.icmp_ignore_bogus_error_responses present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.icmp_ignore_bogus_error_responses = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.icmp_ignore_bogus_error_responses")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_icmp_ignore_bogus_error_responses_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.icmp_ignore_bogus_error_responses\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.icmp_ignore_bogus_error_responses\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_icmp_ignore_bogus_error_responses'

###############################################################################
# BEGIN fix (67 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_tcp_syncookies'
###############################################################################
(>&2 echo "Remediating rule 67/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_tcp_syncookies'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.tcp_syncookies from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.tcp_syncookies.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.tcp_syncookies" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"

sysctl_net_ipv4_tcp_syncookies_value='1'


#
# Set runtime for net.ipv4.tcp_syncookies
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.tcp_syncookies="$sysctl_net_ipv4_tcp_syncookies_value"
fi

#
# If net.ipv4.tcp_syncookies present in /etc/sysctl.conf, change value to appropriate value
#	else, add "net.ipv4.tcp_syncookies = value" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.tcp_syncookies")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "$sysctl_net_ipv4_tcp_syncookies_value"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.tcp_syncookies\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.tcp_syncookies\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_tcp_syncookies'

###############################################################################
# BEGIN fix (68 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_send_redirects'
###############################################################################
(>&2 echo "Remediating rule 68/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_send_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.all.send_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.all.send_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.all.send_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"


#
# Set runtime for net.ipv4.conf.all.send_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.all.send_redirects="0"
fi

#
# If net.ipv4.conf.all.send_redirects present in /etc/sysctl.conf, change value to "0"
#	else, add "net.ipv4.conf.all.send_redirects = 0" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.all.send_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.all.send_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.all.send_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_all_send_redirects'

###############################################################################
# BEGIN fix (69 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_send_redirects'
###############################################################################
(>&2 echo "Remediating rule 69/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_send_redirects'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.conf.default.send_redirects from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.conf.default.send_redirects.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.conf.default.send_redirects" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"


#
# Set runtime for net.ipv4.conf.default.send_redirects
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.conf.default.send_redirects="0"
fi

#
# If net.ipv4.conf.default.send_redirects present in /etc/sysctl.conf, change value to "0"
#	else, add "net.ipv4.conf.default.send_redirects = 0" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.conf.default.send_redirects")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.conf.default.send_redirects\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.conf.default.send_redirects\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_conf_default_send_redirects'

###############################################################################
# BEGIN fix (70 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_ip_forward'
###############################################################################
(>&2 echo "Remediating rule 70/126: 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_ip_forward'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of net.ipv4.ip_forward from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*net.ipv4.ip_forward.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "net.ipv4.ip_forward" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"


#
# Set runtime for net.ipv4.ip_forward
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w net.ipv4.ip_forward="0"
fi

#
# If net.ipv4.ip_forward present in /etc/sysctl.conf, change value to "0"
#	else, add "net.ipv4.ip_forward = 0" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^net.ipv4.ip_forward")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^net.ipv4.ip_forward\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^net.ipv4.ip_forward\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_net_ipv4_ip_forward'

###############################################################################
# BEGIN fix (71 / 126) for 'xccdf_org.ssgproject.content_rule_service_nftables_enabled'
###############################################################################
(>&2 echo "Remediating rule 71/126: 'xccdf_org.ssgproject.content_rule_service_nftables_enabled'")
# Remediation is applicable only in certain platforms
if ( dpkg-query --show --showformat='${db:Status-Status}\n' 'nftables' 2>/dev/null | grep -q '^installed' && dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed ); then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
"$SYSTEMCTL_EXEC" unmask 'nftables.service'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" start 'nftables.service'
fi
"$SYSTEMCTL_EXEC" enable 'nftables.service'

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_service_nftables_enabled'

###############################################################################
# BEGIN fix (72 / 126) for 'xccdf_org.ssgproject.content_rule_nftables_rules_permanent'
###############################################################################
(>&2 echo "Remediating rule 72/126: 'xccdf_org.ssgproject.content_rule_nftables_rules_permanent'")
# Remediation is applicable only in certain platforms
if ( dpkg-query --show --showformat='${db:Status-Status}\n' 'nftables' 2>/dev/null | grep -q '^installed' ); then

var_nftables_master_config_file='/etc/nftables.conf'


var_nftables_family='inet'


if [ ! -f "${var_nftables_master_config_file}" ]; then
    touch "${var_nftables_master_config_file}"
fi

nft list ruleset > "/etc/${var_nftables_family}-filter.rules"

grep -qxF 'include "/etc/'"${var_nftables_family}"'-filter.rules"' "${var_nftables_master_config_file}" \
    || echo 'include "/etc/'"${var_nftables_family}"'-filter.rules"' >> "${var_nftables_master_config_file}"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_nftables_rules_permanent'

###############################################################################
# BEGIN fix (73 / 126) for 'xccdf_org.ssgproject.content_rule_package_ufw_removed'
###############################################################################
(>&2 echo "Remediating rule 73/126: 'xccdf_org.ssgproject.content_rule_package_ufw_removed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# CAUTION: This remediation script will remove ufw
#	   from the system, and may remove any packages
#	   that depend on ufw. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "ufw"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_ufw_removed'

###############################################################################
# BEGIN fix (74 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_dccp_disabled'
###############################################################################
(>&2 echo "Remediating rule 74/126: 'xccdf_org.ssgproject.content_rule_kernel_module_dccp_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install dccp" /etc/modprobe.d/dccp.conf ; then
	
	sed -i 's#^install dccp.*#install dccp /bin/false#g' /etc/modprobe.d/dccp.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/dccp.conf
	echo "install dccp /bin/false" >> /etc/modprobe.d/dccp.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist dccp$" /etc/modprobe.d/dccp.conf ; then
	echo "blacklist dccp" >> /etc/modprobe.d/dccp.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_dccp_disabled'

###############################################################################
# BEGIN fix (75 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_rds_disabled'
###############################################################################
(>&2 echo "Remediating rule 75/126: 'xccdf_org.ssgproject.content_rule_kernel_module_rds_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install rds" /etc/modprobe.d/rds.conf ; then
	
	sed -i 's#^install rds.*#install rds /bin/false#g' /etc/modprobe.d/rds.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/rds.conf
	echo "install rds /bin/false" >> /etc/modprobe.d/rds.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist rds$" /etc/modprobe.d/rds.conf ; then
	echo "blacklist rds" >> /etc/modprobe.d/rds.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_rds_disabled'

###############################################################################
# BEGIN fix (76 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_sctp_disabled'
###############################################################################
(>&2 echo "Remediating rule 76/126: 'xccdf_org.ssgproject.content_rule_kernel_module_sctp_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install sctp" /etc/modprobe.d/sctp.conf ; then
	
	sed -i 's#^install sctp.*#install sctp /bin/false#g' /etc/modprobe.d/sctp.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/sctp.conf
	echo "install sctp /bin/false" >> /etc/modprobe.d/sctp.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist sctp$" /etc/modprobe.d/sctp.conf ; then
	echo "blacklist sctp" >> /etc/modprobe.d/sctp.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_sctp_disabled'

###############################################################################
# BEGIN fix (77 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_tipc_disabled'
###############################################################################
(>&2 echo "Remediating rule 77/126: 'xccdf_org.ssgproject.content_rule_kernel_module_tipc_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install tipc" /etc/modprobe.d/tipc.conf ; then
	
	sed -i 's#^install tipc.*#install tipc /bin/false#g' /etc/modprobe.d/tipc.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/tipc.conf
	echo "install tipc /bin/false" >> /etc/modprobe.d/tipc.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist tipc$" /etc/modprobe.d/tipc.conf ; then
	echo "blacklist tipc" >> /etc/modprobe.d/tipc.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_tipc_disabled'

###############################################################################
# BEGIN fix (78 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_unauthorized_world_writable'
###############################################################################
(>&2 echo "Remediating rule 78/126: 'xccdf_org.ssgproject.content_rule_file_permissions_unauthorized_world_writable'")

FILTER_NODEV=$(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,)

# Do not consider /sysroot partition because it contains only the physical
# read-only root on bootable containers.
PARTITIONS=$(findmnt -n -l -k -it $FILTER_NODEV | awk '{ print $1 }' | grep -v "/sysroot")

for PARTITION in $PARTITIONS; do
  find "${PARTITION}" -xdev -type f -perm -002 -exec chmod o-w {} \; 2>/dev/null
done

# Ensure /tmp is also fixed when tmpfs is used.
if grep "^tmpfs /tmp" /proc/mounts; then
  find /tmp -xdev -type f -perm -002 -exec chmod o-w {} \; 2>/dev/null
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_unauthorized_world_writable'

###############################################################################
# BEGIN fix (79 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_ungroupowned'
###############################################################################
(>&2 echo "Remediating rule 79/126: 'xccdf_org.ssgproject.content_rule_file_permissions_ungroupowned'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_file_permissions_ungroupowned' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_ungroupowned'

###############################################################################
# BEGIN fix (80 / 126) for 'xccdf_org.ssgproject.content_rule_permissions_local_var_log'
###############################################################################
(>&2 echo "Remediating rule 80/126: 'xccdf_org.ssgproject.content_rule_permissions_local_var_log'")




find  /var/log/  -perm /u+xs,g+xws,o+xwrt ! -name 'history.log' ! -name 'eipp.log.xz' ! -name '*[bw]tmp' ! -name '*lastlog' -type f -regextype posix-extended -regex '.*' -exec chmod u-xs,g-xws,o-xwrt {} \;
# END fix for 'xccdf_org.ssgproject.content_rule_permissions_local_var_log'

###############################################################################
# BEGIN fix (81 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_cramfs_disabled'
###############################################################################
(>&2 echo "Remediating rule 81/126: 'xccdf_org.ssgproject.content_rule_kernel_module_cramfs_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install cramfs" /etc/modprobe.d/cramfs.conf ; then
	
	sed -i 's#^install cramfs.*#install cramfs /bin/false#g' /etc/modprobe.d/cramfs.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/cramfs.conf
	echo "install cramfs /bin/false" >> /etc/modprobe.d/cramfs.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist cramfs$" /etc/modprobe.d/cramfs.conf ; then
	echo "blacklist cramfs" >> /etc/modprobe.d/cramfs.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_cramfs_disabled'

###############################################################################
# BEGIN fix (82 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_squashfs_disabled'
###############################################################################
(>&2 echo "Remediating rule 82/126: 'xccdf_org.ssgproject.content_rule_kernel_module_squashfs_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install squashfs" /etc/modprobe.d/squashfs.conf ; then
	
	sed -i 's#^install squashfs.*#install squashfs /bin/false#g' /etc/modprobe.d/squashfs.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/squashfs.conf
	echo "install squashfs /bin/false" >> /etc/modprobe.d/squashfs.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist squashfs$" /etc/modprobe.d/squashfs.conf ; then
	echo "blacklist squashfs" >> /etc/modprobe.d/squashfs.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_squashfs_disabled'

###############################################################################
# BEGIN fix (83 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_udf_disabled'
###############################################################################
(>&2 echo "Remediating rule 83/126: 'xccdf_org.ssgproject.content_rule_kernel_module_udf_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install udf" /etc/modprobe.d/udf.conf ; then
	
	sed -i 's#^install udf.*#install udf /bin/false#g' /etc/modprobe.d/udf.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/udf.conf
	echo "install udf /bin/false" >> /etc/modprobe.d/udf.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist udf$" /etc/modprobe.d/udf.conf ; then
	echo "blacklist udf" >> /etc/modprobe.d/udf.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_udf_disabled'

###############################################################################
# BEGIN fix (84 / 126) for 'xccdf_org.ssgproject.content_rule_kernel_module_usb-storage_disabled'
###############################################################################
(>&2 echo "Remediating rule 84/126: 'xccdf_org.ssgproject.content_rule_kernel_module_usb-storage_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if LC_ALL=C grep -q -m 1 "^install usb-storage" /etc/modprobe.d/usb-storage.conf ; then
	
	sed -i 's#^install usb-storage.*#install usb-storage /bin/false#g' /etc/modprobe.d/usb-storage.conf
else
	echo -e "\n# Disable per security requirements" >> /etc/modprobe.d/usb-storage.conf
	echo "install usb-storage /bin/false" >> /etc/modprobe.d/usb-storage.conf
fi

if ! LC_ALL=C grep -q -m 1 "^blacklist usb-storage$" /etc/modprobe.d/usb-storage.conf ; then
	echo "blacklist usb-storage" >> /etc/modprobe.d/usb-storage.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_kernel_module_usb-storage_disabled'

###############################################################################
# BEGIN fix (85 / 126) for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nodev'
###############################################################################
(>&2 echo "Remediating rule 85/126: 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nodev'")
# Remediation is applicable only in certain platforms
if ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ); then

function perform_remediation {
    


    mount_point_match_regexp="$(printf "^[[:space:]]*[^#].*[[:space:]]%s[[:space:]]" /dev/shm)"

    # If the mount point is not in /etc/fstab, get previous mount options from /etc/mtab
    if ! grep -q "$mount_point_match_regexp" /etc/fstab; then
        # runtime opts without some automatic kernel/userspace-added defaults
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/mtab | head -1 |  awk '{print $4}' \
                    | sed -E "s/(rw|defaults|seclabel|nodev)(,|$)//g;s/,$//")
        [ "$previous_mount_opts" ] && previous_mount_opts+=","
        # In iso9660 filesystems mtab could describe a "blocksize" value, this should be reflected in
        # fstab as "block".  The next variable is to satisfy shellcheck SC2050.
        fs_type="tmpfs"
        if [  "$fs_type" == "iso9660" ] ; then
            previous_mount_opts=$(sed 's/blocksize=/block=/' <<< "$previous_mount_opts")
        fi
        echo "tmpfs /dev/shm tmpfs defaults,${previous_mount_opts}nodev 0 0" >> /etc/fstab
    # If the mount_opt option is not already in the mount point's /etc/fstab entry, add it
    elif ! grep "$mount_point_match_regexp" /etc/fstab | grep -q "nodev"; then
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/fstab | awk '{print $4}')
        sed -i "s|\(${mount_point_match_regexp}.*${previous_mount_opts}\)|\1,nodev|" /etc/fstab
    fi


    if mkdir -p "/dev/shm"; then
        if mountpoint -q "/dev/shm"; then
            mount -o remount --target "/dev/shm"
        fi
    fi
}

perform_remediation

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nodev'

###############################################################################
# BEGIN fix (86 / 126) for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec'
###############################################################################
(>&2 echo "Remediating rule 86/126: 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec'")
# Remediation is applicable only in certain platforms
if ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ); then

function perform_remediation {
    


    mount_point_match_regexp="$(printf "^[[:space:]]*[^#].*[[:space:]]%s[[:space:]]" /dev/shm)"

    # If the mount point is not in /etc/fstab, get previous mount options from /etc/mtab
    if ! grep -q "$mount_point_match_regexp" /etc/fstab; then
        # runtime opts without some automatic kernel/userspace-added defaults
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/mtab | head -1 |  awk '{print $4}' \
                    | sed -E "s/(rw|defaults|seclabel|noexec)(,|$)//g;s/,$//")
        [ "$previous_mount_opts" ] && previous_mount_opts+=","
        # In iso9660 filesystems mtab could describe a "blocksize" value, this should be reflected in
        # fstab as "block".  The next variable is to satisfy shellcheck SC2050.
        fs_type="tmpfs"
        if [  "$fs_type" == "iso9660" ] ; then
            previous_mount_opts=$(sed 's/blocksize=/block=/' <<< "$previous_mount_opts")
        fi
        echo "tmpfs /dev/shm tmpfs defaults,${previous_mount_opts}noexec 0 0" >> /etc/fstab
    # If the mount_opt option is not already in the mount point's /etc/fstab entry, add it
    elif ! grep "$mount_point_match_regexp" /etc/fstab | grep -q "noexec"; then
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/fstab | awk '{print $4}')
        sed -i "s|\(${mount_point_match_regexp}.*${previous_mount_opts}\)|\1,noexec|" /etc/fstab
    fi


    if mkdir -p "/dev/shm"; then
        if mountpoint -q "/dev/shm"; then
            mount -o remount --target "/dev/shm"
        fi
    fi
}

perform_remediation

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec'

###############################################################################
# BEGIN fix (87 / 126) for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nosuid'
###############################################################################
(>&2 echo "Remediating rule 87/126: 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nosuid'")
# Remediation is applicable only in certain platforms
if ! ( [ -f /.dockerenv ] || [ -f /run/.containerenv ] ); then

function perform_remediation {
    


    mount_point_match_regexp="$(printf "^[[:space:]]*[^#].*[[:space:]]%s[[:space:]]" /dev/shm)"

    # If the mount point is not in /etc/fstab, get previous mount options from /etc/mtab
    if ! grep -q "$mount_point_match_regexp" /etc/fstab; then
        # runtime opts without some automatic kernel/userspace-added defaults
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/mtab | head -1 |  awk '{print $4}' \
                    | sed -E "s/(rw|defaults|seclabel|nosuid)(,|$)//g;s/,$//")
        [ "$previous_mount_opts" ] && previous_mount_opts+=","
        # In iso9660 filesystems mtab could describe a "blocksize" value, this should be reflected in
        # fstab as "block".  The next variable is to satisfy shellcheck SC2050.
        fs_type="tmpfs"
        if [  "$fs_type" == "iso9660" ] ; then
            previous_mount_opts=$(sed 's/blocksize=/block=/' <<< "$previous_mount_opts")
        fi
        echo "tmpfs /dev/shm tmpfs defaults,${previous_mount_opts}nosuid 0 0" >> /etc/fstab
    # If the mount_opt option is not already in the mount point's /etc/fstab entry, add it
    elif ! grep "$mount_point_match_regexp" /etc/fstab | grep -q "nosuid"; then
        previous_mount_opts=$(grep "$mount_point_match_regexp" /etc/fstab | awk '{print $4}')
        sed -i "s|\(${mount_point_match_regexp}.*${previous_mount_opts}\)|\1,nosuid|" /etc/fstab
    fi


    if mkdir -p "/dev/shm"; then
        if mountpoint -q "/dev/shm"; then
            mount -o remount --target "/dev/shm"
        fi
    fi
}

perform_remediation

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_mount_option_dev_shm_nosuid'

###############################################################################
# BEGIN fix (88 / 126) for 'xccdf_org.ssgproject.content_rule_disable_users_coredumps'
###############################################################################
(>&2 echo "Remediating rule 88/126: 'xccdf_org.ssgproject.content_rule_disable_users_coredumps'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'libpam-runtime' 2>/dev/null | grep -q '^installed'; then

SECURITY_LIMITS_FILE="/etc/security/limits.conf"

if grep -qE '^\s*\*\s+hard\s+core' $SECURITY_LIMITS_FILE; then
        sed -ri 's/(hard\s+core\s+)[[:digit:]]+/\1 0/' $SECURITY_LIMITS_FILE
else
        echo "*     hard   core    0" >> $SECURITY_LIMITS_FILE
fi

if ls /etc/security/limits.d/*.conf > /dev/null; then
        sed -ri '/^\s*\*\s+hard\s+core/d' /etc/security/limits.d/*.conf
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_disable_users_coredumps'

###############################################################################
# BEGIN fix (89 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_fs_suid_dumpable'
###############################################################################
(>&2 echo "Remediating rule 89/126: 'xccdf_org.ssgproject.content_rule_sysctl_fs_suid_dumpable'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of fs.suid_dumpable from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*fs.suid_dumpable.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "fs.suid_dumpable" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"


#
# Set runtime for fs.suid_dumpable
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w fs.suid_dumpable="0"
fi

#
# If fs.suid_dumpable present in /etc/sysctl.conf, change value to "0"
#	else, add "fs.suid_dumpable = 0" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^fs.suid_dumpable")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "0"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^fs.suid_dumpable\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^fs.suid_dumpable\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_fs_suid_dumpable'

###############################################################################
# BEGIN fix (90 / 126) for 'xccdf_org.ssgproject.content_rule_sysctl_kernel_randomize_va_space'
###############################################################################
(>&2 echo "Remediating rule 90/126: 'xccdf_org.ssgproject.content_rule_sysctl_kernel_randomize_va_space'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# Comment out any occurrences of kernel.randomize_va_space from /etc/sysctl.d/*.conf files

for f in /etc/sysctl.d/*.conf /run/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf; do


  # skip systemd-sysctl symlink (/etc/sysctl.d/99-sysctl.conf -> /etc/sysctl.conf)
  if [[ "$(readlink -f "$f")" == "/etc/sysctl.conf" ]]; then continue; fi

  matching_list=$(grep -P '^(?!#).*[\s]*kernel.randomize_va_space.*$' $f | uniq )
  if ! test -z "$matching_list"; then
    while IFS= read -r entry; do
      escaped_entry=$(sed -e 's|/|\\/|g' <<< "$entry")
      # comment out "kernel.randomize_va_space" matches to preserve user data
      sed -i --follow-symlinks "s/^${escaped_entry}$/# &/g" $f
    done <<< "$matching_list"
  fi
done

#
# Set sysctl config file which to save the desired value
#

SYSCONFIG_FILE="/etc/sysctl.conf"


#
# Set runtime for kernel.randomize_va_space
#
if [[ "$OSCAP_BOOTC_BUILD" != "YES" ]] ; then
    /sbin/sysctl -q -n -w kernel.randomize_va_space="2"
fi

#
# If kernel.randomize_va_space present in /etc/sysctl.conf, change value to "2"
#	else, add "kernel.randomize_va_space = 2" to /etc/sysctl.conf
#

# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^kernel.randomize_va_space")

# shellcheck disable=SC2059
printf -v formatted_output "%s = %s" "$stripped_key" "2"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^kernel.randomize_va_space\\>" "${SYSCONFIG_FILE}"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^kernel.randomize_va_space\\>.*/$escaped_formatted_output/gi" "${SYSCONFIG_FILE}"
else
    if [[ -s "${SYSCONFIG_FILE}" ]] && [[ -n "$(tail -c 1 -- "${SYSCONFIG_FILE}" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "${SYSCONFIG_FILE}"
    fi
    printf '%s\n' "$formatted_output" >> "${SYSCONFIG_FILE}"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sysctl_kernel_randomize_va_space'

###############################################################################
# BEGIN fix (91 / 126) for 'xccdf_org.ssgproject.content_rule_service_apport_disabled'
###############################################################################
(>&2 echo "Remediating rule 91/126: 'xccdf_org.ssgproject.content_rule_service_apport_disabled'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}\n' 'apport' 2>/dev/null | grep -q '^installed'; then

SYSTEMCTL_EXEC='/usr/bin/systemctl'
if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
  "$SYSTEMCTL_EXEC" stop 'apport.service'
fi
"$SYSTEMCTL_EXEC" disable 'apport.service'
"$SYSTEMCTL_EXEC" mask 'apport.service'
# Disable socket activation if we have a unit file for it
if "$SYSTEMCTL_EXEC" -q list-unit-files apport.socket; then
    if [[ $("$SYSTEMCTL_EXEC" is-system-running) != "offline" ]]; then
      "$SYSTEMCTL_EXEC" stop 'apport.socket'
    fi
    "$SYSTEMCTL_EXEC" mask 'apport.socket'
fi
# The service may not be running because it has been started and failed,
# so let's reset the state so OVAL checks pass.
# Service should be 'inactive', not 'failed' after reboot though.
"$SYSTEMCTL_EXEC" reset-failed 'apport.service' || true

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_service_apport_disabled'

###############################################################################
# BEGIN fix (92 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_d'
###############################################################################
(>&2 echo "Remediating rule 92/126: 'xccdf_org.ssgproject.content_rule_file_permissions_cron_d'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

find -H /etc/cron.d/ -maxdepth 1 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_d'

###############################################################################
# BEGIN fix (93 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_daily'
###############################################################################
(>&2 echo "Remediating rule 93/126: 'xccdf_org.ssgproject.content_rule_file_permissions_cron_daily'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

find -H /etc/cron.daily/ -maxdepth 1 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_daily'

###############################################################################
# BEGIN fix (94 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_hourly'
###############################################################################
(>&2 echo "Remediating rule 94/126: 'xccdf_org.ssgproject.content_rule_file_permissions_cron_hourly'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

find -H /etc/cron.hourly/ -maxdepth 1 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_hourly'

###############################################################################
# BEGIN fix (95 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_monthly'
###############################################################################
(>&2 echo "Remediating rule 95/126: 'xccdf_org.ssgproject.content_rule_file_permissions_cron_monthly'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

find -H /etc/cron.monthly/ -maxdepth 1 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_monthly'

###############################################################################
# BEGIN fix (96 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_weekly'
###############################################################################
(>&2 echo "Remediating rule 96/126: 'xccdf_org.ssgproject.content_rule_file_permissions_cron_weekly'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

find -H /etc/cron.weekly/ -maxdepth 1 -perm /u+s,g+xwrs,o+xwrt -type d -exec chmod u-s,g-xwrs,o-xwrt {} \;

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_cron_weekly'

###############################################################################
# BEGIN fix (97 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_crontab'
###############################################################################
(>&2 echo "Remediating rule 97/126: 'xccdf_org.ssgproject.content_rule_file_permissions_crontab'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

chmod u-xs,g-xwrs,o-xwrt /etc/crontab

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_crontab'

###############################################################################
# BEGIN fix (98 / 126) for 'xccdf_org.ssgproject.content_rule_package_nfs-kernel-server_removed'
###############################################################################
(>&2 echo "Remediating rule 98/126: 'xccdf_org.ssgproject.content_rule_package_nfs-kernel-server_removed'")

# CAUTION: This remediation script will remove nfs-kernel-server
#	   from the system, and may remove any packages
#	   that depend on nfs-kernel-server. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "nfs-kernel-server"
# END fix for 'xccdf_org.ssgproject.content_rule_package_nfs-kernel-server_removed'

###############################################################################
# BEGIN fix (99 / 126) for 'xccdf_org.ssgproject.content_rule_package_rpcbind_removed'
###############################################################################
(>&2 echo "Remediating rule 99/126: 'xccdf_org.ssgproject.content_rule_package_rpcbind_removed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

# CAUTION: This remediation script will remove rpcbind
#	   from the system, and may remove any packages
#	   that depend on rpcbind. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "rpcbind"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_rpcbind_removed'

###############################################################################
# BEGIN fix (100 / 126) for 'xccdf_org.ssgproject.content_rule_package_timesyncd_installed'
###############################################################################
(>&2 echo "Remediating rule 100/126: 'xccdf_org.ssgproject.content_rule_package_timesyncd_installed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "systemd-timesyncd"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_timesyncd_installed'

###############################################################################
# BEGIN fix (101 / 126) for 'xccdf_org.ssgproject.content_rule_ntpd_run_as_ntp_user'
###############################################################################
(>&2 echo "Remediating rule 101/126: 'xccdf_org.ssgproject.content_rule_ntpd_run_as_ntp_user'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed && { dpkg-query --show --showformat='${db:Status-Status}\n' 'ntp' 2>/dev/null | grep -q '^installed'; }; then

if grep -q 'OPTIONS=.*' /etc/sysconfig/ntpd; then
	# trying to solve cases where the parameter after OPTIONS
	#may or may not be enclosed in quotes
	sed -i -E 's/^([\s]*OPTIONS=["]?[^"]*)("?)/\1 -u ntp:ntp\2/' /etc/sysconfig/ntpd
else
	echo 'OPTIONS="-u ntp:ntp"' >> /etc/sysconfig/ntpd
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_ntpd_run_as_ntp_user'

###############################################################################
# BEGIN fix (102 / 126) for 'xccdf_org.ssgproject.content_rule_package_rsync_removed'
###############################################################################
(>&2 echo "Remediating rule 102/126: 'xccdf_org.ssgproject.content_rule_package_rsync_removed'")

# CAUTION: This remediation script will remove rsync
#	   from the system, and may remove any packages
#	   that depend on rsync. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "rsync"
# END fix for 'xccdf_org.ssgproject.content_rule_package_rsync_removed'

###############################################################################
# BEGIN fix (103 / 126) for 'xccdf_org.ssgproject.content_rule_package_telnet_removed'
###############################################################################
(>&2 echo "Remediating rule 103/126: 'xccdf_org.ssgproject.content_rule_package_telnet_removed'")

# CAUTION: This remediation script will remove telnet
#	   from the system, and may remove any packages
#	   that depend on telnet. Execute this
#	   remediation AFTER testing on a non-production
#	   system!

DEBIAN_FRONTEND=noninteractive apt-get remove -y "telnet"
# END fix for 'xccdf_org.ssgproject.content_rule_package_telnet_removed'

###############################################################################
# BEGIN fix (104 / 126) for 'xccdf_org.ssgproject.content_rule_file_permissions_sshd_config'
###############################################################################
(>&2 echo "Remediating rule 104/126: 'xccdf_org.ssgproject.content_rule_file_permissions_sshd_config'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

chmod u-xs,g-xwrs,o-xwrt /etc/ssh/sshd_config

chmod u-xs,g-xwrs,o-xwrt /etc/ssh/sshd_config.d

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_file_permissions_sshd_config'

###############################################################################
# BEGIN fix (105 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_keepalive'
###############################################################################
(>&2 echo "Remediating rule 105/126: 'xccdf_org.ssgproject.content_rule_sshd_set_keepalive'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

var_sshd_set_keepalive='3'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*ClientAliveCountMax\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*ClientAliveCountMax\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*ClientAliveCountMax\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "ClientAliveCountMax $var_sshd_set_keepalive" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_keepalive'

###############################################################################
# BEGIN fix (106 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_idle_timeout'
###############################################################################
(>&2 echo "Remediating rule 106/126: 'xccdf_org.ssgproject.content_rule_sshd_set_idle_timeout'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

sshd_idle_timeout_value='300'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*ClientAliveInterval\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*ClientAliveInterval\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*ClientAliveInterval\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "ClientAliveInterval $sshd_idle_timeout_value" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_idle_timeout'

###############################################################################
# BEGIN fix (107 / 126) for 'xccdf_org.ssgproject.content_rule_disable_host_auth'
###############################################################################
(>&2 echo "Remediating rule 107/126: 'xccdf_org.ssgproject.content_rule_disable_host_auth'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*HostbasedAuthentication\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*HostbasedAuthentication\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*HostbasedAuthentication\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "HostbasedAuthentication no" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_disable_host_auth'

###############################################################################
# BEGIN fix (108 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_disable_empty_passwords'
###############################################################################
(>&2 echo "Remediating rule 108/126: 'xccdf_org.ssgproject.content_rule_sshd_disable_empty_passwords'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*PermitEmptyPasswords\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*PermitEmptyPasswords\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*PermitEmptyPasswords\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "PermitEmptyPasswords no" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_disable_empty_passwords'

###############################################################################
# BEGIN fix (109 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_disable_rhosts'
###############################################################################
(>&2 echo "Remediating rule 109/126: 'xccdf_org.ssgproject.content_rule_sshd_disable_rhosts'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*IgnoreRhosts\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*IgnoreRhosts\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*IgnoreRhosts\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "IgnoreRhosts yes" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_disable_rhosts'

###############################################################################
# BEGIN fix (110 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_disable_root_login'
###############################################################################
(>&2 echo "Remediating rule 110/126: 'xccdf_org.ssgproject.content_rule_sshd_disable_root_login'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*PermitRootLogin\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*PermitRootLogin\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*PermitRootLogin\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "PermitRootLogin no" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_disable_root_login'

###############################################################################
# BEGIN fix (111 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_disable_tcp_forwarding'
###############################################################################
(>&2 echo "Remediating rule 111/126: 'xccdf_org.ssgproject.content_rule_sshd_disable_tcp_forwarding'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*AllowTcpForwarding\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*AllowTcpForwarding\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*AllowTcpForwarding\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "AllowTcpForwarding no" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_disable_tcp_forwarding'

###############################################################################
# BEGIN fix (112 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_disable_x11_forwarding'
###############################################################################
(>&2 echo "Remediating rule 112/126: 'xccdf_org.ssgproject.content_rule_sshd_disable_x11_forwarding'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*X11Forwarding\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*X11Forwarding\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*X11Forwarding\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "X11Forwarding no" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_disable_x11_forwarding'

###############################################################################
# BEGIN fix (113 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_do_not_permit_user_env'
###############################################################################
(>&2 echo "Remediating rule 113/126: 'xccdf_org.ssgproject.content_rule_sshd_do_not_permit_user_env'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*PermitUserEnvironment\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*PermitUserEnvironment\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*PermitUserEnvironment\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "PermitUserEnvironment no" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_do_not_permit_user_env'

###############################################################################
# BEGIN fix (114 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_enable_warning_banner_net'
###############################################################################
(>&2 echo "Remediating rule 114/126: 'xccdf_org.ssgproject.content_rule_sshd_enable_warning_banner_net'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*Banner\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*Banner\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*Banner\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "Banner /etc/issue.net" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_enable_warning_banner_net'

###############################################################################
# BEGIN fix (115 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_limit_user_access'
###############################################################################
(>&2 echo "Remediating rule 115/126: 'xccdf_org.ssgproject.content_rule_sshd_limit_user_access'")
(>&2 echo "FIX FOR THIS RULE 'xccdf_org.ssgproject.content_rule_sshd_limit_user_access' IS MISSING!")
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_limit_user_access'

###############################################################################
# BEGIN fix (116 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_login_grace_time'
###############################################################################
(>&2 echo "Remediating rule 116/126: 'xccdf_org.ssgproject.content_rule_sshd_set_login_grace_time'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

var_sshd_set_login_grace_time='60'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*LoginGraceTime\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*LoginGraceTime\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*LoginGraceTime\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "LoginGraceTime $var_sshd_set_login_grace_time" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_login_grace_time'

###############################################################################
# BEGIN fix (117 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_loglevel_info'
###############################################################################
(>&2 echo "Remediating rule 117/126: 'xccdf_org.ssgproject.content_rule_sshd_set_loglevel_info'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf

LC_ALL=C sed -i "/^\s*LogLevel\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*LogLevel\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*LogLevel\s\+/Id" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
else
    touch "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"

cp "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf" "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "LogLevel INFO" > "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
cat "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak" >> "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/01-complianceascode-reinforce-os-defaults.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_loglevel_info'

###############################################################################
# BEGIN fix (118 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_max_auth_tries'
###############################################################################
(>&2 echo "Remediating rule 118/126: 'xccdf_org.ssgproject.content_rule_sshd_set_max_auth_tries'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

sshd_max_auth_tries_value='4'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*MaxAuthTries\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*MaxAuthTries\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*MaxAuthTries\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "MaxAuthTries $sshd_max_auth_tries_value" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_max_auth_tries'

###############################################################################
# BEGIN fix (119 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_max_sessions'
###############################################################################
(>&2 echo "Remediating rule 119/126: 'xccdf_org.ssgproject.content_rule_sshd_set_max_sessions'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

var_sshd_max_sessions='10'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*MaxSessions\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*MaxSessions\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*MaxSessions\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "MaxSessions $var_sshd_max_sessions" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_max_sessions'

###############################################################################
# BEGIN fix (120 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_set_maxstartups'
###############################################################################
(>&2 echo "Remediating rule 120/126: 'xccdf_org.ssgproject.content_rule_sshd_set_maxstartups'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

var_sshd_set_maxstartups='10:30:60'


mkdir -p /etc/ssh/sshd_config.d
touch /etc/ssh/sshd_config.d/00-complianceascode-hardening.conf

LC_ALL=C sed -i "/^\s*MaxStartups\s\+/Id" "/etc/ssh/sshd_config"
LC_ALL=C sed -i "/^\s*MaxStartups\s\+/Id" "/etc/ssh/sshd_config.d"/*.conf
if [ -e "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" ] ; then
    
    LC_ALL=C sed -i "/^\s*MaxStartups\s\+/Id" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
else
    touch "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"

cp "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf" "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"
# Insert at the beginning of the file
printf '%s\n' "MaxStartups $var_sshd_set_maxstartups" > "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
cat "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak" >> "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.d/00-complianceascode-hardening.conf.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_set_maxstartups'

###############################################################################
# BEGIN fix (121 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_ciphers'
###############################################################################
(>&2 echo "Remediating rule 121/126: 'xccdf_org.ssgproject.content_rule_sshd_use_strong_ciphers'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*Ciphers\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert at the beginning of the file
printf '%s\n' "Ciphers aes128-ctr,aes192-ctr,aes256-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com" > "/etc/ssh/sshd_config"
cat "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_ciphers'

###############################################################################
# BEGIN fix (122 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_kex'
###############################################################################
(>&2 echo "Remediating rule 122/126: 'xccdf_org.ssgproject.content_rule_sshd_use_strong_kex'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

sshd_strong_kex='curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256'


if [ -e "/etc/ssh/sshd_config" ] ; then
    
    LC_ALL=C sed -i "/^\s*KexAlgorithms\s\+/Id" "/etc/ssh/sshd_config"
else
    touch "/etc/ssh/sshd_config"
fi
# make sure file has newline at the end
sed -i -e '$a\' "/etc/ssh/sshd_config"

cp "/etc/ssh/sshd_config" "/etc/ssh/sshd_config.bak"
# Insert at the beginning of the file
printf '%s\n' "KexAlgorithms $sshd_strong_kex" > "/etc/ssh/sshd_config"
cat "/etc/ssh/sshd_config.bak" >> "/etc/ssh/sshd_config"
# Clean up after ourselves.
rm "/etc/ssh/sshd_config.bak"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_kex'

###############################################################################
# BEGIN fix (123 / 126) for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_macs'
###############################################################################
(>&2 echo "Remediating rule 123/126: 'xccdf_org.ssgproject.content_rule_sshd_use_strong_macs'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

sshd_strong_macs='hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256'


# Strip any search characters in the key arg so that the key can be replaced without
# adding any search characters to the config file.
stripped_key=$(sed 's/[\^=\$,;+]*//g' <<< "^MACs")

# shellcheck disable=SC2059
printf -v formatted_output "%s %s" "$stripped_key" "$sshd_strong_macs"

# If the key exists, change it. Otherwise, add it to the config_file.
# We search for the key string followed by a word boundary (matched by \>),
# so if we search for 'setting', 'setting2' won't match.
if LC_ALL=C grep -q -m 1 -i -e "^MACs\\>" "/etc/ssh/sshd_config"; then
    escaped_formatted_output=$(sed -e 's|/|\\/|g' <<< "$formatted_output")
    LC_ALL=C sed -i --follow-symlinks "s/^MACs\\>.*/$escaped_formatted_output/gi" "/etc/ssh/sshd_config"
else
    if [[ -s "/etc/ssh/sshd_config" ]] && [[ -n "$(tail -c 1 -- "/etc/ssh/sshd_config" || true)" ]]; then
        LC_ALL=C sed -i --follow-symlinks '$a'\\ "/etc/ssh/sshd_config"
    fi
    printf '%s\n' "$formatted_output" >> "/etc/ssh/sshd_config"
fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_sshd_use_strong_macs'

###############################################################################
# BEGIN fix (124 / 126) for 'xccdf_org.ssgproject.content_rule_package_audit_installed'
###############################################################################
(>&2 echo "Remediating rule 124/126: 'xccdf_org.ssgproject.content_rule_package_audit_installed'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed; then

DEBIAN_FRONTEND=noninteractive apt-get install -y "auditd"

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_package_audit_installed'

###############################################################################
# BEGIN fix (125 / 126) for 'xccdf_org.ssgproject.content_rule_grub2_audit_argument'
###############################################################################
(>&2 echo "Remediating rule 125/126: 'xccdf_org.ssgproject.content_rule_grub2_audit_argument'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed && { dpkg-query --show --showformat='${db:Status-Status}\n' 'grub2-common' 2>/dev/null | grep -q '^installed'; }; then

expected_value="1"


if [[ "$OSCAP_BOOTC_BUILD" == "YES" ]] ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "audit" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"audit=[^\"]*\"(.*]\s*)/\1\"audit=$expected_value\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"audit=$expected_value\"]" >> "$KARGS_DIR/10-audit.toml"
    fi
else


    # Correct the form of default kernel command line in GRUB
    if grep -q '^\s*GRUB_CMDLINE_LINUX=.*audit=.*"'  '/etc/default/grub' ; then
           # modify the GRUB command-line if an audit= arg already exists
           sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)audit=[^[:space:]]\+\(.*\"\)/\1audit=1\2/"  '/etc/default/grub'
    # Add to already existing GRUB_CMDLINE_LINUX parameters
    elif grep -q '^\s*GRUB_CMDLINE_LINUX='  '/etc/default/grub' ; then
           # no audit=arg is present, append it
           sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)\"/\1 audit=1\"/"  '/etc/default/grub'
    # Add GRUB_CMDLINE_LINUX parameters line
    else
           echo "GRUB_CMDLINE_LINUX=\"audit=1\"" >> '/etc/default/grub'
    fi
    update-grub 

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_grub2_audit_argument'

###############################################################################
# BEGIN fix (126 / 126) for 'xccdf_org.ssgproject.content_rule_grub2_audit_backlog_limit_argument'
###############################################################################
(>&2 echo "Remediating rule 126/126: 'xccdf_org.ssgproject.content_rule_grub2_audit_backlog_limit_argument'")
# Remediation is applicable only in certain platforms
if dpkg-query --show --showformat='${db:Status-Status}
' 'linux-base' 2>/dev/null | grep -q ^installed && { dpkg-query --show --showformat='${db:Status-Status}\n' 'grub2-common' 2>/dev/null | grep -q '^installed'; }; then

expected_value="8192"


if [[ "$OSCAP_BOOTC_BUILD" == "YES" ]] ; then
    KARGS_DIR="/usr/lib/bootc/kargs.d/"
    if grep -q -E "audit_backlog_limit" "$KARGS_DIR/*.toml" ; then
        sed -i -E "s/^(\s*kargs\s*=\s*\[.*)\"audit_backlog_limit=[^\"]*\"(.*]\s*)/\1\"audit_backlog_limit=$expected_value\"\2/" "$KARGS_DIR/*.toml"
    else
        echo "kargs = [\"audit_backlog_limit=$expected_value\"]" >> "$KARGS_DIR/10-audit_backlog_limit.toml"
    fi
else


    # Correct the form of default kernel command line in GRUB
    if grep -q '^\s*GRUB_CMDLINE_LINUX=.*audit_backlog_limit=.*"'  '/etc/default/grub' ; then
           # modify the GRUB command-line if an audit_backlog_limit= arg already exists
           sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)audit_backlog_limit=[^[:space:]]\+\(.*\"\)/\1audit_backlog_limit=8192\2/"  '/etc/default/grub'
    # Add to already existing GRUB_CMDLINE_LINUX parameters
    elif grep -q '^\s*GRUB_CMDLINE_LINUX='  '/etc/default/grub' ; then
           # no audit_backlog_limit=arg is present, append it
           sed -i "s/\(^\s*GRUB_CMDLINE_LINUX=\".*\)\"/\1 audit_backlog_limit=8192\"/"  '/etc/default/grub'
    # Add GRUB_CMDLINE_LINUX parameters line
    else
           echo "GRUB_CMDLINE_LINUX=\"audit_backlog_limit=8192\"" >> '/etc/default/grub'
    fi
    update-grub 

fi

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi
# END fix for 'xccdf_org.ssgproject.content_rule_grub2_audit_backlog_limit_argument'

