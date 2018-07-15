Import-Module -Name Vmware.VimAutomation.Core
New-Alias -Name "tc" -Value Test-Connection

function Mount-Datastore([String]$Datastore){
    $ErrorActionPreference = $false
    if( "ds" -in (Get-PSDrive).name){
        Remove-PSDrive -Name "ds"
    }
    New-PSDrive -Name "ds" -PSProvider VimDatastore -Root  \ -Location (Get-Datastore -Name $Datastore) -Scope Global
}

function EnterSelfSigned-PSSession([String]$Computer){
     Enter-PSSession $Computer -Credential (Get-Credential) -Authentication Basic -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck)
}

function Accept-HostKey([parameter(Position=0)][string[]]$computers){
    foreach($computer in $computers){
        Write-Output "y" | plink.exe $computer
    }
}