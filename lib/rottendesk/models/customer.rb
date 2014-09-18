module Rottendesk
  class Customer < Model

    endpoint "customers"
    json_key "customer"


    field :id, readonly: true
    field :name
    field :description
    field :domains
    field :note
    field :sla_policy_id, freshdesk_name: 'sla-policy-id'
    field :cust_identifier, readonly: true, freshdesk_name: 'cust-identifier'

  end
end
