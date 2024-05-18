resource "random_pet" "rg_name" {
  length = 2
}

resource "azurerm_resource_group" "rg" {
  name     = "${random_pet.rg_name.id}-rg"
  location = var.location
}

resource "random_pet" "aks_cluster_name" {
  length = 2
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = random_pet.aks_cluster_name.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${random_pet.aks_cluster_name.id}aks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}