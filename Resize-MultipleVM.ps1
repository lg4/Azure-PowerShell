
<#
.SYNOPSIS
    This script will gather all VMs in a subscription and resize them according to a defined set of VM types.
.DESCRIPTION
    Gathering all VM's and using a switch statement to assign the new VM size, followed by an Update-AzureRmVM command.
.EXAMPLE
    PS >> Resize-MultipleVM.ps1
.NOTES
    AUTHORS: Lou Garramone
    LASTEDIT: 10-4-2018
#>

####    Declare Variables      ####
#Get all VMs
$AllVM = Get-AzureRmVM
####    End Declare Variables  ####

# Take each VM from $AllVM and run it through the if loop to resize it appropriately.
foreach ($VM in $allVM){
    switch($VM.HardwareProfile.VmSize){
        "Basic_A1"          {$VM.HardwareProfile.VmSize = "Standard_B1ms"}
        "Standard_F2s_v2"   {$VM.HardwareProfile.VmSize = "Standard_A2_v2"}
        "Standard_D2s_v3"   {$VM.HardwareProfile.VmSize = "Standard_A4_v2"}
    }

# Update the Virtual Machine to the new size
Update-AzureRmVM -VM $VM -ResourceGroupName $VM.ResourceGroupname -whatif  

Start-Sleep -Seconds 1
$VM

}