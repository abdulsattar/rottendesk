module Freshdesk
  class Ticket < Model

    endpoint "helpdesk/tickets"
    json_key "helpdesk_ticket"

    field :display_id
    field :email
    field :requester_id
    field :subject
    field :description
    field :description_html
    field :status
    field :priority
    field :source
    field :deleted
    field :spam
    field :responder_id
    field :group_id
    field :ticket_type
    field :cc_email
    field :email_config_id
    field :isescalated
    field :due_by
    field :id
    field :attachments

  end
end
