require ["variables", "envelope", "fileinto", "vnd.dovecot.filter", "subaddress"];
if envelope :user :matches "to" "*" {
	set :lower "user" "${1}";
	if envelope :domain :matches "to" "*" {
		set :lower "domain" "${1}";
		set "my_recipient" "${user}@${domain}";
        	filter "gpgit" "${my_recipient}";
        	fileinto "INBOX";
	}
}
