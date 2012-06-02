

USING_CREDENTIAL= Transform /(.+) credential$/  do |credential_type|

 table(%{
     |form_email    | #{$info[credential_type]['username']} |
     |form_password | #{$info[credential_type]['password']} |
    })
 end