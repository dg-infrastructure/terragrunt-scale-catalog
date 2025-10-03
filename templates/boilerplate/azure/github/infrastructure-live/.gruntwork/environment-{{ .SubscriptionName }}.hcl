environment "{{ .SubscriptionName }}" {
  filter {
    paths = ["{{ .SubscriptionName }}/*"]
  }

  authentication {
    azure_oidc {
      tenant_id       = "{{ .AzureTenantID }}"
      subscription_id = "{{ .AzureSubscriptionID }}"

      plan_client_id  = "" # FIXME: Fill in the client ID for the plan application after bootstrapping
      apply_client_id = "" # FIXME: Fill in the client ID for the apply application after bootstrapping
    }
  }
}

