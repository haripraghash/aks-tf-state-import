#!/bin/bash

piper_aad_resources=("module.piper_aks.azuread_application.aks" "module.piper_aks.azuread_service_principal.aks" 
"module.piper_aks.azuread_application_password.aks" "module.piper_aks.azuread_service_principal_password.aks")

for resource in ${piper_aad_resources[@]}; do
  echo "Importing state for $resource"
  existingresource=$(terraform state list | grep $resource)
  if [ -z "$existingresource" ]; then
    echo "No state found for $resource therefore will import"
    echo "${OLD_STATE_PATH}/${OLD_STATE_FILE_NAME}"
    ls -la ${OLD_STATE_PATH}/${OLD_STATE_FILE_NAME}
    terraform show -json "${OLD_STATE_PATH}/${OLD_STATE_FILE_NAME}" 
    echo "${resource}"
    resource_id=$(terraform show -json "${OLD_STATE_PATH}/${OLD_STATE_FILE_NAME}" | jq --compact-output --raw-output '.values.root_module.child_modules[].resources[] | select (.address == ${resource}).values.id') 
    terraform import "${resource}" "${resource_id}"
  else
    echo "State found for $state"
  fi
done