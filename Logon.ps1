<#
Made by: Matyas Engelen
#>

#Config

#You will need to use a file share that the users can access, this folder is a demo.
$License_Not_In_use = "D:\Coding\Powershell\Dynamic_Licensing\Test_License_fileShare\not_in_use"
$License_In_use = "D:\Coding\Powershell\Dynamic_Licensing\Test_License_fileShare\in_use"

#If for some reason the log off task fails, this will take care of it.
Get-ChildItem $License_In_use -Filter "*@$env:UserName.reg" | 
ForEach-Object {

    #Lets remove the path and our username from the string. 
    $Found_File = $_.FullName
    $Found_File_key = $Found_File.Replace("@$env:UserName", "")
    $Found_File_key = $Found_File_key.Replace("$License_In_use\", "")

    Write-Host "Found Key: $Found_File_key"
    Move-Item -Path $Found_File -Destination $License_Not_In_use\$Found_File_key 
}

#Get first availabe license key
$key = Get-ChildItem -Path $License_Not_In_use | Select-Object -ExpandProperty BaseName -first 1 

#Move key to in use/cache user key
Move-Item -Path $License_Not_In_use\$key.reg -Destination $License_In_use\$key@$env:UserName.reg

    #The temp data of de license caching wil be stored under c:\temp, feel free to change this
Copy-Item $License_In_use\$key@$env:UserName.reg -Destination C:\temp\$key.reg

#Run reg
reg import C:\temp\$key@$env:UserName.reg 
