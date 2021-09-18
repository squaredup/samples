Select COUNT(*)
	
FROM vMaintenanceMode as vmm
	INNER JOIN vManagedEntity as vme on vmm.ManagedEntityRowId = vme.ManagedEntityRowId
	INNER JOIN vMaintenanceModeHistory as vmmh on vmm.MaintenanceModeRowId = vmmh.MaintenanceModeRowId
	INNER JOIN vManagedEntityType as vmet on vmet.ManagedEntityTypeRowId = vme.ManagedEntityTypeRowId

-- Add your class here
WHERE vmet.ManagedEntityTypeDefaultName = 'Windows Computer' 

AND (vmm.EndDateTime >=  GETDATE() OR vmm.EndDateTime IS NULL)
