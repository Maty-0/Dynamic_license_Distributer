<#
Made by: Matyas Engelen
Note: Because this solution was made for floating virtual machines I didnt need to remove the reg key from the device.
#>

#Config

    #You will need to use a file share that the users can access, this folder is a demo.
$License_Not_In_use = "Test_License_fileShare\not_in_use"
$License_In_use = "Test_License_fileShare\in_use"

#Get cached key
$key = Get-ChildItem -Path C:\temp | Select-Object -ExpandProperty BaseName -first 1 

#Move key to not in use/cache user key
Move-Item -Path $License_In_use\$key@$env:UserName.reg -Destination $License_Not_In_use\$key.reg 
