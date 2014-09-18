module Rottendesk
  class Ticket < Model

    endpoint "helpdesk/tickets"
    json_key "helpdesk_ticket"

    field :id, readonly: true

    field :display_id, readonly: true
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
    field :attachments, readonly: true

    timestamps

    class << self
      def filter(filter_name)
        default_filters("filter/#{filter_name}")
      end

      def requester(requester_id)
        default_filters("filter/requester/#{requester_id}")
      end

      def view(view_id)
        default_filters("view/#{view_id}")
      end

      private
      def default_filters(url)
        parse(app.client.get("#{get_endpoint}/#{url}", params: {format: :json}, append_json: false))
      end
    end
  end
end
