import-csv -path c:\TEMP\users.csv | foreach {
 
$givenName = $_.name.split()[0] 
$surname = $_.name.split()[1]
 
new-aduser -name $_.name -enabled $true –givenName $givenName –surname $surname -accountpassword (convertto-securestring $_.password -asplaintext -force) -samaccountname $_.samaccountname –userprincipalname ($_.samaccountname+"@wvu.com")
}