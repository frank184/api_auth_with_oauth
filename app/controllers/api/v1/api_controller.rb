module Api::V1
  class ApiController < ::ApplicationController
    private

    helper_method :current_resource_owner
    def current_resource_owner
      @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def doorkeeper_unauthorized_render_options(_)
      { json: { error: 'Unauthorized' }, status: 401 }
    end

    def doorkeeper_forbidden_render_options(_)
      { json: { error: 'Forbidden' }, status: 403 }
    end
  end
end
