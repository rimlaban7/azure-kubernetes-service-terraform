import {
  to = module.resource_group.azurerm_resource_group.resource_group
  id = var.resource_group_import_id
}

import {
  to = module.storage_account.azurerm_storage_account.storage_account
  id = var.storage_account_import_id
}
