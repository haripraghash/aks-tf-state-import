#!/bin/bash

piper_states=("module.piper_aks.azuread_application.aks" "module.piper_aks.azuread_service_principal.aks" 
"module.piper_aks.azuread_application_password.aks" "module.piper_aks.azuread_service_principal_password.aks")

for state in ${piper_states[@]}; do
  echo "Importing state for $state"
  resource=$(terraform state list | grep $state)
  if [ -z "$resource" ]; then
    echo "No state found for $state therefore will import"
    terraform import 
  else
    echo "State found for $state"
  fi
done