{ ... }:
let
  cyonmail =
    {
      address,
      name,
      primary ? false,
    }:
    {
      primary = primary;
      address = address;
      realName = name;
      userName = address;
      passwordCommand = "";
      flavor = "plain";
      imap = {
        host = "mail.cyon.ch";
        port = 993;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      smtp = {
        host = "mail.cyon.ch";
        port = 465;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      thunderbird.enable = true;
    };
in
{
  accounts.email.accounts = {
    "hi@stehlik.software" = cyonmail {
      address = "hi@stehlik.software";
      name = "Stehlik Artisan Software";
    };
    "jen@stehlik.software" = cyonmail {
      address = "jen@stehlik.software";
      name = "Jen Stehlik";
      primary = true;
    };

    "jen@kabelsalat.ch" = {
      primary = false;
      address = "jen@kabelsalat.ch";
      realName = "Jen";
      userName = "jen@kabelsalat.ch";
      passwordCommand = "";
      flavor = "plain";
      imap = {
        host = "imap.kabelsalat.ch";
        port = 993;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      smtp = {
        host = "smtp.kabelsalat.ch";
        port = 465;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      thunderbird.enable = true;
    };
  };
}
