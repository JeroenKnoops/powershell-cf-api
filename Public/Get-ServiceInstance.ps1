<#
.Synopsis
   Gets the CloudFoundry Get-ServiceInstance by name
.DESCRIPTION
   The Get-ServiceInstance cmdlet gets a service instance objects from the CloudFoundry API as defined by the API.
.PARAMETER Space
    This parameter is the Space object
.PARAMETER Name
    This parameter is the name of the service instance
.EXAMPLE
   Get-Space "myspace" | Get-ServiceInstance -Name "mymetrics" | ConvertTo-Json
#>
function Get-ServiceInstance {

    [CmdletBinding()]
    [OutputType([psobject])]
    param(
        [Parameter( Position = 0, Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [psobject]
        $Space,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [psobject]
        $Name
    )

    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }

    process {
        Write-Debug "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"
        $summary = Get-SpaceSummary $space
        Write-Debug $summary | ConvertTo-Json
        Write-Output (@($summary.services | Where-Object {$_.name -eq $name})[0])
    }

    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }    
}
