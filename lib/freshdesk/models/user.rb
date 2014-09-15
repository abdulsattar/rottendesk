module Freshdesk
  class User < Model

    endpoint "contacts"
    json_key "user"

    field :id
    field :name
    field :email
    field :address
    field :description
    field :job_title
    field :twitter_id
    field :fb_profile_if
    field :phone
    field :mobile
    field :language
    field :time_zone
    field :customer_id
    field :deleted
    field :helpdesk_agent
    field :active

  end
end
