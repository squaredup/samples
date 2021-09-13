Select 
	vme.DisplayName,
	vme.Path,	
	vmet.ManagedEntityTypeDefaultName as 'Class',	
	vmm.StartDateTime as 'Start',	
	vmm.EndDateTime as 'End',
	CASE vmm.PlannedMaintenanceInd
		WHEN '1' THEN 'Scheduled'
		WHEN '0' THEN 'Unscheduled'
	END AS 'Outage',
	CASE vmmh.ReasonCode
		WHEN '0' THEN 'Other (Planned)' 
		WHEN '1' THEN 'Other (Unplanned)' 
		WHEN '2' THEN 'Hardware: Maintenance (Planned)' 
		WHEN '3' THEN 'Hardware: Maintenance (Unplanned)' 
		WHEN '4' THEN 'Hardware: Installation (Planned)' 
		WHEN '5' THEN 'Hardware: Installation (Unplanned)' 
		WHEN '6' THEN 'Operating System: Reconfiguration (Planned)' 
		WHEN '7' THEN 'Operating System: Reconfiguration (Unplanned)' 
		WHEN '8' THEN 'Application: Maintenance (Planned)' 
		WHEN '9' THEN 'Application: Maintenance (Unplanned)' 
		WHEN '10' THEN 'Application: Installation (Planned)' 
		WHEN '11' THEN 'Application: Unresponsive' 
		WHEN '12' THEN 'Application:  Unstable' 
		WHEN '13' THEN 'Security Issue' 
		WHEN '14' THEN 'Loss of network connectivity (Unplanned)' 
	END AS 'Type',
	vmmh.Comment as Reason,
	vmmh.UserId as 'User'
	
FROM vMaintenanceMode as vmm
	INNER JOIN vManagedEntity as vme on vmm.ManagedEntityRowId = vme.ManagedEntityRowId
	INNER JOIN vMaintenanceModeHistory as vmmh on vmm.MaintenanceModeRowId = vmmh.MaintenanceModeRowId
	INNER JOIN vManagedEntityType as vmet on vmet.ManagedEntityTypeRowId = vme.ManagedEntityTypeRowId

-- Add your class here
WHERE vmet.ManagedEntityTypeDefaultName = 'Windows Computer' 

AND (vmm.EndDateTime >=  GETDATE() OR vmm.EndDateTime IS NULL)
order by vmm.StartDateTime desc
