require ["variables", "envelope", "fileinto", "vnd.dovecot.filter"];
if envelope :matches "to" "*" {
        set :lower "my_recipient" "${1}";
        filter "gpgit" "${my_recipient}";
        fileinto "INBOX";
}
